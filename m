From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 20 Sep 2010 15:38:11 +0900
Subject: [PATCH 2/2] ARM: S5PV310: Add support Watchdog Timer
Message-ID: <1284964691-15751-1-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jemings Ko <jemings@samsung.com>

This patch adds support Watchdog Timer for S5PV310 and S5PC210.

Signed-off-by: Jemings Ko <jemings@samsung.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
NOTE: tested on SMDKV310 and SMDKC210.

 arch/arm/Kconfig                      |    1 +
 arch/arm/mach-s5pv310/Kconfig         |    2 ++
 arch/arm/mach-s5pv310/mach-smdkc210.c |    1 +
 arch/arm/mach-s5pv310/mach-smdkv310.c |    1 +
 4 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index efa8d7e..9383020 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -735,6 +735,7 @@ config ARCH_S5PV310
 	select HAVE_CLK
 	select GENERIC_CLOCKEVENTS
 	select HAVE_S3C_RTC
+	select HAVE_S3C2410_WATCHDOG
 	help
 	  Samsung S5PV310 series based systems
 
diff --git a/arch/arm/mach-s5pv310/Kconfig b/arch/arm/mach-s5pv310/Kconfig
index 4de5d72..1d59ce9 100644
--- a/arch/arm/mach-s5pv310/Kconfig
+++ b/arch/arm/mach-s5pv310/Kconfig
@@ -34,6 +34,7 @@ config MACH_SMDKC210
 	select CPU_S5PV310
 	select ARCH_SPARSEMEM_ENABLE
 	select S3C_DEV_RTC
+	select S3C_DEV_WDT
 	help
 	  Machine support for Samsung SMDKC210
 	  S5PC210(MCP) is one of package option of S5PV310
@@ -55,6 +56,7 @@ config MACH_SMDKV310
 	select CPU_S5PV310
 	select ARCH_SPARSEMEM_ENABLE
 	select S3C_DEV_RTC
+	select S3C_DEV_WDT
 	help
 	  Machine support for Samsung SMDKV310
 
diff --git a/arch/arm/mach-s5pv310/mach-smdkc210.c b/arch/arm/mach-s5pv310/mach-smdkc210.c
index 5b34d9e..1384d8b 100644
--- a/arch/arm/mach-s5pv310/mach-smdkc210.c
+++ b/arch/arm/mach-s5pv310/mach-smdkc210.c
@@ -68,6 +68,7 @@ static struct s3c2410_uartcfg smdkc210_uartcfgs[] __initdata = {
 
 static struct platform_device *smdkc210_devices[] __initdata = {
 	&s3c_device_rtc,
+	&s3c_device_wdt,
 };
 
 static void __init smdkc210_map_io(void)
diff --git a/arch/arm/mach-s5pv310/mach-smdkv310.c b/arch/arm/mach-s5pv310/mach-smdkv310.c
index 06062c8..9cb827d 100644
--- a/arch/arm/mach-s5pv310/mach-smdkv310.c
+++ b/arch/arm/mach-s5pv310/mach-smdkv310.c
@@ -68,6 +68,7 @@ static struct s3c2410_uartcfg smdkv310_uartcfgs[] __initdata = {
 
 static struct platform_device *smdkv310_devices[] __initdata = {
 	&s3c_device_rtc,
+	&s3c_device_wdt,
 };
 
 static void __init smdkv310_map_io(void)
-- 
1.6.2.5
