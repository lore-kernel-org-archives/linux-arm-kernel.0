From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri,  1 Oct 2010 21:04:59 +0900
Subject: [PATCH 02/27] ARM: S3C64XX: Change dev-audio.c to use S3C_GPIO_SFN()
	for special functions
In-Reply-To: <1285934724-5007-1-git-send-email-kgene.kim@samsung.com>
References: <1285934724-5007-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1285934724-5007-3-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ben Dooks <ben-linux@fluff.org>

To aide in changing the gpio code, remove the use of pin-specific configs
and move to using the S3C_GPIO_SFN() versions.

Signed-off-by: Ben Dooks <ben-linux@fluff.org>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-s3c64xx/dev-audio.c |   79 +++++++++++++++++-------------------
 1 files changed, 37 insertions(+), 42 deletions(-)

diff --git a/arch/arm/mach-s3c64xx/dev-audio.c b/arch/arm/mach-s3c64xx/dev-audio.c
index 9648fbc..3787811 100644
--- a/arch/arm/mach-s3c64xx/dev-audio.c
+++ b/arch/arm/mach-s3c64xx/dev-audio.c
@@ -22,27 +22,22 @@
 #include <plat/audio.h>
 #include <plat/gpio-cfg.h>
 
-#include <mach/gpio-bank-c.h>
-#include <mach/gpio-bank-d.h>
-#include <mach/gpio-bank-e.h>
-#include <mach/gpio-bank-h.h>
-
 static int s3c64xx_i2sv3_cfg_gpio(struct platform_device *pdev)
 {
 	switch (pdev->id) {
 	case 0:
-		s3c_gpio_cfgpin(S3C64XX_GPD(0), S3C64XX_GPD0_I2S0_CLK);
-		s3c_gpio_cfgpin(S3C64XX_GPD(1), S3C64XX_GPD1_I2S0_CDCLK);
-		s3c_gpio_cfgpin(S3C64XX_GPD(2), S3C64XX_GPD2_I2S0_LRCLK);
-		s3c_gpio_cfgpin(S3C64XX_GPD(3), S3C64XX_GPD3_I2S0_DI);
-		s3c_gpio_cfgpin(S3C64XX_GPD(4), S3C64XX_GPD4_I2S0_D0);
+		s3c_gpio_cfgpin(S3C64XX_GPD(0), S3C_GPIO_SFN(3));
+		s3c_gpio_cfgpin(S3C64XX_GPD(1), S3C_GPIO_SFN(3));
+		s3c_gpio_cfgpin(S3C64XX_GPD(2), S3C_GPIO_SFN(3));
+		s3c_gpio_cfgpin(S3C64XX_GPD(3), S3C_GPIO_SFN(3));
+		s3c_gpio_cfgpin(S3C64XX_GPD(4), S3C_GPIO_SFN(3));
 		break;
 	case 1:
-		s3c_gpio_cfgpin(S3C64XX_GPE(0), S3C64XX_GPE0_I2S1_CLK);
-		s3c_gpio_cfgpin(S3C64XX_GPE(1), S3C64XX_GPE1_I2S1_CDCLK);
-		s3c_gpio_cfgpin(S3C64XX_GPE(2), S3C64XX_GPE2_I2S1_LRCLK);
-		s3c_gpio_cfgpin(S3C64XX_GPE(3), S3C64XX_GPE3_I2S1_DI);
-		s3c_gpio_cfgpin(S3C64XX_GPE(4), S3C64XX_GPE4_I2S1_D0);
+		s3c_gpio_cfgpin(S3C64XX_GPE(0), S3C_GPIO_SFN(3));
+		s3c_gpio_cfgpin(S3C64XX_GPE(1), S3C_GPIO_SFN(3));
+		s3c_gpio_cfgpin(S3C64XX_GPE(2), S3C_GPIO_SFN(3));
+		s3c_gpio_cfgpin(S3C64XX_GPE(3), S3C_GPIO_SFN(3));
+		s3c_gpio_cfgpin(S3C64XX_GPE(4), S3C_GPIO_SFN(3));
 	default:
 		printk(KERN_DEBUG "Invalid I2S Controller number!");
 		return -EINVAL;
@@ -53,13 +48,13 @@ static int s3c64xx_i2sv3_cfg_gpio(struct platform_device *pdev)
 
 static int s3c64xx_i2sv4_cfg_gpio(struct platform_device *pdev)
 {
-	s3c_gpio_cfgpin(S3C64XX_GPC(4), S3C64XX_GPC4_I2S_V40_DO0);
-	s3c_gpio_cfgpin(S3C64XX_GPC(5), S3C64XX_GPC5_I2S_V40_DO1);
-	s3c_gpio_cfgpin(S3C64XX_GPC(7), S3C64XX_GPC7_I2S_V40_DO2);
-	s3c_gpio_cfgpin(S3C64XX_GPH(6), S3C64XX_GPH6_I2S_V40_BCLK);
-	s3c_gpio_cfgpin(S3C64XX_GPH(7), S3C64XX_GPH7_I2S_V40_CDCLK);
-	s3c_gpio_cfgpin(S3C64XX_GPH(8), S3C64XX_GPH8_I2S_V40_LRCLK);
-	s3c_gpio_cfgpin(S3C64XX_GPH(9), S3C64XX_GPH9_I2S_V40_DI);
+	s3c_gpio_cfgpin(S3C64XX_GPC(4), S3C_GPIO_SFN(5));
+	s3c_gpio_cfgpin(S3C64XX_GPC(5), S3C_GPIO_SFN(5));
+	s3c_gpio_cfgpin(S3C64XX_GPC(7), S3C_GPIO_SFN(5));
+	s3c_gpio_cfgpin(S3C64XX_GPH(6), S3C_GPIO_SFN(4));
+	s3c_gpio_cfgpin(S3C64XX_GPH(7), S3C_GPIO_SFN(4));
+	s3c_gpio_cfgpin(S3C64XX_GPH(8), S3C_GPIO_SFN(4));
+	s3c_gpio_cfgpin(S3C64XX_GPH(9), S3C_GPIO_SFN(4)); 
 
 	return 0;
 }
@@ -170,18 +165,18 @@ static int s3c64xx_pcm_cfg_gpio(struct platform_device *pdev)
 {
 	switch (pdev->id) {
 	case 0:
-		s3c_gpio_cfgpin(S3C64XX_GPD(0), S3C64XX_GPD0_PCM0_SCLK);
-		s3c_gpio_cfgpin(S3C64XX_GPD(1), S3C64XX_GPD1_PCM0_EXTCLK);
-		s3c_gpio_cfgpin(S3C64XX_GPD(2), S3C64XX_GPD2_PCM0_FSYNC);
-		s3c_gpio_cfgpin(S3C64XX_GPD(3), S3C64XX_GPD3_PCM0_SIN);
-		s3c_gpio_cfgpin(S3C64XX_GPD(4), S3C64XX_GPD4_PCM0_SOUT);
+		s3c_gpio_cfgpin(S3C64XX_GPD(0), S3C_GPIO_SFN(2));
+		s3c_gpio_cfgpin(S3C64XX_GPD(1), S3C_GPIO_SFN(2));
+		s3c_gpio_cfgpin(S3C64XX_GPD(2), S3C_GPIO_SFN(2));
+		s3c_gpio_cfgpin(S3C64XX_GPD(3), S3C_GPIO_SFN(2));
+		s3c_gpio_cfgpin(S3C64XX_GPD(4), S3C_GPIO_SFN(2));
 		break;
 	case 1:
-		s3c_gpio_cfgpin(S3C64XX_GPE(0), S3C64XX_GPE0_PCM1_SCLK);
-		s3c_gpio_cfgpin(S3C64XX_GPE(1), S3C64XX_GPE1_PCM1_EXTCLK);
-		s3c_gpio_cfgpin(S3C64XX_GPE(2), S3C64XX_GPE2_PCM1_FSYNC);
-		s3c_gpio_cfgpin(S3C64XX_GPE(3), S3C64XX_GPE3_PCM1_SIN);
-		s3c_gpio_cfgpin(S3C64XX_GPE(4), S3C64XX_GPE4_PCM1_SOUT);
+		s3c_gpio_cfgpin(S3C64XX_GPE(0), S3C_GPIO_SFN(2));
+		s3c_gpio_cfgpin(S3C64XX_GPE(1), S3C_GPIO_SFN(2));
+		s3c_gpio_cfgpin(S3C64XX_GPE(2), S3C_GPIO_SFN(2));
+		s3c_gpio_cfgpin(S3C64XX_GPE(3), S3C_GPIO_SFN(2));
+		s3c_gpio_cfgpin(S3C64XX_GPE(4), S3C_GPIO_SFN(2));
 		break;
 	default:
 		printk(KERN_DEBUG "Invalid PCM Controller number!");
@@ -261,22 +256,22 @@ EXPORT_SYMBOL(s3c64xx_device_pcm1);
 
 static int s3c64xx_ac97_cfg_gpd(struct platform_device *pdev)
 {
-	s3c_gpio_cfgpin(S3C64XX_GPD(0), S3C64XX_GPD0_AC97_BITCLK);
-	s3c_gpio_cfgpin(S3C64XX_GPD(1), S3C64XX_GPD1_AC97_nRESET);
-	s3c_gpio_cfgpin(S3C64XX_GPD(2), S3C64XX_GPD2_AC97_SYNC);
-	s3c_gpio_cfgpin(S3C64XX_GPD(3), S3C64XX_GPD3_AC97_SDI);
-	s3c_gpio_cfgpin(S3C64XX_GPD(4), S3C64XX_GPD4_AC97_SDO);
+	s3c_gpio_cfgpin(S3C64XX_GPD(0), S3C_GPIO_SFN(4));
+	s3c_gpio_cfgpin(S3C64XX_GPD(1), S3C_GPIO_SFN(4));
+	s3c_gpio_cfgpin(S3C64XX_GPD(2), S3C_GPIO_SFN(4));
+	s3c_gpio_cfgpin(S3C64XX_GPD(3), S3C_GPIO_SFN(4));
+	s3c_gpio_cfgpin(S3C64XX_GPD(4), S3C_GPIO_SFN(4));
 
 	return 0;
 }
 
 static int s3c64xx_ac97_cfg_gpe(struct platform_device *pdev)
 {
-	s3c_gpio_cfgpin(S3C64XX_GPE(0), S3C64XX_GPE0_AC97_BITCLK);
-	s3c_gpio_cfgpin(S3C64XX_GPE(1), S3C64XX_GPE1_AC97_nRESET);
-	s3c_gpio_cfgpin(S3C64XX_GPE(2), S3C64XX_GPE2_AC97_SYNC);
-	s3c_gpio_cfgpin(S3C64XX_GPE(3), S3C64XX_GPE3_AC97_SDI);
-	s3c_gpio_cfgpin(S3C64XX_GPE(4), S3C64XX_GPE4_AC97_SDO);
+	s3c_gpio_cfgpin(S3C64XX_GPE(0), S3C_GPIO_SFN(4));
+	s3c_gpio_cfgpin(S3C64XX_GPE(1), S3C_GPIO_SFN(4));
+	s3c_gpio_cfgpin(S3C64XX_GPE(2), S3C_GPIO_SFN(4));
+	s3c_gpio_cfgpin(S3C64XX_GPE(3), S3C_GPIO_SFN(4));
+	s3c_gpio_cfgpin(S3C64XX_GPE(4), S3C_GPIO_SFN(4));
 
 	return 0;
 }
-- 
1.6.2.5
