From: a.kesavan@samsung.com (Abhilash Kesavan)
Date: Tue, 06 Nov 2012 11:42:31 +0530
Subject: [PATCH 0/5] PM Fixes for exynos5
Message-ID: <1352182356-28989-1-git-send-email-a.kesavan@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset comprises fixes to properly enable PM support on exynos5.
Based on git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
for-next branch.

Patches 1 and 4 are re-posts of patches sent earlier by Changhwan Youn and
Inderpal Singh respectively. Links follow:
http://lists.infradead.org/pipermail/linux-arm-kernel/2012-May/098930.html
http://permalink.gmane.org/gmane.linux.kernel.samsung-soc/10947

Patch 2 is a fix in cpuidle while patch 3 enables the RTC alarm as a wake
up source.

Patch 5 adds a machine specific "flush_cache_all" as it is no longer part
of the core suspend routine. This was suggested by Lorenzo Pieralisi.

These patches have been tested on SMDK5250.

Abhilash Kesavan (3):
  ARM: EXYNOS: fix the hotplug for Cortex-A15
  ARM: EXYNOS5: Remove scu_enable from cpuidle
  ARM: EXYNOS5: Add flush_cache_all in suspend finisher

Inderpal Singh (2):
  ARM: EXYNOS5: Add support for rtc wakeup
  ARM: EXYNOS: Fix soft reboot hang after suspend/resume

 arch/arm/mach-exynos/common.c           |    2 +
 arch/arm/mach-exynos/cpuidle.c          |    3 +-
 arch/arm/mach-exynos/hotplug.c          |   45 ++++++++++++++++++++++++++++--
 arch/arm/mach-exynos/pm.c               |    7 +++++
 arch/arm/plat-samsung/include/plat/pm.h |    2 +
 5 files changed, 55 insertions(+), 4 deletions(-)
