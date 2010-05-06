From: Jiri.Pinkava@vscht.cz (Pinkava J.)
Date: Thu, 6 May 2010 15:21:16 +0200
Subject: [PATCH 4/8] Add support for LEDs on Acer n35
In-Reply-To: <4BE2C224.7080907@vscht.cz>
References: <4BE1EBFE.9080601@vscht.cz> <4BE1ED3E.1050201@vscht.cz>
	<4BE1ED86.3010506@vscht.cz> <4BE1EE5F.5090402@vscht.cz>
	<4BE1EE8C.8040900@vscht.cz>
	<20100506012258.GZ6684@trinity.fluff.org>
	<4BE2C18E.6080207@vscht.cz> <4BE2C1D7.4030408@vscht.cz>
	<4BE2C224.7080907@vscht.cz>
Message-ID: <4BE2C24C.9050008@vscht.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



Signed-off-by: Jiri Pinkava <jiri.pinkava@vscht.cz>
---
 arch/arm/mach-s3c2410/mach-n30.c |   33 +++++++++++++++++++++++++++++++++
 1 files changed, 33 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s3c2410/mach-n30.c b/arch/arm/mach-s3c2410/mach-n30.c
index ce1172e..b83eabd 100644
--- a/arch/arm/mach-s3c2410/mach-n30.c
+++ b/arch/arm/mach-s3c2410/mach-n30.c
@@ -264,6 +264,14 @@ static struct s3c24xx_led_platdata n30_blue_led_pdata = {
 	.def_trigger	= "",
 };

+/* This is the blue LED on the device. Originaly used to indicate GPS activity
+ * by flashing. */
+static struct s3c24xx_led_platdata n35_blue_led_pdata = {
+	.name		= "blue_led",
+	.gpio		= S3C2410_GPD(8),
+	.def_trigger	= "",
+};
+
 /* This LED is driven by the battery microcontroller, and is blinking
  * red, blinking green or solid green when the battery is low,
  * charging or full respectively.  By driving GPD9 low, it's possible
@@ -275,6 +283,13 @@ static struct s3c24xx_led_platdata n30_warning_led_pdata = {
 	.def_trigger	= "",
 };

+static struct s3c24xx_led_platdata n35_warning_led_pdata = {
+	.name		= "warning_led",
+	.flags          = S3C24XX_LEDF_ACTLOW | S3C24XX_LEDF_TRISTATE,
+	.gpio		= S3C2410_GPD(9),
+	.def_trigger	= "",
+};
+
 static struct platform_device n30_blue_led = {
 	.name		= "s3c24xx_led",
 	.id		= 1,
@@ -283,6 +298,14 @@ static struct platform_device n30_blue_led = {
 	},
 };

+static struct platform_device n35_blue_led = {
+	.name		= "s3c24xx_led",
+	.id		= 1,
+	.dev		= {
+		.platform_data	= &n35_blue_led_pdata,
+	},
+};
+
 static struct platform_device n30_warning_led = {
 	.name		= "s3c24xx_led",
 	.id		= 2,
@@ -291,6 +314,14 @@ static struct platform_device n30_warning_led = {
 	},
 };

+static struct platform_device n35_warning_led = {
+	.name		= "s3c24xx_led",
+	.id		= 2,
+	.dev		= {
+		.platform_data	= &n35_warning_led_pdata,
+	},
+};
+
 static struct s3c2410fb_display n30_display __initdata = {
 	.type		= S3C2410_LCDCON1_TFT,
 	.width		= 240,
@@ -338,6 +369,8 @@ static struct platform_device *n35_devices[] __initdata = {
 	&s3c_device_rtc,
 	&s3c_device_usbgadget,
 	&n35_button_device,
+	&n35_blue_led,
+	&n35_warning_led,
 };

 static struct s3c2410_platform_i2c __initdata n30_i2ccfg = {
-- 
1.7.1
