From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 19 Mar 2010 14:32:55 +0000
Subject: [PATCH v5 0/4] ARM mandatory barriers
Message-ID: <20100319143047.11748.9186.stgit@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Pretty much as v4, just with minor changes as a result of patch
reordering (in my devel branch -
http://www.linux-arm.org/git?p=linux-2.6.git;a=shortlog;h=refs/heads/devel)


Catalin Marinas (4):
      ARM: Move the outer_cache definitions into a separate file
      ARM: Add outer_cache_fns.sync function pointer
      ARM: Add L2x0 outer_sync() support
      ARM: Change the mandatory barriers implementation


 arch/arm/include/asm/cacheflush.h |   38 -------------------
 arch/arm/include/asm/outercache.h |   75 +++++++++++++++++++++++++++++++++++++
 arch/arm/include/asm/system.h     |   16 +++++---
 arch/arm/mm/Kconfig               |   13 ++++++
 arch/arm/mm/cache-l2x0.c          |   10 +++++
 5 files changed, 109 insertions(+), 43 deletions(-)
 create mode 100644 arch/arm/include/asm/outercache.h

-- 
Catalin
