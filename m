From: moon.linux@yahoo.com (Anand Moon)
Date: Wed,  7 Jan 2015 17:45:32 +0530
Subject: [PATCH] ARM: exynos_defconfig: Enable CONFIG_LOCKUP_DETECTOR
Message-ID: <1420632932-6964-1-git-send-email-moon.linux@yahoo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARM Enable CONFIG_LOCKUP_DETECTOR to validation of kernel locks

v2 Fixed the commit log
This config item helps getting some useful information when lockup
happens. If you want to validate locks then probably you want
PROVE_LOCKING... but its overhead is larger.

Anyway the overhead of LOCKUP_DETECTOR is small and multi_v7_defconfig
has it enabled so I guess exynos may do it as well.

Tested on Exynos5422 ODROID XU3 board.

Signed-off-by: Anand Moon <moon.linux@yahoo.com>
Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 arch/arm/configs/exynos_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/exynos_defconfig b/arch/arm/configs/exynos_defconfig
index 5ef14de..ecd9987 100644
--- a/arch/arm/configs/exynos_defconfig
+++ b/arch/arm/configs/exynos_defconfig
@@ -178,6 +178,7 @@ CONFIG_PRINTK_TIME=y
 CONFIG_DEBUG_FS=y
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_KERNEL=y
+CONFIG_LOCKUP_DETECTOR=y
 CONFIG_DETECT_HUNG_TASK=y
 CONFIG_DEBUG_RT_MUTEXES=y
 CONFIG_DEBUG_SPINLOCK=y
-- 
2.1.0
