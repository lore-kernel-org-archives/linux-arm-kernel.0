From: amit.daniel@samsung.com (Amit Daniel Kachhap)
Date: Wed, 12 Jun 2013 16:58:44 +0530
Subject: [PATCH V2 0/2] ARM: EXYNOS: cpuidle: fixes in exynos cpuidle/PM
Message-ID: <1371036526-16589-1-git-send-email-amit.daniel@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series contains a couple of fixes in cpuidle/PM due to
1) exynos5440 platform which does not support cpuidle C1 state.
2) Compilations error when generic PM options are enabled.

This patch series depends on earlier posted patch
http://www.spinics.net/lists/arm-kernel/msg248831.html

Changes in V2:
* Rebase against samsung maintainer's for next tree.

Amit Daniel Kachhap (2):
  ARM: SAMSUNG: Add SAMSUNG_PM config option to select pm
  ARM: EXYNOS: cpuidle: Allow C1 state only in supported SOC's.

 arch/arm/mach-exynos/Makefile           |    2 +-
 arch/arm/mach-exynos/common.c           |    2 +-
 arch/arm/mach-exynos/common.h           |    1 -
 arch/arm/mach-exynos/cpuidle.c          |    5 ++++-
 arch/arm/plat-samsung/Kconfig           |    7 +++++++
 arch/arm/plat-samsung/Makefile          |    3 +--
 arch/arm/plat-samsung/include/plat/pm.h |    8 ++++----
 7 files changed, 18 insertions(+), 10 deletions(-)
