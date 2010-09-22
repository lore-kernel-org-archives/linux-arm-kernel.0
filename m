From: jacmet@sunsite.dk (Peter Korsgaard)
Date: Wed, 22 Sep 2010 11:31:26 +0200
Subject: [PATCH] at91sam9g45: fix i2c bus speed
Message-ID: <1285147886-17100-1-git-send-email-jacmet@sunsite.dk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use a correct udelay value to get bus speed around 100KHz. The udelay
value was most likely copied from the older devices, but the 9g45
is signicantly faster (400MHz, DDR, ..), so a udelay of 2 gives a
bus speed of around 190KHz, which is too fast for some devices.
A udelay value of 5 gives a bus speed of around 90KHz here.

Signed-off-by: Peter Korsgaard <jacmet@sunsite.dk>
---
 arch/arm/mach-at91/at91sam9g45_devices.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-at91/at91sam9g45_devices.c b/arch/arm/mach-at91/at91sam9g45_devices.c
index 5e71ccd..1276bab 100644
--- a/arch/arm/mach-at91/at91sam9g45_devices.c
+++ b/arch/arm/mach-at91/at91sam9g45_devices.c
@@ -426,7 +426,7 @@ static struct i2c_gpio_platform_data pdata_i2c0 = {
 	.sda_is_open_drain	= 1,
 	.scl_pin		= AT91_PIN_PA21,
 	.scl_is_open_drain	= 1,
-	.udelay			= 2,		/* ~100 kHz */
+	.udelay			= 5,		/* ~100 kHz */
 };
 
 static struct platform_device at91sam9g45_twi0_device = {
@@ -440,7 +440,7 @@ static struct i2c_gpio_platform_data pdata_i2c1 = {
 	.sda_is_open_drain	= 1,
 	.scl_pin		= AT91_PIN_PB11,
 	.scl_is_open_drain	= 1,
-	.udelay			= 2,		/* ~100 kHz */
+	.udelay			= 5,		/* ~100 kHz */
 };
 
 static struct platform_device at91sam9g45_twi1_device = {
-- 
1.7.1
