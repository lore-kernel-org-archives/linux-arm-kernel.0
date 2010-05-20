From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 20 May 2010 16:21:31 +0900
Subject: [PATCH 4/5] ARM: S5P6440: Add Watchdog support for S5P6440
In-Reply-To: <1274340092-10706-1-git-send-email-kgene.kim@samsung.com>
References: <1274340092-10706-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1274340092-10706-5-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Banajit Goswami <banajit.g@samsung.com>

This patch adds support for Watchdog timer for Samsung S5P6440.

Signed-off-by: Banajit Goswami <banajit.g@samsung.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-s5p6440/Kconfig            |    2 ++
 arch/arm/mach-s5p6440/include/mach/map.h |    1 +
 arch/arm/mach-s5p6440/mach-smdk6440.c    |    1 +
 3 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s5p6440/Kconfig b/arch/arm/mach-s5p6440/Kconfig
index 4c29ff8..0a0eb5b 100644
--- a/arch/arm/mach-s5p6440/Kconfig
+++ b/arch/arm/mach-s5p6440/Kconfig
@@ -15,6 +15,8 @@ config CPU_S5P6440
 config MACH_SMDK6440
 	bool "SMDK6440"
 	select CPU_S5P6440
+	select S3C_DEV_WDT
+	select HAVE_S3C2410_WATCHDOG
 	help
 	  Machine support for the Samsung SMDK6440
 
diff --git a/arch/arm/mach-s5p6440/include/mach/map.h b/arch/arm/mach-s5p6440/include/mach/map.h
index 8924e5a..c015de6 100644
--- a/arch/arm/mach-s5p6440/include/mach/map.h
+++ b/arch/arm/mach-s5p6440/include/mach/map.h
@@ -64,5 +64,6 @@
 /* compatibiltiy defines. */
 #define S3C_PA_UART		S5P6440_PA_UART
 #define S3C_PA_IIC		S5P6440_PA_IIC0
+#define S3C_PA_WDT		S5P6440_PA_WDT
 
 #endif /* __ASM_ARCH_MAP_H */
diff --git a/arch/arm/mach-s5p6440/mach-smdk6440.c b/arch/arm/mach-s5p6440/mach-smdk6440.c
index 3ae88f2..ae50345 100644
--- a/arch/arm/mach-s5p6440/mach-smdk6440.c
+++ b/arch/arm/mach-s5p6440/mach-smdk6440.c
@@ -84,6 +84,7 @@ static struct s3c2410_uartcfg smdk6440_uartcfgs[] __initdata = {
 };
 
 static struct platform_device *smdk6440_devices[] __initdata = {
+	&s3c_device_wdt,
 };
 
 static void __init smdk6440_map_io(void)
-- 
1.6.2.5
