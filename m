From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 20 May 2010 15:29:58 +0100
Subject: [PATCH 0/4] Patches for -next
Message-ID: <20100520142715.22202.33516.stgit@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I would like to get these patches in the linux-next tree for this
release cycle and aim to submit them for upstream 2.6.36-rc1 (next
merging window).

Please let me know if you have any objections.

Thanks.


Catalin Marinas (4):
      ARM: Remove the domain switching on ARMv6k/v7 CPUs
      ARM: Use lazy cache flushing on ARMv7 SMP systems
      ARM: Assume new page cache pages have dirty D-cache
      ARM: Defer the L_PTE_EXEC flag setting to update_mmu_cache() on SMP


 arch/arm/include/asm/assembler.h  |   13 +++---
 arch/arm/include/asm/cacheflush.h |    6 +--
 arch/arm/include/asm/domain.h     |   31 +++++++++++++-
 arch/arm/include/asm/futex.h      |    9 ++--
 arch/arm/include/asm/pgtable.h    |   12 +++++
 arch/arm/include/asm/smp_plat.h   |    4 ++
 arch/arm/include/asm/tlbflush.h   |    2 -
 arch/arm/include/asm/uaccess.h    |   16 ++++---
 arch/arm/kernel/entry-armv.S      |    4 +-
 arch/arm/kernel/traps.c           |   17 ++++++++
 arch/arm/lib/getuser.S            |   13 +++---
 arch/arm/lib/putuser.S            |   29 +++++++------
 arch/arm/lib/uaccess.S            |   83 +++++++++++++++++++------------------
 arch/arm/mm/Kconfig               |    8 ++++
 arch/arm/mm/copypage-v4mc.c       |    2 -
 arch/arm/mm/copypage-v6.c         |    2 -
 arch/arm/mm/copypage-xscale.c     |    2 -
 arch/arm/mm/dma-mapping.c         |    6 +++
 arch/arm/mm/fault-armv.c          |   21 ++++++---
 arch/arm/mm/flush.c               |   15 ++-----
 arch/arm/mm/proc-macros.S         |    7 +++
 arch/arm/mm/proc-v7.S             |    5 +-
 22 files changed, 197 insertions(+), 110 deletions(-)

-- 
Catalin
