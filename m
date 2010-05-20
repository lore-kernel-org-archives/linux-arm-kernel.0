From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 20 May 2010 16:21:32 +0900
Subject: [PATCH 5/5] ARM: S5PV210: Add Watchdog support for S5PV210
In-Reply-To: <1274340092-10706-1-git-send-email-kgene.kim@samsung.com>
References: <1274340092-10706-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1274340092-10706-6-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Banajit Goswami <banajit.g@samsung.com>

This patch adds support for Watchdog timer for Samsung S5PV210.

Signed-off-by: Banajit Goswami <banajit.g@samsung.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-s5pv210/Kconfig            |    4 ++++
 arch/arm/mach-s5pv210/include/mach/map.h |    3 +++
 arch/arm/mach-s5pv210/mach-smdkc110.c    |    1 +
 arch/arm/mach-s5pv210/mach-smdkv210.c    |    1 +
 4 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s5pv210/Kconfig b/arch/arm/mach-s5pv210/Kconfig
index af33a1a..8931d8a 100644
--- a/arch/arm/mach-s5pv210/Kconfig
+++ b/arch/arm/mach-s5pv210/Kconfig
@@ -24,6 +24,8 @@ config MACH_SMDKV210
 	bool "SMDKV210"
 	select CPU_S5PV210
 	select ARCH_SPARSEMEM_ENABLE
+	select S3C_DEV_WDT
+	select HAVE_S3C2410_WATCHDOG
 	help
 	  Machine support for Samsung SMDKV210
 
@@ -31,6 +33,8 @@ config MACH_SMDKC110
 	bool "SMDKC110"
 	select CPU_S5PV210
 	select ARCH_SPARSEMEM_ENABLE
+	select S3C_DEV_WDT
+	select HAVE_S3C2410_WATCHDOG
 	help
 	  Machine support for Samsung SMDKC110
 	  S5PC110(MCP) is one of package option of S5PV210
diff --git a/arch/arm/mach-s5pv210/include/mach/map.h b/arch/arm/mach-s5pv210/include/mach/map.h
index c22694c..c37f2c5 100644
--- a/arch/arm/mach-s5pv210/include/mach/map.h
+++ b/arch/arm/mach-s5pv210/include/mach/map.h
@@ -32,6 +32,8 @@
 
 #define S5PV210_PA_SYSTIMER	(0xE2600000)
 
+#define S5PV210_PA_WATCHDOG	(0xE2700000)
+
 #define S5PV210_PA_UART		(0xE2900000)
 
 #define S5P_PA_UART0		(S5PV210_PA_UART + 0x0)
@@ -61,5 +63,6 @@
 /* compatibiltiy defines. */
 #define S3C_PA_UART		S5PV210_PA_UART
 #define S3C_PA_IIC		S5PV210_PA_IIC0
+#define S3C_PA_WDT		S5PV210_PA_WATCHDOG
 
 #endif /* __ASM_ARCH_MAP_H */
diff --git a/arch/arm/mach-s5pv210/mach-smdkc110.c b/arch/arm/mach-s5pv210/mach-smdkc110.c
index ab4869d..6af4ccf 100644
--- a/arch/arm/mach-s5pv210/mach-smdkc110.c
+++ b/arch/arm/mach-s5pv210/mach-smdkc110.c
@@ -72,6 +72,7 @@ static struct s3c2410_uartcfg smdkv210_uartcfgs[] __initdata = {
 };
 
 static struct platform_device *smdkc110_devices[] __initdata = {
+	&s3c_device_wdt,
 };
 
 static void __init smdkc110_map_io(void)
diff --git a/arch/arm/mach-s5pv210/mach-smdkv210.c b/arch/arm/mach-s5pv210/mach-smdkv210.c
index a278832..8ea203d 100644
--- a/arch/arm/mach-s5pv210/mach-smdkv210.c
+++ b/arch/arm/mach-s5pv210/mach-smdkv210.c
@@ -72,6 +72,7 @@ static struct s3c2410_uartcfg smdkv210_uartcfgs[] __initdata = {
 };
 
 static struct platform_device *smdkv210_devices[] __initdata = {
+	&s3c_device_wdt,
 };
 
 static void __init smdkv210_map_io(void)
-- 
1.6.2.5
