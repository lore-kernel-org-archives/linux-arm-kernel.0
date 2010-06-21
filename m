From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 21 Jun 2010 15:46:21 +0100
Subject: [PATCH v4 0/4] Patches for -next
Message-ID: <20100621144409.26309.87173.stgit@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Pretty much the same content as v3 but I reordered the last three
patches to make sure that switching to lazy cache flushing on ARMv7 SMP
doesn't make the set_pte/cache flushing race more visible (issue handled
by the set_pte_at patch).


Catalin Marinas (4):
      ARM: Remove the domain switching on ARMv6k/v7 CPUs
      ARM: Assume new page cache pages have dirty D-cache
      ARM: Synchronise the I and D caches via set_pte_at() on SMP systems
      ARM: Use lazy cache flushing on ARMv7 SMP systems


 arch/arm/include/asm/assembler.h  |   13 +++---
 arch/arm/include/asm/cacheflush.h |    6 +--
 arch/arm/include/asm/domain.h     |   31 +++++++++++++-
 arch/arm/include/asm/futex.h      |    9 ++--
 arch/arm/include/asm/pgtable.h    |   25 ++++++++++-
 arch/arm/include/asm/smp_plat.h   |    4 ++
 arch/arm/include/asm/tlbflush.h   |   12 ++++-
 arch/arm/include/asm/traps.h      |    2 +
 arch/arm/include/asm/uaccess.h    |   16 ++++---
 arch/arm/kernel/entry-armv.S      |    4 +-
 arch/arm/kernel/fiq.c             |    5 ++
 arch/arm/kernel/traps.c           |   14 ++++--
 arch/arm/lib/getuser.S            |   13 +++---
 arch/arm/lib/putuser.S            |   29 +++++++------
 arch/arm/lib/uaccess.S            |   83 +++++++++++++++++++------------------
 arch/arm/mm/Kconfig               |    8 ++++
 arch/arm/mm/copypage-v4mc.c       |    2 -
 arch/arm/mm/copypage-v6.c         |    2 -
 arch/arm/mm/copypage-xscale.c     |    2 -
 arch/arm/mm/dma-mapping.c         |    6 +++
 arch/arm/mm/fault-armv.c          |    8 ++--
 arch/arm/mm/flush.c               |   31 +++++++++-----
 arch/arm/mm/mmu.c                 |    6 +--
 arch/arm/mm/proc-macros.S         |    7 +++
 arch/arm/mm/proc-v7.S             |    5 +-
 25 files changed, 226 insertions(+), 117 deletions(-)

-- 
Catalin
