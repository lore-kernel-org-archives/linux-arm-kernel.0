From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Tue, 16 Jun 2015 15:31:24 +0200
Subject: [BUG] at91: macb: does not work
In-Reply-To: <5580205B.1030804@aksignal.cz>
References: <5580205B.1030804@aksignal.cz>
Message-ID: <20150616133124.GB6549@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 16/06/2015 at 15:10:51 +0200, Ji?? Prchal wrote :
> Hi,
> in v4.1-rc8 does not work ethernet. It normally gets up, but no data are going through.
> 
> [    4.400000] macb f802c000.ethernet (unnamed net_device) (uninitialized): invalid hw address, using random
> [    4.510000] macb f802c000.ethernet eth0: Cadence MACB rev 0x0001010c at 0xf802c000 irq 37 (52:30:8f:6b:9c:b7)
> [    4.520000] macb f802c000.ethernet eth0: attached PHY driver [Generic PHY] (mii_bus:phy_addr=f802c000.etherne:03, irq=-1)
> [   15.510000] macb f802c000.ethernet eth0: link up (100/Full)
> 
> / # ip -s link ls eth0
> 2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP mode DEFAULT group default qlen 1000
>     link/ether a2:61:fe:17:65:b1 brd ff:ff:ff:ff:ff:ff
>     RX: bytes  packets  errors  dropped overrun mcast
>     0          0        0       0       0       0
>     TX: bytes  packets  errors  dropped carrier collsns
>     0          0        0       0       0       0
> 
> In v4.0.5 it's working.
> 

You probably have an issue in your device tree. I've just tested both
interfaces of my sama5d3 xplained and they are working fine.


-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
