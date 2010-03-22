From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 22 Mar 2010 15:19:34 +0000
Subject: [PATCH 0/5] Various patches for 2.6.35-rc1
Message-ID: <20100322151729.6353.79984.stgit@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

These are some patches I plan to push to -next unless there are
objections. My intention is to push them into mainline during the next
merging window.

The biggest one is the removal of the domains usage in Linux.

Thanks.


Catalin Marinas (5):
      ARM: Use lazy cache flushing on ARMv7 SMP systems
      ARM: Implement read/write for ownership in the ARMv6 DMA cache ops
      ARM: Correct the VFPv3 detection
      ARM: Align machine_desc.phys_io to a 1MB section
      ARM: Remove the domain switching on ARMv6k/v7 CPUs


 arch/arm/include/asm/assembler.h  |   13 +++---
 arch/arm/include/asm/cacheflush.h |    4 ++
 arch/arm/include/asm/domain.h     |   31 +++++++++++++-
 arch/arm/include/asm/futex.h      |    9 ++--
 arch/arm/include/asm/smp_plat.h   |    4 ++
 arch/arm/include/asm/tlbflush.h   |   29 ++++++++++++-
 arch/arm/include/asm/uaccess.h    |   16 ++++---
 arch/arm/kernel/entry-armv.S      |    4 +-
 arch/arm/kernel/head.S            |    2 +
 arch/arm/kernel/setup.c           |    2 -
 arch/arm/kernel/traps.c           |   17 ++++++++
 arch/arm/lib/getuser.S            |   13 +++---
 arch/arm/lib/putuser.S            |   29 +++++++------
 arch/arm/lib/uaccess.S            |   83 +++++++++++++++++++------------------
 arch/arm/mm/Kconfig               |    8 ++++
 arch/arm/mm/cache-v6.S            |   10 ++++
 arch/arm/mm/cache-v7.S            |    4 ++
 arch/arm/mm/fault-armv.c          |    2 -
 arch/arm/mm/flush.c               |    9 ++--
 arch/arm/mm/proc-macros.S         |    7 +++
 arch/arm/mm/proc-v7.S             |    5 +-
 arch/arm/mm/tlb-v7.S              |    8 ++++
 arch/arm/vfp/vfpmodule.c          |    2 -
 23 files changed, 216 insertions(+), 95 deletions(-)

-- 
Catalin
