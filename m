From: jbe@pengutronix.de (Juergen Beisert)
Date: Sun,  8 Jul 2012 19:12:15 +0200
Subject: [PATCH 01/10] Sound/ARM/Samsung: replace wrong dependency
In-Reply-To: <1341767544-17447-1-git-send-email-jbe@pengutronix.de>
References: <1341767544-17447-1-git-send-email-jbe@pengutronix.de>
Message-ID: <1341767544-17447-2-git-send-email-jbe@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Forcing S3C2410_DMA is a leftover from the Samsung S3C24xx architecture clean
up.
Use S3C24XX_DMA instead, as it automatically selects the corresponding CPU DMA
implementation.

Signed-off-by: Juergen Beisert <jbe@pengutronix.de>
---
 sound/soc/samsung/Kconfig |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/sound/soc/samsung/Kconfig b/sound/soc/samsung/Kconfig
index fe3995c..18a555a 100644
--- a/sound/soc/samsung/Kconfig
+++ b/sound/soc/samsung/Kconfig
@@ -2,7 +2,7 @@ config SND_SOC_SAMSUNG
 	tristate "ASoC support for Samsung"
 	depends on ARCH_S3C24XX || ARCH_S3C64XX || ARCH_S5PC100 || ARCH_S5PV210 || ARCH_S5P64X0 || ARCH_EXYNOS4
 	select S3C64XX_DMA if ARCH_S3C64XX
-	select S3C2410_DMA if ARCH_S3C24XX
+	select S3C24Xx_DMA if ARCH_S3C24XX
 	help
 	  Say Y or M if you want to add support for codecs attached to
 	  the Samsung SoCs' Audio interfaces. You will also need to
@@ -10,7 +10,6 @@ config SND_SOC_SAMSUNG
 
 config SND_S3C24XX_I2S
 	tristate
-	select S3C2410_DMA
 
 config SND_S3C_I2SV2_SOC
 	tristate
@@ -18,7 +17,6 @@ config SND_S3C_I2SV2_SOC
 config SND_S3C2412_SOC_I2S
 	tristate
 	select SND_S3C_I2SV2_SOC
-	select S3C2410_DMA
 
 config SND_SAMSUNG_PCM
 	tristate
-- 
1.7.10
