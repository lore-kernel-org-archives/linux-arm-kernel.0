From: k.chander@samsung.com (Chander Kashyap)
Date: Mon, 16 Jun 2014 15:56:17 +0530
Subject: [Patch v7 0/6] add cpuidle support for Exynos5420
Message-ID: <1402914383-20471-1-git-send-email-k.chander@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Exynos5420 is a big-little Soc from Samsung. It has 4 A15 and 4 A7 cores.

This patchset adds cpuidle support for Exynos5420 SoC based on
generic big.little cpuidle driver.

Tested on SMDK5420.
Rebased on 3.16-rc1

Changelog is in respective patches.
Chander Kashyap (5):
  driver: cpuidle-big-little: add of_device_id structure
  arm: exynos: add generic function to calculate cpu number
  cpuidle: config: Add ARCH_EXYNOS entry to select cpuidle-big-little
    driver
  driver: cpuidle: cpuidle-big-little: init driver for Exynos5420
  exynos: cpuidle: do not allow cpuidle registration for Exynos5420
  mcpm: exynos: populate suspend and powered_up callbacks

 arch/arm/mach-exynos/exynos.c        |    4 +++-
 arch/arm/mach-exynos/mcpm-exynos.c   |   36 ++++++++++++++++++++++++++++++++++
 arch/arm/mach-exynos/regs-pmu.h      |    9 +++++++++
 drivers/cpuidle/Kconfig.arm          |    2 +-
 drivers/cpuidle/cpuidle-big_little.c |   12 +++++++++++-
 5 files changed, 60 insertions(+), 3 deletions(-)

-- 
1.7.9.5
