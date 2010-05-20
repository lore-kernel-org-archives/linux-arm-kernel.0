From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 20 May 2010 16:21:30 +0900
Subject: [PATCH 3/5] ARM: SMDK6410: Add Watchdog support for SMDK6410
In-Reply-To: <1274340092-10706-1-git-send-email-kgene.kim@samsung.com>
References: <1274340092-10706-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1274340092-10706-4-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Banajit Goswami <banajit.g@samsung.com>

This patch adds support for Watchdog timer for Samsung S3C6410

Signed-off-by: Banajit Goswami <banajit.g@samsung.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-s3c64xx/Kconfig            |    2 ++
 arch/arm/mach-s3c64xx/include/mach/map.h |    1 +
 arch/arm/mach-s3c64xx/mach-smdk6410.c    |    1 +
 3 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s3c64xx/Kconfig b/arch/arm/mach-s3c64xx/Kconfig
index 959df38..c3822fb 100644
--- a/arch/arm/mach-s3c64xx/Kconfig
+++ b/arch/arm/mach-s3c64xx/Kconfig
@@ -91,6 +91,8 @@ config MACH_SMDK6410
 	select S3C_DEV_FB
 	select S3C_DEV_USB_HOST
 	select S3C_DEV_USB_HSOTG
+	select S3C_DEV_WDT
+	select HAVE_S3C2410_WATCHDOG
 	select S3C64XX_SETUP_SDHCI
 	select S3C64XX_SETUP_I2C1
 	select S3C64XX_SETUP_FB_24BPP
diff --git a/arch/arm/mach-s3c64xx/include/mach/map.h b/arch/arm/mach-s3c64xx/include/mach/map.h
index 801c1c0..ab06afd 100644
--- a/arch/arm/mach-s3c64xx/include/mach/map.h
+++ b/arch/arm/mach-s3c64xx/include/mach/map.h
@@ -103,5 +103,6 @@
 #define S3C_PA_USBHOST		S3C64XX_PA_USBHOST
 #define S3C_PA_USB_HSOTG	S3C64XX_PA_USB_HSOTG
 #define S3C_VA_USB_HSPHY	S3C64XX_VA_USB_HSPHY
+#define S3C_PA_WDT		S3C64XX_PA_WATCHDOG
 
 #endif /* __ASM_ARCH_6400_MAP_H */
diff --git a/arch/arm/mach-s3c64xx/mach-smdk6410.c b/arch/arm/mach-s3c64xx/mach-smdk6410.c
index 10cf64a..d10e26d 100644
--- a/arch/arm/mach-s3c64xx/mach-smdk6410.c
+++ b/arch/arm/mach-s3c64xx/mach-smdk6410.c
@@ -264,6 +264,7 @@ static struct platform_device *smdk6410_devices[] __initdata = {
 	&smdk6410_lcd_powerdev,
 
 	&smdk6410_smsc911x,
+	&s3c_device_wdt,
 };
 
 #ifdef CONFIG_REGULATOR
-- 
1.6.2.5
