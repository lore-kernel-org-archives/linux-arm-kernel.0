From: ivo.g.dimitrov.75@gmail.com (Ivaylo Dimitrov)
Date: Thu, 13 Feb 2014 20:02:57 +0200
Subject: [BISECTED] ssh - Received disconnect from x.x.x.x: 2: Bad packet
 length 3149594624
Message-ID: <52FD08D1.3030405@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since next-21012014 I started to receive "Received disconnect from 
x.x.x.x: 2: Bad packet length 3149594624" errors when trying to 
establish ssh session over wifi to my N900, running Maemo 5. I bisected 
and it turned out that commit dce5c9e35bc4085bd33eccdb8c9ec5a643507a14 
"ARM: 7928/1: kconfig: select HAVE_EFFICIENT_UNALIGNED_ACCESS for CPUv6+ 
&& MMU" is the first bad. There is nothing related in either dmesg or 
syslog on the device. Reverting that commit on 3.14-rc1 make those 
errors disappear.

As my knowledge on how to deal with that stops here, advises on what to 
do next to find the real problem are appreciated.

Ivo
