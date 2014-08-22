From: nathan_lynch@mentor.com (Nathan Lynch)
Date: Fri, 22 Aug 2014 16:43:13 -0500
Subject: [PATCH 0/4] arm_arch_timer: VDSO preparation, code consolidation
Message-ID: <1408743797-7648-1-git-send-email-nathan_lynch@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series contains the necessary changes to allow architected timer
access from user-space on 32-bit ARM.  This allows the VDSO to support
high resolution timestamps for clock_gettime and gettimeofday.  This
also merges substantially similar code from arm and arm64 into the
core arm_arch_timer driver.

These patches have been carried as part of the ARM VDSO patch set over
the last several months, but I am splitting them out here as I assume
they should go through the clocksource maintainer.

Nathan Lynch (4):
  clocksource: arm_arch_timer: change clocksource name if CP15
    unavailable
  clocksource: arm_arch_timer: enable counter access for 32-bit ARM
  ARM: arch_timer: remove unused functions
  arm64: arch_timer: remove unused functions

 arch/arm/include/asm/arch_timer.h    | 25 -------------------
 arch/arm64/include/asm/arch_timer.h  | 31 -----------------------
 drivers/clocksource/arm_arch_timer.c | 48 +++++++++++++++++++++++++++++++++---
 3 files changed, 44 insertions(+), 60 deletions(-)

-- 
1.9.3
