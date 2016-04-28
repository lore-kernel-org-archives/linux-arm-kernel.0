From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Thu, 28 Apr 2016 16:44:45 +0200
Subject: [PATCH] ARM: exynos_defconfig: Disable big.LITTLE switcher
Message-ID: <1493315.8NlXQFsEtt@amdc1976>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Disable big.LITTLE switcher in order to allow automatic usage of
cpufreq-dt driver on Exynos542x/Exynos5800 SoCs based boards.

This change should not cause any problems as arm_big_little[_dt]
driver (which is using big.LITTLE switcher support to do the "real"
big.LITTLE switching work) is not used on any Exynos SoC based
board currently.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 arch/arm/configs/exynos_defconfig | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/configs/exynos_defconfig b/arch/arm/configs/exynos_defconfig
index a8cf295..07d4168 100644
--- a/arch/arm/configs/exynos_defconfig
+++ b/arch/arm/configs/exynos_defconfig
@@ -13,8 +13,6 @@ CONFIG_ARCH_EXYNOS3=y
 CONFIG_EXYNOS5420_MCPM=y
 CONFIG_SMP=y
 CONFIG_BIG_LITTLE=y
-CONFIG_BL_SWITCHER=y
-CONFIG_BL_SWITCHER_DUMMY_IF=y
 CONFIG_NR_CPUS=8
 CONFIG_PREEMPT=y
 CONFIG_AEABI=y
-- 
1.9.1
