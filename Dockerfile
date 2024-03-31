FROM debian:bullseye
MAINTAINER yohan <783b8c87@scimetis.net>
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && apt-get -y install apache2
ENV TZ=Europe/Paris
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
COPY apache2.conf /etc/apache2/
RUN a2enmod proxy_fcgi
COPY fpm.conf /etc/apache2/sites-available/
RUN a2ensite fpm.conf
ENTRYPOINT ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
