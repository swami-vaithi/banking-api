#!/bin/bash
export DJANGO_SETTINGS_MODULE=banking.settings.production
export PYTHONUNBUFFERED=0
mkdir -p /home/uid1000/banking
mkdir -p /home/uid1000/banking/logs
mkdir -p /home/uid1000/banking/run
mkdir -p /home/uid1000/banking/static
chmod -R 777 /home/uid1000/banking/run
python3 manage.py migrate
python3 manage.py collectstatic --noinput
gunicorn banking.wsgi:application --log-level=info --bind=unix:/home/uid1000/banking/run/server.sock -w 3
# exec uwsgi --http 0.0.0.0:8010 --wsgi-file /opt/code/banking/banking/wsgi.py --master --processes 4 --threads 2
