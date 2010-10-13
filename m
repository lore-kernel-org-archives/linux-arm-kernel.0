From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 13 Oct 2010 20:36:43 +0100
Subject: [PATCH 2.6.36] S3C64XX: Fix special function for IISv4 port
Message-ID: <1286998603-20401-1-git-send-email-broonie@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When converting to use s3c_gpio_cfgpin_range() the function for the
IISv4 block appears to have been typoed as 4 (the keypad) rather than
5 as it should be.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 arch/arm/mach-s3c64xx/dev-audio.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-s3c64xx/dev-audio.c b/arch/arm/mach-s3c64xx/dev-audio.c
index e53764e..76426a3 100644
--- a/arch/arm/mach-s3c64xx/dev-audio.c
+++ b/arch/arm/mach-s3c64xx/dev-audio.c
@@ -49,7 +49,7 @@ static int s3c64xx_i2sv4_cfg_gpio(struct platform_device *pdev)
 	s3c_gpio_cfgpin(S3C64XX_GPC(4), S3C_GPIO_SFN(5));
 	s3c_gpio_cfgpin(S3C64XX_GPC(5), S3C_GPIO_SFN(5));
 	s3c_gpio_cfgpin(S3C64XX_GPC(7), S3C_GPIO_SFN(5));
-	s3c_gpio_cfgpin_range(S3C64XX_GPH(6), 4, S3C_GPIO_SFN(4));
+	s3c_gpio_cfgpin_range(S3C64XX_GPH(6), 4, S3C_GPIO_SFN(5));
 
 	return 0;
 }
-- 
1.7.1
