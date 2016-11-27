From: andrew@lunn.ch (Andrew Lunn)
Date: Sun, 27 Nov 2016 17:14:33 +0100
Subject: [PATCH v5 2/2] ARM: dts: add support for Turris Omnia
In-Reply-To: <da10966e-0e5f-9254-57d3-9dd4b7f2be32@suse.de>
References: <20161125142658.21690-1-uwe@kleine-koenig.org>
 <20161125142658.21690-3-uwe@kleine-koenig.org>
 <87lgw7ilg9.fsf@free-electrons.com>
 <a7f47999-ec83-6cc8-8119-0087dee17bac@suse.de>
 <1fc18002-0144-8300-1888-09f456860ef0@kleine-koenig.org>
 <da10966e-0e5f-9254-57d3-9dd4b7f2be32@suse.de>
Message-ID: <20161127161433.GE4574@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> omnia:~ # ip a
> 1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN
> group default qlen 1
>     link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
>     inet 127.0.0.1/8 scope host lo
>        valid_lft forever preferred_lft forever
>     inet6 ::1/128 scope host
>        valid_lft forever preferred_lft forever
> 2: eth0: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN group
> default qlen 532
>     link/ether d8:58:d7:00:61:70 brd ff:ff:ff:ff:ff:ff
> 3: eth1: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN group
> default qlen 532
>     link/ether d8:58:d7:00:61:6e brd ff:ff:ff:ff:ff:ff
> 4: eth2: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state UP
> group default qlen 532
>     link/ether d8:58:d7:00:61:6f brd ff:ff:ff:ff:ff:ff
>     inet 192.168.1.50/24 brd 192.168.1.255 scope global eth2
>        valid_lft forever preferred_lft forever
>     inet6 2003:86:6702:9f00:da58:d7ff:fe00:616f/64 scope global
> mngtmpaddr dynamic
>        valid_lft 7050sec preferred_lft 1650sec
>     inet6 fe80::da58:d7ff:fe00:616f/64 scope link
>        valid_lft forever preferred_lft forever
> 5: sit0 at NONE: <NOARP> mtu 1480 qdisc noop state DOWN group default qlen 1
>     link/sit 0.0.0.0 brd 0.0.0.0
> 6: lan0 at eth1: <BROADCAST,MULTICAST,M-DOWN> mtu 1500 qdisc noop state
> DOWN group default qlen 1000
>     link/ether d8:58:d7:00:61:6e brd ff:ff:ff:ff:ff:ff
> 7: lan1 at eth1: <BROADCAST,MULTICAST,M-DOWN> mtu 1500 qdisc noop state
> DOWN group default qlen 1000
>     link/ether d8:58:d7:00:61:6e brd ff:ff:ff:ff:ff:ff
> 8: lan2 at eth1: <BROADCAST,MULTICAST,M-DOWN> mtu 1500 qdisc noop state
> DOWN group default qlen 1000
>     link/ether d8:58:d7:00:61:6e brd ff:ff:ff:ff:ff:ff
> 9: lan3 at eth1: <BROADCAST,MULTICAST,M-DOWN> mtu 1500 qdisc noop state
> DOWN group default qlen 1000
>     link/ether d8:58:d7:00:61:6e brd ff:ff:ff:ff:ff:ff
> 10: lan4 at eth1: <BROADCAST,MULTICAST,M-DOWN> mtu 1500 qdisc noop state
> DOWN group default qlen 1000
>     link/ether d8:58:d7:00:61:6e brd ff:ff:ff:ff:ff:ff
> 
> I get some interfaces for the switch, but I've not been able to get them
> up/usable.

ip link set eth1 up

> Feel free to browse my commits, maybe I'm doing something
> stupid - I already tried with and without fixed links, but the driver
> seems to use only one of the two cpu links.

Correct, and this has been discussed on the thread about this board.

	 Andrew
