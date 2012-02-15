From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 15 Feb 2012 14:49:07 -0800
Subject: [PATCH] ARM: S3C64XX: Supply platform data for SPI on Cragganmore
Message-ID: <1329346147-1776-1-git-send-email-broonie@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Having to specify the platform data explicitly like this even though it
is provided as a default doesn't feel entirely elegant but there we are.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 arch/arm/mach-s3c64xx/mach-crag6410.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-s3c64xx/mach-crag6410.c b/arch/arm/mach-s3c64xx/mach-crag6410.c
index d5a7982..c05e070 100644
--- a/arch/arm/mach-s3c64xx/mach-crag6410.c
+++ b/arch/arm/mach-s3c64xx/mach-crag6410.c
@@ -790,7 +790,7 @@ static void __init crag6410_machine_init(void)
 	i2c_register_board_info(1, i2c_devs1, ARRAY_SIZE(i2c_devs1));
 
 	samsung_keypad_set_platdata(&crag6410_keypad_data);
-	s3c64xx_spi0_set_platdata(NULL, 0, 1);
+	s3c64xx_spi0_set_platdata(&s3c64xx_spi0_pdata, 0, 1);
 
 	platform_add_devices(crag6410_devices, ARRAY_SIZE(crag6410_devices));
 
-- 
1.7.9.rc1
