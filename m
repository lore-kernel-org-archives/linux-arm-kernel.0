From: chander.kashyap@linaro.org (Chander Kashyap)
Date: Mon, 21 Apr 2014 17:19:14 +0530
Subject: [PATCH 0/4] add cpuidle support for Exynos5420
Message-ID: <1398080958-21677-1-git-send-email-chander.kashyap@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Exynos5420 is a big-little Soc from Samsung. It has 4 A15 and 4 A7 cores.

This patchset adds cpuidle support for Exynos5420 SoC based on
generic big.little cpuidle driver.

Tested on SMDK5420.

This patch set depends on:
	1. [PATCH 0/5] MCPM backend for Exynos5420
	   http://www.spinics.net/lists/arm-kernel/msg321666.html

	2. [PATCH v4] arm: exynos: generalize power register address calculation
	   http://www.spinics.net/lists/arm-kernel/msg324024.html
		
Chander Kashyap (4):
  cpuidle: config: Add SOC_EXYNOS5420 entry to select
    cpuidle-big-little driver
  driver: cpuidle: cpuidle-big-little: init driver for Exynos5420
  exynos: cpuidle: do not allow cpuidle registration for Exynos5420
  mcpm: exynos: populate suspend and powered_up callbacks

 arch/arm/mach-exynos/cpuidle.c       |    3 ++
 arch/arm/mach-exynos/mcpm-exynos.c   |   53 ++++++++++++++++++++++++++++++++++
 drivers/cpuidle/Kconfig.arm          |    2 +-
 drivers/cpuidle/cpuidle-big_little.c |    3 +-
 4 files changed, 59 insertions(+), 2 deletions(-)

-- 
1.7.9.5
