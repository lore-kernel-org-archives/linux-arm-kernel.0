From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 31 Aug 2010 14:57:55 +0100
Subject: [PATCH 0/9] Various patches for 2.6.37-rc1
Message-ID: <20100831135435.21304.38960.stgit@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

These are the patches that I plan to submit for 2.6.37-rc1. They have
been posted in the past on this list and are currently in linux-next.

Please let me know if you have any objections. Thanks.


Catalin Marinas (8):
      ARM: Allow lazy cache flushing via PG_arch_1 for highmem pages
      ARM: Assume new page cache pages have dirty D-cache
      ARM: Introduce __sync_icache_dcache() for VIPT caches
      ARM: Use lazy cache flushing on ARMv7 SMP systems
      ARM: Remove superfluous flush_kernel_dcache_page()
      ARM: Implement phys_mem_access_prot() to avoid attributes aliasing
      ARM: Improve the L2 cache performance when PL310 is used
      ARM: Remove the domain switching on ARMv6k/v7 CPUs

Leif Lindholm (1):
      ARM: Add SWP/SWPB emulation for ARMv7 processors (v5)


 Documentation/arm/00-INDEX        |    2 
 Documentation/arm/swp_emulation   |   27 ++++
 arch/arm/include/asm/assembler.h  |   13 +-
 arch/arm/include/asm/cacheflush.h |    9 -
 arch/arm/include/asm/domain.h     |   31 ++++
 arch/arm/include/asm/futex.h      |    9 +
 arch/arm/include/asm/pgtable.h    |   29 ++++
 arch/arm/include/asm/smp_plat.h   |    4 +
 arch/arm/include/asm/tlbflush.h   |   12 +-
 arch/arm/include/asm/traps.h      |    2 
 arch/arm/include/asm/uaccess.h    |   16 +-
 arch/arm/kernel/Makefile          |    1 
 arch/arm/kernel/entry-armv.S      |    4 -
 arch/arm/kernel/fiq.c             |    5 +
 arch/arm/kernel/swp_emulate.c     |  260 +++++++++++++++++++++++++++++++++++++
 arch/arm/kernel/traps.c           |   14 +-
 arch/arm/lib/getuser.S            |   13 +-
 arch/arm/lib/putuser.S            |   29 ++--
 arch/arm/lib/uaccess.S            |   83 ++++++------
 arch/arm/mm/Kconfig               |   43 ++++++
 arch/arm/mm/cache-l2x0.c          |   15 ++
 arch/arm/mm/copypage-v4mc.c       |    2 
 arch/arm/mm/copypage-v6.c         |    2 
 arch/arm/mm/copypage-xscale.c     |    2 
 arch/arm/mm/dma-mapping.c         |    6 +
 arch/arm/mm/fault-armv.c          |    8 +
 arch/arm/mm/flush.c               |   46 +++++--
 arch/arm/mm/mmu.c                 |   20 ++-
 arch/arm/mm/proc-macros.S         |    7 +
 arch/arm/mm/proc-v7.S             |    9 +
 30 files changed, 600 insertions(+), 123 deletions(-)
 create mode 100644 Documentation/arm/swp_emulation
 create mode 100644 arch/arm/kernel/swp_emulate.c

-- 
Catalin
