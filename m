From: broonie@kernel.org (Mark Brown)
Date: Thu, 21 Jan 2016 18:25:18 +0000
Subject: [PATCH] ARM: s3c64xx: Select GPIO_GENERIC_PLATFORM for Cragganmore
Message-ID: <1453400718-26720-1-git-send-email-broonie@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Cragganmore machine driver provides platform data for the generic GPIO
platform driver which uses structures only defined if the driver is
enabled. Since there is little reason to use the platform without the GPIOs
add a select to avoid build failures.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm/mach-s3c64xx/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-s3c64xx/Kconfig b/arch/arm/mach-s3c64xx/Kconfig
index 7c0c420c3016..98d2aa9393f1 100644
--- a/arch/arm/mach-s3c64xx/Kconfig
+++ b/arch/arm/mach-s3c64xx/Kconfig
@@ -310,6 +310,7 @@ config MACH_WLF_CRAGG_6410
 	depends on I2C=y
 	select CPU_S3C6410
 	select LEDS_GPIO_REGISTER
+	select GPIO_GENERIC_PLATFORM
 	select S3C64XX_DEV_SPI0
 	select S3C64XX_SETUP_FB_24BPP
 	select S3C64XX_SETUP_I2C1
-- 
2.7.0.rc3
