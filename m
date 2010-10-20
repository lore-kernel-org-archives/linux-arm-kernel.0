From: srinidhikasagar@gmail.com (Srinidhi KASAGAR)
Date: Wed, 20 Oct 2010 14:43:21 +0530
Subject: recent ARM Erratas 742231 & 742230 broken.
Message-ID: <AANLkTim6LRZQhW6R83P0n70GdqEwFnFvb55KC8459KwY@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Will,

Are the below ERRATAs (in linux-next) on Cortex-A9 have been tested with
booting in non secure mode?

commit 9f05027c7cb3cfe56a31892bd83391138d41a667
Author: Will Deacon <will.deacon@arm.com>
Date:   Tue Sep 14 09:51:43 2010 +0100

    ARM: 6388/1: errata: DMB operation may be faulty

    On versions of the Cortex-A9 up to and including r2p2, under rare
    circumstances, a DMB instruction between 2 write operations may not
    ensure the correct visibility ordering of the 2 writes.

    This workaround sets a bit in the diagnostic register of the Cortex-A9,
    causing the DMB instruction to behave like a DSB, which functions
    correctly on the affected cores.

and

commit a672e99b129e286df2e2697a1b603d82321117f3
Author: Will Deacon <will.deacon@arm.com>
Date:   Tue Sep 14 09:53:02 2010 +0100

    ARM: 6389/1: errata: incorrect hazard handling in the SCU may lead
to data corruption

    On the r2p0, r2p1 and r2p2 versions of the Cortex-A9, data corruption
    can occur if a shared cache line is replaced on one CPU as another CPU
    is accessing it.

    This workaround sets two bits in the diagnostic register of the Cortex-A9,
    reducing the linefill issuing capabilities of the processor and
    avoiding the erroneous behaviour.

What I see is that when I try to boot the system having this version
of Cortex-A9 I see
that the system does not boot at all. These diagnostic registers which seems
undocumented and unable to see what's going on. However the system boots if I
start from secure mode.

Srinidhi
