From: aik@ozlabs.ru (Alexey Kardashevskiy)
Date: Mon, 14 Aug 2017 01:09:15 +1000
Subject: SUN8I_EMAC driver wanted (for Orange Pi)
Message-ID: <3792055e-d56f-e722-d9f8-519b46fd73dd@ozlabs.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

I have been using v4.8 with some driver I found somewhere. Ported to v4.13,
it does not work anymore and I wonder if anyone has an idea where to get a
working one from?

It is for Orange Pi PC v1.3.

Thanks!

"Does not work" means:

root at aikopi3:~# ls -l /sys/class/net/
total 0
lrwxrwxrwx 1 root root 0 Feb 12 04:32 eth0 ->
../../devices/platform/soc/1c30000.ethernet/net/eth0
lrwxrwxrwx 1 root root 0 Feb 12 04:32 lo -> ../../devices/virtual/net/lo
root at aikopi3:~#
root at aikopi3:~#
root at aikopi3:~#
root at aikopi3:~#
root at aikopi3:~# ip addr
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group
default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
2: eth0: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc pfifo_fast
state DOWN group default qlen 1000
    link/ether 02:20:76:db:bd:25 brd ff:ff:ff:ff:ff:ff
root at aikopi3:~#
root at aikopi3:~# dhclient -v eth0
Internet Systems Consortium DHCP Client 4.3.3
Copyright 2004-2015 Internet Systems Consortium.
All rights reserved.
For info, please visit https://www.isc.org/software/dhcp/

Listening on LPF/eth0/02:20:76:db:bd:25
Sending on   LPF/eth0/02:20:76:db:bd:25
Sending on   Socket/fallback
DHCPREQUEST of 192.168.10.82 on eth0 to 255.255.255.255 port 67
(xid=0x4eef31e4)
DHCPREQUEST of 192.168.10.82 on eth0 to 255.255.255.255 port 67
(xid=0x4eef31e4)
^C



-- 
Alexey
