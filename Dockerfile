FROM centos:6

RUN yum install -y mysql mysql-server
RUN mysql_install_db --datadir=/var/lib/mysql --user=mysql

RUN echo "NETWORKING=yes" > /etc/sysconfig/network
RUN echo -e "\nbind-address = 0.0.0.0" >> /etc/my.cnf
RUN echo -e "\nmysqld_safe: 172.17.0.1" >> /etc/hosts.allow
RUN echo -e "\nmysqld: 172.17.0.1" >> /etc/hosts.allow

ADD ./setup.sql ./setup.sql
# RUN /usr/bin/mysqld_safe & sleep 10s & cat setup.sql | mysql
# RUN sed -i -e"s/^bind-address\s*=\s*127.0.0.1/bind-address = 0.0.0.0/" /etc/my.cnf

EXPOSE 13306

CMD ["/usr/bin/mysqld_safe"]