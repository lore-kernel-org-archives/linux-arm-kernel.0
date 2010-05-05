From: Jiri.Pinkava@vscht.cz (Pinkava J.)
Date: Thu, 6 May 2010 00:17:03 +0200
Subject: [PATCH 4/9] Add support for blue LED on Acer n35
In-Reply-To: <4BE1ED86.3010506@vscht.cz>
References: <4BE1EBFE.9080601@vscht.cz> <4BE1ED3E.1050201@vscht.cz>
	<4BE1ED86.3010506@vscht.cz>
Message-ID: <4BE1EE5F.5090402@vscht.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Jiri Pinkava <jiri.pinkava@vscht.cz>
---
 arch/arm/mach-s3c2410/mach-n30.c |   17 +++++++++++++++++
 1 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s3c2410/mach-n30.c b/arch/arm/mach-s3c2410/mach-n30.c
index ce1172e..aeabbff 100644
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
@@ -283,6 +291,14 @@ static struct platform_device n30_blue_led = {
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
@@ -338,6 +354,7 @@ static struct platform_device *n35_devices[] __initdata = {
 	&s3c_device_rtc,
 	&s3c_device_usbgadget,
 	&n35_button_device,
+	&n35_blue_led,
 };

 static struct s3c2410_platform_i2c __initdata n30_i2ccfg = {
-- 
1.7.1
