From: Leonid.Yegoshin@imgtec.com (Leonid Yegoshin)
Date: Thu, 14 Jan 2016 15:04:18 -0800
Subject: [v3,11/41] mips: reuse asm-generic/barrier.h
In-Reply-To: <20160114222433.GI3818@linux.vnet.ibm.com>
References: <56969F4B.7070001@imgtec.com>
 <20160113204844.GV6357@twins.programming.kicks-ass.net>
 <5696BA6E.4070508@imgtec.com> <20160114120445.GB15828@arm.com>
 <20160114161604.GT3818@linux.vnet.ibm.com> <5697FA0A.6040601@imgtec.com>
 <20160114201513.GI6357@twins.programming.kicks-ass.net>
 <56980933.2020801@imgtec.com> <20160114213440.GG3818@linux.vnet.ibm.com>
 <56981708.4000007@imgtec.com> <20160114222433.GI3818@linux.vnet.ibm.com>
Message-ID: <56982972.7050609@imgtec.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/14/2016 02:24 PM, Paul E. McKenney wrote:
> Actually, the Linux kernel doesn't have an acquire barrier, just an 
> smp_load_acquire(). Or did someone sneak one in while I wasn't looking?
That was an exactly starting point for this discussion. This patch just 
pulls out from MIPS files smp_load_acquire() and smp_store_release(). 
However, I put into LMO half year ago the patch 
http://patchwork.linux-mips.org/patch/10506/ which replaces a generic 
smp_mb with MIPS specific smp_release/acquire in that functions. This 
patch also fixes use of SYNCs barriers in spin_locks/atomics/bitops for 
Imagination MIPS CPUs too - it is just absent now for any Imagination 
MIPS CPUs!

Michael later pointed me that it can be returned back with his series of 
patches but discussion was already here.

- Leonid.
