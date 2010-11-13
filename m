From: kgene.kim@samsung.com (Kukjin Kim)
Date: Sat, 13 Nov 2010 16:28:48 +0900
Subject: [PATCH] ARM: SAMSUNG: Fix HAVE_S3C_RTC warnings
Message-ID: <1289633328-7333-1-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes followng build warnings.
warning: (ARCH_S5P64X0 && <choice> || ARCH_S5PC100 && <choice> ||
          ARCH_S5PV210 && <choice> || ARCH_S5PV310 && <choice>)
          selects HAVE_S3C_RTC which has unmet direct dependencies (RTC_CLASS)

Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/Kconfig |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 30ef76a..bb854cd 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -689,7 +689,7 @@ config ARCH_S5P64X0
 	select HAVE_S3C2410_WATCHDOG if WATCHDOG
 	select ARCH_USES_GETTIMEOFFSET
 	select HAVE_S3C2410_I2C if I2C
-	select HAVE_S3C_RTC
+	select HAVE_S3C_RTC if RTC_CLASS
 	help
 	  Samsung S5P64X0 CPU based systems, such as the Samsung SMDK6440,
 	  SMDK6450.
@@ -712,7 +712,7 @@ config ARCH_S5PC100
 	select ARM_L1_CACHE_SHIFT_6
 	select ARCH_USES_GETTIMEOFFSET
 	select HAVE_S3C2410_I2C if I2C
-	select HAVE_S3C_RTC
+	select HAVE_S3C_RTC if RTC_CLASS
 	select HAVE_S3C2410_WATCHDOG if WATCHDOG
 	help
 	  Samsung S5PC100 series based systems
@@ -727,7 +727,7 @@ config ARCH_S5PV210
 	select ARCH_HAS_CPUFREQ
 	select ARCH_USES_GETTIMEOFFSET
 	select HAVE_S3C2410_I2C if I2C
-	select HAVE_S3C_RTC
+	select HAVE_S3C_RTC if RTC_CLASS
 	select HAVE_S3C2410_WATCHDOG if WATCHDOG
 	help
 	  Samsung S5PV210/S5PC110 series based systems
@@ -739,7 +739,7 @@ config ARCH_S5PV310
 	select GENERIC_GPIO
 	select HAVE_CLK
 	select GENERIC_CLOCKEVENTS
-	select HAVE_S3C_RTC
+	select HAVE_S3C_RTC if RTC_CLASS
 	select HAVE_S3C2410_I2C if I2C
 	select HAVE_S3C2410_WATCHDOG if WATCHDOG
 	help
-- 
1.6.2.5
