From: rui.p.m.sousa@gmail.com (Rui Sousa)
Date: Fri, 16 Mar 2012 12:44:22 +0100
Subject: spinlock_t and tagged memory block size
Message-ID: <CABcrWnUQ_4-nrZkt_zw5VC=cYJBfmaPsU7ktjMf2=xk7+=PArQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Cortex-A9 architecture defines the minimum size of tagged memory block
(used on load/store exclusives) to be 2^3 = 8bytes (Cortex A9 r2p2,
Technical Reference Manual, page 4-8).
However, the spinlock_t structure size (if preemption and spinlock
debug options are all disabled) is only 4bytes.
AFAICS, this will break spinlocks if two spinlocks are linked next to
each other. Am I right, or did I miss something?

Br,
Rui
