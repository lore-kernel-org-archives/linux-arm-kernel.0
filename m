From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Thu, 3 Jun 2010 00:33:57 +0200
Subject: PB1176 broken in 2.6.35-rc1, bisected
Message-ID: <AANLkTikoCy2FH_5ICh-iiI_wzGj6D6oszyM-zCXkNC_4@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

my PB1176 doesn't boot properly in 2.6.35-rc1, it goes to this point
and hangs:

(...)
Switching to clocksource timer3
NET: Registered protocol family 2
IP route cache hash table entries: 1024 (order: 0, 4096 bytes)
TCP established hash table entries: 4096 (order: 3, 32768 bytes)
TCP bind hash table entries: 4096 (order: 2, 16384 bytes)
TCP: Hash tables configured (established 4096 bind 4096)
TCP reno registered
UDP hash table entries: 256 (order: 0, 4096 bytes)
UDP-Lite hash table entries: 256 (order: 0, 4096 bytes)
NET: Registered protocol family 1
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
RPC: Registered tcp NFSv4.1 backchannel transport module.


I bisected until I had this as the first commit causing the trouble:

commit ac1d426e825ab5778995f2f6f053ca2e6b45c622
Merge: fda0e18 a3685f0
Author: Russell King <rmk+kernel@arm.linux.org.uk>
Date:   Mon May 17 17:24:04 2010 +0100

    Merge branch 'devel-stable' into devel

    Conflicts:
        arch/arm/Kconfig
        arch/arm/include/asm/system.h
        arch/arm/mm/Kconfig


This doesn't say much so I suspect it's this latter one causing it:

commit fda0e18c8a7a3e02747c2b045b4fcd2c920410b9
Merge: 98830bc d1e86d6
Author: Russell King <rmk+kernel@arm.linux.org.uk>
Date:   Mon May 17 17:21:23 2010 +0100

    Merge branch 'devel-pmu' into devel


Any hints on how to fix this? Some PMU issue on this board
perhaps?

Yours,
Linus Walleij
