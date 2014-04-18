From: leoy@marvell.com (Leo Yan)
Date: Fri, 18 Apr 2014 10:35:39 +0800
Subject: [Question] ARM/ARM64: Ticket Spinlock With GENERIC_BREAKLOCK
Message-ID: <53508F7B.2000400@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hi,

I noticed now for ARM and ARM64 both have disabled GENERIC_BREAKLOCK, 
and i found the patch "ARM: 7484/1: Don't enable GENERIC_LOCKBREAK with 
ticket spinlocks" to remove related configuration.

The ticket spinlock will be helpful for spinlock's performance, but 
after disabled LOCKBREAK, it will always disable the preempt when the 
cpu is spinning to wait for the lock.

So even after have refined the spinlock with ticket algorithm, we still 
need LOCKBREAK for the cpu has the chance to do scheduling so that other 
threads have chance can run.

Thanks for any advice. :-)

-- 
Thx,
Leo Yan
