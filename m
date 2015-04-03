From: liu.h.jason@gmail.com (Jason Liu)
Date: Fri, 3 Apr 2015 11:33:06 +0800
Subject: Questions about the L2 cache (PL310) optimization
Message-ID: <CAB4PhKf3Fr3fOC73EGBvmX9tt2pDUnTs5KsnpMQBXfgpym=Qbw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

I have seen the following log when boot up on my board: 4-Cortex A9 with PL310:

[    0.000000] L2C-310 enabling early BRESP for Cortex-A9

[    0.000000] L2C-310 full line of zeros enabled for Cortex-A9

[    0.000000] L2C-310 ID prefetch enabled, offset 1 lines

[    0.000000] L2C-310 dynamic clock gating enabled, standby mode enabled

[    0.000000] L2C-310 cache controller enabled, 16 ways, 1024 kB

[    0.000000] L2C-310: CACHE_ID 0x410000c7, AUX_CTRL 0x76070001


I have the following questions:

- The prefetch offset set to 1 line,  why not set to high value say
0xf. According to      ARM: PL310 r3p2 TRM:
   You must only use the Prefetch offset values of 0-7, 15, 23, and 31 for these
    bits. The L2C-310 does not support the other values.
-  Do you have seen performance boost for the BRESP and FLZ?

Appreciated if you have some comments.

Jason Liu
