From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 03 Mar 2010 12:16:37 +0000
Subject: [PATCH v3 0/4] ARM mandatory barriers
Message-ID: <20100303121307.22029.26151.stgit@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This is version 3 of this set of patches. The *mb() barriers semantics
are now correctly implemented WRT arch_is_coherent(). For the ARMv7 and
CONFIG_SMP cases, the mb() and wmb() become a DSB. Platform code can
override them by defining CONFIG_ARCH_HAS_BARRIERS and implementing the
mach/barriers.h file.

The smp_*mb() barriers are implemented as DMB since they are not
required to have any effect outside of Normal Cacheable memory.

Thanks.


Catalin Marinas (4):
      ARM: Change the mandatory barriers implementation
      ARM: Move the outer_cache definitions into a separate file
      ARM: Add outer_cache_fns sync function and support for L2x0
      ARM: Add RealView-specific barrier implementation


 arch/arm/Kconfig                               |    1 
 arch/arm/include/asm/cacheflush.h              |   38 -------------
 arch/arm/include/asm/outercache.h              |   69 ++++++++++++++++++++++++
 arch/arm/include/asm/system.h                  |   14 +++--
 arch/arm/mach-realview/include/mach/barriers.h |   30 ++++++++++
 arch/arm/mm/Kconfig                            |    6 ++
 arch/arm/mm/cache-l2x0.c                       |   10 +++
 7 files changed, 125 insertions(+), 43 deletions(-)
 create mode 100644 arch/arm/include/asm/outercache.h
 create mode 100644 arch/arm/mach-realview/include/mach/barriers.h

-- 
Catalin
