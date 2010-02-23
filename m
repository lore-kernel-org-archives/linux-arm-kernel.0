From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 23 Feb 2010 11:00:59 +0000
Subject: [PATCH 0/4] ARM mandatory barriers
Message-ID: <20100223105806.11048.16585.stgit@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This is a follow up to a previous patch I posted on the implementation
of the mandatory barriers on ARM. The third patch adds support for the
L2x0 cache sync operation and the last patch implements the
RealView-specific mandatory barriers.


Catalin Marinas (4):
      ARM: Change the mandatory barriers implementation
      ARM: Move the outer_cache definitions into a separate file
      ARM: Add outer_cache_fns sync function and support for L2x0
      ARM: Add RealView-specific barrier implementation


 arch/arm/Kconfig                               |    1 
 arch/arm/include/asm/cacheflush.h              |   38 -------------
 arch/arm/include/asm/outercache.h              |   69 ++++++++++++++++++++++++
 arch/arm/include/asm/system.h                  |   18 +++---
 arch/arm/mach-realview/include/mach/barriers.h |   30 ++++++++++
 arch/arm/mm/Kconfig                            |    6 ++
 arch/arm/mm/cache-l2x0.c                       |    1 
 7 files changed, 116 insertions(+), 47 deletions(-)
 create mode 100644 arch/arm/include/asm/outercache.h
 create mode 100644 arch/arm/mach-realview/include/mach/barriers.h

-- 
Catalin
