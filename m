From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 19 Jul 2010 14:43:57 +0100
Subject: [PATCH 0/9] CM's patches for the next merging window(s)
Message-ID: <20100719133050.24290.70856.stgit@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This is a series of patches I maintain in my tree at (the 'rebased'
branch for individual patches or 'master' for a merge-friendly branch):

http://git.kernel.org/?p=linux/kernel/git/cmarinas/linux-2.6-cm.git

Once acked, I'll send them to Russell's patch system.

As usual, any comments are welcome. Thanks.


Catalin Marinas (9):
      ARM: Remove the domain switching on ARMv6k/v7 CPUs
      ARM: Assume new page cache pages have dirty D-cache
      ARM: Introduce __sync_icache_dcache() for VIPT caches
      ARM: Use lazy cache flushing on ARMv7 SMP systems
      ARM: Introduce *_relaxed() I/O accessors
      ARM: Convert L2x0 to use the IO relaxed operations
      ARM: Add barriers to the I/O accessors if ARM_DMA_MEM_BUFFERABLE
      ARM: Improve the L2 cache performance when PL310 is used
      ARM: Implement phys_mem_access_prot() to avoid attributes aliasing


 arch/arm/include/asm/assembler.h  |   13 +++--
 arch/arm/include/asm/cacheflush.h |    6 +-
 arch/arm/include/asm/domain.h     |   31 ++++++++++++
 arch/arm/include/asm/elf.h        |    2 +
 arch/arm/include/asm/futex.h      |    9 ++--
 arch/arm/include/asm/io.h         |   40 +++++++++++-----
 arch/arm/include/asm/pgtable.h    |   29 ++++++++++--
 arch/arm/include/asm/smp_plat.h   |    4 ++
 arch/arm/include/asm/tlbflush.h   |   12 ++++-
 arch/arm/include/asm/traps.h      |    2 +
 arch/arm/include/asm/uaccess.h    |   16 +++---
 arch/arm/kernel/entry-armv.S      |    4 +-
 arch/arm/kernel/fiq.c             |    5 ++
 arch/arm/kernel/module.c          |   34 ++++++++++++++
 arch/arm/kernel/traps.c           |   14 ++++--
 arch/arm/lib/getuser.S            |   13 +++--
 arch/arm/lib/putuser.S            |   29 ++++++------
 arch/arm/lib/uaccess.S            |   83 +++++++++++++++++----------------
 arch/arm/mm/Kconfig               |   16 ++++++
 arch/arm/mm/cache-l2x0.c          |   41 ++++++++++------
 arch/arm/mm/copypage-v4mc.c       |    2 -
 arch/arm/mm/copypage-v6.c         |    2 -
 arch/arm/mm/copypage-xscale.c     |    2 -
 arch/arm/mm/dma-mapping.c         |    6 ++
 arch/arm/mm/fault-armv.c          |    8 ++-
 arch/arm/mm/flush.c               |   46 ++++++++++++++-----
 arch/arm/mm/mmu.c                 |   20 +++++++-
 arch/arm/mm/proc-macros.S         |    7 +++
 arch/arm/mm/proc-v7.S             |    5 +-
 drivers/net/smsc911x.c            |   92 +++++++++++++++++++++----------------
 30 files changed, 408 insertions(+), 185 deletions(-)

-- 
Catalin
