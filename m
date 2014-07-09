From: leif.lindholm@linaro.org (Leif Lindholm)
Date: Wed,  9 Jul 2014 10:39:50 +0100
Subject: [PATCH 0/2] arm: add early_ioremap support
Message-ID: <1404898792-4201-1-git-send-email-leif.lindholm@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

early_ioremap()/early_memremap() create temporary virtual mappings
in the fixmap region during boot time. Part of the support now exists
in core code, but depends on the generic fixmap support.

This set converts arm to use the generic fixmap support, and adds the
architecture-specific part of early_ioremap support.

The fixmap/kmap changes in 3.15 complicated things slightly compared
to previous iterations of these patches - this version works around
that by introducing local macros in arm/mm/highmem.c.

Tested on TC2 and software models, with/without LPAE.

Mark Salter (2):
  arm: use generic fixmap.h
  arm: add early_ioremap support

 arch/arm/Kconfig              |   11 ++++++
 arch/arm/include/asm/Kbuild   |    1 +
 arch/arm/include/asm/fixmap.h |   45 +++++++++++++--------
 arch/arm/include/asm/io.h     |    1 +
 arch/arm/kernel/setup.c       |    3 ++
 arch/arm/mm/Makefile          |    1 +
 arch/arm/mm/early_ioremap.c   |   86 +++++++++++++++++++++++++++++++++++++++++
 arch/arm/mm/highmem.c         |   13 ++++---
 arch/arm/mm/init.c            |    2 +-
 arch/arm/mm/mmu.c             |    2 +
 10 files changed, 143 insertions(+), 22 deletions(-)
 create mode 100644 arch/arm/mm/early_ioremap.c

-- 
1.7.10.4
