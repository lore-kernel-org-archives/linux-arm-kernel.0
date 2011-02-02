From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed,  2 Feb 2011 13:22:31 +0000
Subject: [PATCH] ARM: S3C64XX: Staticise non-exported GPIO to interrupt
	functions
Message-ID: <1296652951-26928-1-git-send-email-broonie@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

No need to put these in the global namespace and sparse gets upset.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 arch/arm/mach-s3c64xx/gpiolib.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-s3c64xx/gpiolib.c b/arch/arm/mach-s3c64xx/gpiolib.c
index fd99a82..92b0908 100644
--- a/arch/arm/mach-s3c64xx/gpiolib.c
+++ b/arch/arm/mach-s3c64xx/gpiolib.c
@@ -72,7 +72,7 @@ static struct s3c_gpio_cfg gpio_4bit_cfg_eint0011 = {
 	.get_pull	= s3c_gpio_getpull_updown,
 };
 
-int s3c64xx_gpio2int_gpm(struct gpio_chip *chip, unsigned pin)
+static int s3c64xx_gpio2int_gpm(struct gpio_chip *chip, unsigned pin)
 {
 	return pin < 5 ? IRQ_EINT(23) + pin : -ENXIO;
 }
@@ -138,7 +138,7 @@ static struct s3c_gpio_chip gpio_4bit[] = {
 	},
 };
 
-int s3c64xx_gpio2int_gpl(struct gpio_chip *chip, unsigned pin)
+static int s3c64xx_gpio2int_gpl(struct gpio_chip *chip, unsigned pin)
 {
 	return pin >= 8 ? IRQ_EINT(16) + pin - 8 : -ENXIO;
 }
-- 
1.7.2.3
