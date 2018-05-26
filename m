From: linus.walleij@linaro.org (Linus Walleij)
Date: Sat, 26 May 2018 18:37:34 +0200
Subject: [PATCH] ARM: Fix i2c-gpio GPIO descriptor tables
Message-ID: <20180526163734.30098-1-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I used bad names in my clumsiness when rewriting many board
files to use GPIO descriptors instead of platform data. A few
had the platform_device ID set to -1 which would indeed give
the device name "i2c-gpio".

But several had it set to >=0 which gives the names
"i2c-gpio.0", "i2c-gpio.1" ...

Fix the offending instances in the ARM tree. Sorry for the
mess.

Fixes: b2e63555592f ("i2c: gpio: Convert to use descriptors")
Cc: Wolfram Sang <wsa@the-dreams.de>
Cc: Simon Guinot <simon.guinot@sequanux.org>
Reported-by: Simon Guinot <simon.guinot@sequanux.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ARM SoC folks: please apply this directly for fixes if
it check out fine.
(The fact that it took so long to discover tells us something
about how used these board files are.)
---
 arch/arm/mach-ep93xx/core.c          | 2 +-
 arch/arm/mach-ixp4xx/avila-setup.c   | 2 +-
 arch/arm/mach-ixp4xx/dsmg600-setup.c | 2 +-
 arch/arm/mach-ixp4xx/fsg-setup.c     | 2 +-
 arch/arm/mach-ixp4xx/ixdp425-setup.c | 2 +-
 arch/arm/mach-ixp4xx/nas100d-setup.c | 2 +-
 arch/arm/mach-ixp4xx/nslu2-setup.c   | 2 +-
 arch/arm/mach-pxa/palmz72.c          | 2 +-
 arch/arm/mach-pxa/viper.c            | 4 ++--
 arch/arm/mach-sa1100/simpad.c        | 2 +-
 10 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-ep93xx/core.c b/arch/arm/mach-ep93xx/core.c
index e70feec6fad5..0581ffbedddd 100644
--- a/arch/arm/mach-ep93xx/core.c
+++ b/arch/arm/mach-ep93xx/core.c
@@ -323,7 +323,7 @@ void __init ep93xx_register_eth(struct ep93xx_eth_data *data, int copy_addr)
 
 /* All EP93xx devices use the same two GPIO pins for I2C bit-banging */
 static struct gpiod_lookup_table ep93xx_i2c_gpiod_table = {
-	.dev_id		= "i2c-gpio",
+	.dev_id		= "i2c-gpio.0",
 	.table		= {
 		/* Use local offsets on gpiochip/port "G" */
 		GPIO_LOOKUP_IDX("G", 1, NULL, 0,
diff --git a/arch/arm/mach-ixp4xx/avila-setup.c b/arch/arm/mach-ixp4xx/avila-setup.c
index 77def6169f50..44cbbce6bda6 100644
--- a/arch/arm/mach-ixp4xx/avila-setup.c
+++ b/arch/arm/mach-ixp4xx/avila-setup.c
@@ -51,7 +51,7 @@ static struct platform_device avila_flash = {
 };
 
 static struct gpiod_lookup_table avila_i2c_gpiod_table = {
-	.dev_id		= "i2c-gpio",
+	.dev_id		= "i2c-gpio.0",
 	.table		= {
 		GPIO_LOOKUP_IDX("IXP4XX_GPIO_CHIP", AVILA_SDA_PIN,
 				NULL, 0, GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN),
diff --git a/arch/arm/mach-ixp4xx/dsmg600-setup.c b/arch/arm/mach-ixp4xx/dsmg600-setup.c
index 0f5c99941a7d..397190f3a8da 100644
--- a/arch/arm/mach-ixp4xx/dsmg600-setup.c
+++ b/arch/arm/mach-ixp4xx/dsmg600-setup.c
@@ -70,7 +70,7 @@ static struct platform_device dsmg600_flash = {
 };
 
 static struct gpiod_lookup_table dsmg600_i2c_gpiod_table = {
-	.dev_id		= "i2c-gpio",
+	.dev_id		= "i2c-gpio.0",
 	.table		= {
 		GPIO_LOOKUP_IDX("IXP4XX_GPIO_CHIP", DSMG600_SDA_PIN,
 				NULL, 0, GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN),
diff --git a/arch/arm/mach-ixp4xx/fsg-setup.c b/arch/arm/mach-ixp4xx/fsg-setup.c
index 033f79b35d51..f0a152e365b1 100644
--- a/arch/arm/mach-ixp4xx/fsg-setup.c
+++ b/arch/arm/mach-ixp4xx/fsg-setup.c
@@ -56,7 +56,7 @@ static struct platform_device fsg_flash = {
 };
 
 static struct gpiod_lookup_table fsg_i2c_gpiod_table = {
-	.dev_id		= "i2c-gpio",
+	.dev_id		= "i2c-gpio.0",
 	.table		= {
 		GPIO_LOOKUP_IDX("IXP4XX_GPIO_CHIP", FSG_SDA_PIN,
 				NULL, 0, GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN),
diff --git a/arch/arm/mach-ixp4xx/ixdp425-setup.c b/arch/arm/mach-ixp4xx/ixdp425-setup.c
index b168e2fbdbeb..3ec829d52cdd 100644
--- a/arch/arm/mach-ixp4xx/ixdp425-setup.c
+++ b/arch/arm/mach-ixp4xx/ixdp425-setup.c
@@ -124,7 +124,7 @@ static struct platform_device ixdp425_flash_nand = {
 #endif	/* CONFIG_MTD_NAND_PLATFORM */
 
 static struct gpiod_lookup_table ixdp425_i2c_gpiod_table = {
-	.dev_id		= "i2c-gpio",
+	.dev_id		= "i2c-gpio.0",
 	.table		= {
 		GPIO_LOOKUP_IDX("IXP4XX_GPIO_CHIP", IXDP425_SDA_PIN,
 				NULL, 0, GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN),
diff --git a/arch/arm/mach-ixp4xx/nas100d-setup.c b/arch/arm/mach-ixp4xx/nas100d-setup.c
index 76dfff03cb71..4138d6aa4c52 100644
--- a/arch/arm/mach-ixp4xx/nas100d-setup.c
+++ b/arch/arm/mach-ixp4xx/nas100d-setup.c
@@ -102,7 +102,7 @@ static struct platform_device nas100d_leds = {
 };
 
 static struct gpiod_lookup_table nas100d_i2c_gpiod_table = {
-	.dev_id		= "i2c-gpio",
+	.dev_id		= "i2c-gpio.0",
 	.table		= {
 		GPIO_LOOKUP_IDX("IXP4XX_GPIO_CHIP", NAS100D_SDA_PIN,
 				NULL, 0, GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN),
diff --git a/arch/arm/mach-ixp4xx/nslu2-setup.c b/arch/arm/mach-ixp4xx/nslu2-setup.c
index 91da63a7d7b5..341b263482ef 100644
--- a/arch/arm/mach-ixp4xx/nslu2-setup.c
+++ b/arch/arm/mach-ixp4xx/nslu2-setup.c
@@ -70,7 +70,7 @@ static struct platform_device nslu2_flash = {
 };
 
 static struct gpiod_lookup_table nslu2_i2c_gpiod_table = {
-	.dev_id		= "i2c-gpio",
+	.dev_id		= "i2c-gpio.0",
 	.table		= {
 		GPIO_LOOKUP_IDX("IXP4XX_GPIO_CHIP", NSLU2_SDA_PIN,
 				NULL, 0, GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN),
diff --git a/arch/arm/mach-pxa/palmz72.c b/arch/arm/mach-pxa/palmz72.c
index 5877e547cecd..0adb1bd6208e 100644
--- a/arch/arm/mach-pxa/palmz72.c
+++ b/arch/arm/mach-pxa/palmz72.c
@@ -322,7 +322,7 @@ static struct soc_camera_link palmz72_iclink = {
 };
 
 static struct gpiod_lookup_table palmz72_i2c_gpiod_table = {
-	.dev_id		= "i2c-gpio",
+	.dev_id		= "i2c-gpio.0",
 	.table		= {
 		GPIO_LOOKUP_IDX("gpio-pxa", 118, NULL, 0,
 				GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN),
diff --git a/arch/arm/mach-pxa/viper.c b/arch/arm/mach-pxa/viper.c
index 90d0f277de55..207dcc2e94e7 100644
--- a/arch/arm/mach-pxa/viper.c
+++ b/arch/arm/mach-pxa/viper.c
@@ -460,7 +460,7 @@ static struct platform_device smc91x_device = {
 
 /* i2c */
 static struct gpiod_lookup_table viper_i2c_gpiod_table = {
-	.dev_id		= "i2c-gpio",
+	.dev_id		= "i2c-gpio.1",
 	.table		= {
 		GPIO_LOOKUP_IDX("gpio-pxa", VIPER_RTC_I2C_SDA_GPIO,
 				NULL, 0, GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN),
@@ -789,7 +789,7 @@ static int __init viper_tpm_setup(char *str)
 __setup("tpm=", viper_tpm_setup);
 
 struct gpiod_lookup_table viper_tpm_i2c_gpiod_table = {
-	.dev_id = "i2c-gpio",
+	.dev_id = "i2c-gpio.2",
 	.table = {
 		GPIO_LOOKUP_IDX("gpio-pxa", VIPER_TPM_I2C_SDA_GPIO,
 				NULL, 0, GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN),
diff --git a/arch/arm/mach-sa1100/simpad.c b/arch/arm/mach-sa1100/simpad.c
index ace010479eb6..f45aed2519ba 100644
--- a/arch/arm/mach-sa1100/simpad.c
+++ b/arch/arm/mach-sa1100/simpad.c
@@ -327,7 +327,7 @@ static struct platform_device simpad_gpio_leds = {
  * i2c
  */
 static struct gpiod_lookup_table simpad_i2c_gpiod_table = {
-	.dev_id = "i2c-gpio",
+	.dev_id = "i2c-gpio.0",
 	.table = {
 		GPIO_LOOKUP_IDX("gpio", 21, NULL, 0,
 				GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN),
-- 
2.17.0
