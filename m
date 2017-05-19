From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Fri, 19 May 2017 10:46:39 +0100
Subject: [RFC PATCH v2 0/7] ARM: NOMMU: MPU updates
Message-ID: <1495187206-14303-1-git-send-email-vladimir.murzin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This is an update of the existent MPU code which consist set of
clean-ups and enhancements. The most significant changes are in the way
how MPU settings sync-up for secondaries (PATCH 3/7) and more flexible
layout for memory (PATCH 7/7). Since there is no in-tree user of MPU,
support for M-class has been added (PATCH 6/7).

Thanks!

Changelog:
	    RFC -> RFC v2
	       - fixed MPU enable for v7m (PATCH 6/7)

Vladimir Murzin (7):
  ARM: NOMMU: Move out MPU setup in separate module
  ARM: NOMMU: Update MPU accessors to use cp15 helpers
  ARM: NOMMU: Rework MPU to be mostly done in C
  ARM: NOMMU: Disallow MPU for XIP
  ARM: Kconfig: Kill CONFIG_VECTORS_BASE
  ARM: V7M: Add support for MPU to M-class
  ARM: NOMMU: Use more MPU regions to cover memory

 arch/arm/Kconfig               |   9 -
 arch/arm/Kconfig-nommu         |   4 +-
 arch/arm/include/asm/cputype.h |  10 +
 arch/arm/include/asm/mpu.h     |  23 ++-
 arch/arm/include/asm/smp.h     |   2 +-
 arch/arm/include/asm/v7m.h     |  10 +
 arch/arm/kernel/asm-offsets.c  |  11 +
 arch/arm/kernel/head-nommu.S   | 128 +++++++++---
 arch/arm/kernel/smp.c          |   2 +-
 arch/arm/mm/Makefile           |   1 +
 arch/arm/mm/nommu.c            | 254 +----------------------
 arch/arm/mm/pmsa-v7.c          | 445 +++++++++++++++++++++++++++++++++++++++++
 12 files changed, 598 insertions(+), 301 deletions(-)
 create mode 100644 arch/arm/mm/pmsa-v7.c

-- 
2.0.0
