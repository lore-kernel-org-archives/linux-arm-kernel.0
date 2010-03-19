From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 19 Mar 2010 13:48:20 +0000
Subject: [PATCH v4 0/4] ARM mandatory barriers
Message-ID: <20100319134614.14625.18408.stgit@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Updated series on the ARM mandatory barriers. As per Russell's
suggestion, most platform seem to define the mb() as dsb(); outer_sync()
and it makes sense to make this the default (if CONFIG_OUTER_CACHE_SYNC
is defined). The patch still allows per-platform barriers via the
CONFIG_ARCH_HAS_BARRIERS option.


Catalin Marinas (4):
      ARM: Move the outer_cache definitions into a separate file
      ARM: Add outer_cache_fns.sync function pointer
      ARM: Add L2x0 outer_sync() support
      ARM: Change the mandatory barriers implementation


 arch/arm/include/asm/cacheflush.h |   38 -------------------
 arch/arm/include/asm/outercache.h |   75 +++++++++++++++++++++++++++++++++++++
 arch/arm/include/asm/system.h     |   14 ++++---
 arch/arm/mm/Kconfig               |   13 ++++++
 arch/arm/mm/cache-l2x0.c          |   10 +++++
 5 files changed, 107 insertions(+), 43 deletions(-)
 create mode 100644 arch/arm/include/asm/outercache.h

-- 
Catalin
