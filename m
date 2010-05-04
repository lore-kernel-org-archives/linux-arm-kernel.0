From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 04 May 2010 17:44:15 +0100
Subject: [PATCH 0/8] Various patches for comments and upstream
Message-ID: <20100504163823.26355.58568.stgit@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I've been posting most of these patches in the past (some of them for a
long time, e.g. the domains removal) and I would like some comments on
them. There were some previous discussion threads which seem to have
died without a clear conclusion.

A few of these patches are trivial fixes that could go upstream (during
the upcoming merging window). For the other patches like domains
removal, I would like to push them to linux-next if there are no
(further :)) comments.

Thanks.


Catalin Marinas (8):
      ARM: Improve the L2 cache performance when PL310 is used
      ARM: Implement read/write for ownership in the ARMv6 DMA cache ops
      ARM: Align machine_desc.phys_io to a 1MB section
      ARM: Remove the domain switching on ARMv6k/v7 CPUs
      ARM: Fix the __arm_ioremap_caller() definition in nommu.c
      ARM: Implement copy_to_user_page() for noMMU
      ARM: Use the Inner Shareable I-cache and BTB ops on ARMv7 SMP
      ARM: Implement phys_mem_access_prot() to avoid attributes aliasing


 arch/arm/include/asm/assembler.h  |   13 +++--
 arch/arm/include/asm/cacheflush.h |    4 ++
 arch/arm/include/asm/domain.h     |   31 ++++++++++++
 arch/arm/include/asm/futex.h      |    9 ++--
 arch/arm/include/asm/pgtable.h    |    3 +
 arch/arm/include/asm/tlbflush.h   |   29 +++++++++++-
 arch/arm/include/asm/uaccess.h    |   16 +++---
 arch/arm/kernel/entry-armv.S      |    4 +-
 arch/arm/kernel/head.S            |    2 +
 arch/arm/kernel/setup.c           |    2 -
 arch/arm/kernel/traps.c           |   17 +++++++
 arch/arm/lib/getuser.S            |   13 +++--
 arch/arm/lib/putuser.S            |   29 ++++++------
 arch/arm/lib/uaccess.S            |   83 +++++++++++++++++----------------
 arch/arm/mm/Kconfig               |   15 ++++++
 arch/arm/mm/cache-l2x0.c          |   74 +++++++++++++++++++++---------
 arch/arm/mm/cache-v6.S            |   17 +++++--
 arch/arm/mm/cache-v7.S            |    4 ++
 arch/arm/mm/init.c                |   14 ++----
 arch/arm/mm/mmu.c                 |   14 ++++++
 arch/arm/mm/nommu.c               |   13 ++++-
 arch/arm/mm/proc-macros.S         |    7 +++
 arch/arm/mm/proc-v7.S             |    5 +-
 arch/arm/mm/tlb-v7.S              |    8 +++
 drivers/net/smsc911x.c            |   92 +++++++++++++++++++++----------------
 mm/bootmem.c                      |    2 +
 mm/page_alloc.c                   |    1 
 27 files changed, 355 insertions(+), 166 deletions(-)

-- 
Catalin
