From: armkernel8@gmail.com (Moon Hwa Hong)
Date: Fri, 26 Aug 2011 09:31:25 +0900
Subject: ARMv7 MMU and cache enabling code in boot/compressed/head.S
Message-ID: <CAFWwQu_-HirBTsyFpG8EKs6Su9r=O4Wi8=L3b-O4OdMKDC0f8g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

I started arm linux kernel hacking.
I can't understand 554 line.
I think that 554 line is not necessary.
Because ISB instruction(556 line) makes synchronization between 553 and 557.
Please advice to me.


530 __armv7_mmu_cache_on:
.
.
.
553         mcr p15, 0, r0, c1, c0, 0   @ load control register
554         mrc p15, 0, r0, c1, c0, 0   @ and read it back
555         mov r0, #0
556         mcr p15, 0, r0, c7, c5, 4   @ ISB
557         mov pc, r12

Have a nice day.

MH Hong.
