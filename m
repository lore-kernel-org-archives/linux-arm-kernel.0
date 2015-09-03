From: linux.amoon@gmail.com (Anand Moon)
Date: Thu,  3 Sep 2015 04:10:29 +0000
Subject: [PATCH] ARM: exynos_defconfig: Make S3C2410_WATCHDOG as loadable
 module
Message-ID: <1441253429-3264-1-git-send-email-linux.amoon@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

S3C2410_WATCHDOG watchdog drivers should not be loaded automatically,
but only if a watchdog daemon is installed.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 arch/arm/configs/exynos_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/configs/exynos_defconfig b/arch/arm/configs/exynos_defconfig
index aaf7aa4..b5d382e 100644
--- a/arch/arm/configs/exynos_defconfig
+++ b/arch/arm/configs/exynos_defconfig
@@ -101,7 +101,7 @@ CONFIG_CPU_THERMAL=y
 CONFIG_THERMAL_EMULATION=y
 CONFIG_EXYNOS_THERMAL=y
 CONFIG_WATCHDOG=y
-CONFIG_S3C2410_WATCHDOG=y
+CONFIG_S3C2410_WATCHDOG=m
 CONFIG_MFD_CROS_EC=y
 CONFIG_MFD_CROS_EC_I2C=y
 CONFIG_MFD_CROS_EC_SPI=y
-- 
2.1.4
