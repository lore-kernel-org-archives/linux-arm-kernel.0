From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 28 Dec 2011 12:26:19 +0000
Subject: [PATCH] ARM: S3C64XX: Remove hsmmc1 from Cragganmore
Message-ID: <1325075179-17187-1-git-send-email-broonie@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The second MMC slot was only present on revision 1 of Cragganmore so
remove it. Only MMC0 and MMC2 are there on production systems.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 arch/arm/mach-s3c64xx/mach-crag6410.c |    8 --------
 1 files changed, 0 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-s3c64xx/mach-crag6410.c b/arch/arm/mach-s3c64xx/mach-crag6410.c
index 1edd7b7a..3600998 100644
--- a/arch/arm/mach-s3c64xx/mach-crag6410.c
+++ b/arch/arm/mach-s3c64xx/mach-crag6410.c
@@ -328,7 +328,6 @@ static struct platform_device wallvdd_device = {
 
 static struct platform_device *crag6410_devices[] __initdata = {
 	&s3c_device_hsmmc0,
-	&s3c_device_hsmmc1,
 	&s3c_device_hsmmc2,
 	&s3c_device_i2c0,
 	&s3c_device_i2c1,
@@ -693,12 +692,6 @@ static struct s3c_sdhci_platdata crag6410_hsmmc2_pdata = {
 	.cd_type		= S3C_SDHCI_CD_PERMANENT,
 };
 
-static struct s3c_sdhci_platdata crag6410_hsmmc1_pdata = {
-	.max_width		= 4,
-	.cd_type		= S3C_SDHCI_CD_GPIO,
-	.ext_cd_gpio		= S3C64XX_GPF(11),
-};
-
 static void crag6410_cfg_sdhci0(struct platform_device *dev, int width)
 {
 	/* Set all the necessary GPG pins to special-function 2 */
@@ -733,7 +726,6 @@ static void __init crag6410_machine_init(void)
 	gpio_direction_output(S3C64XX_GPF(10), 1);
 
 	s3c_sdhci0_set_platdata(&crag6410_hsmmc0_pdata);
-	s3c_sdhci1_set_platdata(&crag6410_hsmmc1_pdata);
 	s3c_sdhci2_set_platdata(&crag6410_hsmmc2_pdata);
 
 	s3c_i2c0_set_platdata(&i2c0_pdata);
-- 
1.7.7.3
