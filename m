From: ben-linux@fluff.org (Ben Dooks)
Date: Mon, 18 Jan 2010 08:45:11 +0000
Subject: [PATCH] ARM: S3C: Rename s3c_device_usb to s3c_device_ohci
In-Reply-To: <1263804317-8996-1-git-send-email-ben-linux@fluff.org>
References: <1263804317-8996-1-git-send-email-ben-linux@fluff.org>
Message-ID: <1263804317-8996-2-git-send-email-ben-linux@fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Prepare for the forthcoming device changes by renaming s3c_device_usb to
s3c_device_ohci as this is what the device represents.

Signed-off-by: Ben Dooks <ben-linux@fluff.org>
---
 arch/arm/mach-s3c2410/mach-amlm5900.c   |    2 +-
 arch/arm/mach-s3c2410/mach-bast.c       |    2 +-
 arch/arm/mach-s3c2410/mach-h1940.c      |    2 +-
 arch/arm/mach-s3c2410/mach-n30.c        |    2 +-
 arch/arm/mach-s3c2410/mach-otom.c       |    2 +-
 arch/arm/mach-s3c2410/mach-qt2410.c     |    2 +-
 arch/arm/mach-s3c2410/mach-smdk2410.c   |    2 +-
 arch/arm/mach-s3c2410/mach-tct_hammer.c |    2 +-
 arch/arm/mach-s3c2410/mach-vr1000.c     |    2 +-
 arch/arm/mach-s3c2410/usb-simtec.c      |    2 +-
 arch/arm/mach-s3c2412/mach-jive.c       |    2 +-
 arch/arm/mach-s3c2412/mach-smdk2413.c   |    2 +-
 arch/arm/mach-s3c2412/mach-vstms.c      |    2 +-
 arch/arm/mach-s3c2440/mach-anubis.c     |    2 +-
 arch/arm/mach-s3c2440/mach-at2440evb.c  |    2 +-
 arch/arm/mach-s3c2440/mach-mini2440.c   |    2 +-
 arch/arm/mach-s3c2440/mach-nexcoder.c   |    2 +-
 arch/arm/mach-s3c2440/mach-rx3715.c     |    2 +-
 arch/arm/mach-s3c2440/mach-smdk2440.c   |    2 +-
 arch/arm/mach-s3c2442/mach-gta02.c      |    4 ++--
 arch/arm/mach-s3c6410/mach-hmt.c        |    2 +-
 arch/arm/mach-s3c6410/mach-smdk6410.c   |    2 +-
 arch/arm/plat-s3c/include/plat/devs.h   |    2 +-
 arch/arm/plat-samsung/dev-usb.c         |    4 ++--
 24 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/arch/arm/mach-s3c2410/mach-amlm5900.c b/arch/arm/mach-s3c2410/mach-amlm5900.c
index 06a84ad..7047317 100644
--- a/arch/arm/mach-s3c2410/mach-amlm5900.c
+++ b/arch/arm/mach-s3c2410/mach-amlm5900.c
@@ -153,7 +153,7 @@ static struct platform_device *amlm5900_devices[] __initdata = {
 	&s3c_device_adc,
 	&s3c_device_wdt,
 	&s3c_device_i2c0,
-	&s3c_device_usb,
+	&s3c_device_ohci,
  	&s3c_device_rtc,
 	&s3c_device_usbgadget,
         &s3c_device_sdi,
diff --git a/arch/arm/mach-s3c2410/mach-bast.c b/arch/arm/mach-s3c2410/mach-bast.c
index 97162fd..02b1b62 100644
--- a/arch/arm/mach-s3c2410/mach-bast.c
+++ b/arch/arm/mach-s3c2410/mach-bast.c
@@ -584,7 +584,7 @@ static struct s3c_hwmon_pdata bast_hwmon_info = {
 // cat /sys/devices/platform/s3c24xx-adc/s3c-hwmon/in_0
 
 static struct platform_device *bast_devices[] __initdata = {
-	&s3c_device_usb,
+	&s3c_device_ohci,
 	&s3c_device_lcd,
 	&s3c_device_wdt,
 	&s3c_device_i2c0,
diff --git a/arch/arm/mach-s3c2410/mach-h1940.c b/arch/arm/mach-s3c2410/mach-h1940.c
index 1e34abe..3f9217d 100644
--- a/arch/arm/mach-s3c2410/mach-h1940.c
+++ b/arch/arm/mach-s3c2410/mach-h1940.c
@@ -272,7 +272,7 @@ static struct platform_device h1940_lcd_powerdev = {
 
 static struct platform_device *h1940_devices[] __initdata = {
 	&s3c_device_ts,
-	&s3c_device_usb,
+	&s3c_device_ohci,
 	&s3c_device_lcd,
 	&s3c_device_wdt,
 	&s3c_device_i2c0,
diff --git a/arch/arm/mach-s3c2410/mach-n30.c b/arch/arm/mach-s3c2410/mach-n30.c
index 0405712..684710f 100644
--- a/arch/arm/mach-s3c2410/mach-n30.c
+++ b/arch/arm/mach-s3c2410/mach-n30.c
@@ -322,7 +322,7 @@ static struct platform_device *n30_devices[] __initdata = {
 	&s3c_device_wdt,
 	&s3c_device_i2c0,
 	&s3c_device_iis,
-	&s3c_device_usb,
+	&s3c_device_ohci,
 	&s3c_device_usbgadget,
 	&n30_button_device,
 	&n30_blue_led,
diff --git a/arch/arm/mach-s3c2410/mach-otom.c b/arch/arm/mach-s3c2410/mach-otom.c
index f6c7261..d8c7f2e 100644
--- a/arch/arm/mach-s3c2410/mach-otom.c
+++ b/arch/arm/mach-s3c2410/mach-otom.c
@@ -92,7 +92,7 @@ static struct platform_device otom_device_nor = {
 /* Standard OTOM devices */
 
 static struct platform_device *otom11_devices[] __initdata = {
-	&s3c_device_usb,
+	&s3c_device_ohci,
 	&s3c_device_lcd,
 	&s3c_device_wdt,
 	&s3c_device_i2c0,
diff --git a/arch/arm/mach-s3c2410/mach-qt2410.c b/arch/arm/mach-s3c2410/mach-qt2410.c
index ab092bc..92a4ec3 100644
--- a/arch/arm/mach-s3c2410/mach-qt2410.c
+++ b/arch/arm/mach-s3c2410/mach-qt2410.c
@@ -246,7 +246,7 @@ static struct platform_device qt2410_spi = {
 /* Board devices */
 
 static struct platform_device *qt2410_devices[] __initdata = {
-	&s3c_device_usb,
+	&s3c_device_ohci,
 	&s3c_device_lcd,
 	&s3c_device_wdt,
 	&s3c_device_i2c0,
diff --git a/arch/arm/mach-s3c2410/mach-smdk2410.c b/arch/arm/mach-s3c2410/mach-smdk2410.c
index c49126c..4522230 100644
--- a/arch/arm/mach-s3c2410/mach-smdk2410.c
+++ b/arch/arm/mach-s3c2410/mach-smdk2410.c
@@ -87,7 +87,7 @@ static struct s3c2410_uartcfg smdk2410_uartcfgs[] __initdata = {
 };
 
 static struct platform_device *smdk2410_devices[] __initdata = {
-	&s3c_device_usb,
+	&s3c_device_ohci,
 	&s3c_device_lcd,
 	&s3c_device_wdt,
 	&s3c_device_i2c0,
diff --git a/arch/arm/mach-s3c2410/mach-tct_hammer.c b/arch/arm/mach-s3c2410/mach-tct_hammer.c
index 8fdb043..929164a 100644
--- a/arch/arm/mach-s3c2410/mach-tct_hammer.c
+++ b/arch/arm/mach-s3c2410/mach-tct_hammer.c
@@ -129,7 +129,7 @@ static struct platform_device *tct_hammer_devices[] __initdata = {
 	&s3c_device_adc,
 	&s3c_device_wdt,
 	&s3c_device_i2c0,
-	&s3c_device_usb,
+	&s3c_device_ohci,
 	&s3c_device_rtc,
 	&s3c_device_usbgadget,
 	&s3c_device_sdi,
diff --git a/arch/arm/mach-s3c2410/mach-vr1000.c b/arch/arm/mach-s3c2410/mach-vr1000.c
index 0d61fb5..9051f0d 100644
--- a/arch/arm/mach-s3c2410/mach-vr1000.c
+++ b/arch/arm/mach-s3c2410/mach-vr1000.c
@@ -334,7 +334,7 @@ static struct i2c_board_info vr1000_i2c_devs[] __initdata = {
 /* devices for this board */
 
 static struct platform_device *vr1000_devices[] __initdata = {
-	&s3c_device_usb,
+	&s3c_device_ohci,
 	&s3c_device_lcd,
 	&s3c_device_wdt,
 	&s3c_device_i2c0,
diff --git a/arch/arm/mach-s3c2410/usb-simtec.c b/arch/arm/mach-s3c2410/usb-simtec.c
index 6b9d0d8..199bb4f 100644
--- a/arch/arm/mach-s3c2410/usb-simtec.c
+++ b/arch/arm/mach-s3c2410/usb-simtec.c
@@ -127,6 +127,6 @@ int usb_simtec_init(void)
 	gpio_direction_output(S3C2410_GPB(4), 1);
 	gpio_direction_input(S3C2410_GPG(10));
 
-	s3c_device_usb.dev.platform_data = &usb_simtec_info;
+	s3c_device_ohci.dev.platform_data = &usb_simtec_info;
 	return 0;
 }
diff --git a/arch/arm/mach-s3c2412/mach-jive.c b/arch/arm/mach-s3c2412/mach-jive.c
index c9fa3fc..14f4798 100644
--- a/arch/arm/mach-s3c2412/mach-jive.c
+++ b/arch/arm/mach-s3c2412/mach-jive.c
@@ -468,7 +468,7 @@ static struct i2c_board_info jive_i2c_devs[] __initdata = {
 /* The platform devices being used. */
 
 static struct platform_device *jive_devices[] __initdata = {
-	&s3c_device_usb,
+	&s3c_device_ohci,
 	&s3c_device_rtc,
 	&s3c_device_wdt,
 	&s3c_device_i2c0,
diff --git a/arch/arm/mach-s3c2412/mach-smdk2413.c b/arch/arm/mach-s3c2412/mach-smdk2413.c
index 9a5e434..437c087 100644
--- a/arch/arm/mach-s3c2412/mach-smdk2413.c
+++ b/arch/arm/mach-s3c2412/mach-smdk2413.c
@@ -104,7 +104,7 @@ static struct s3c2410_udc_mach_info smdk2413_udc_cfg __initdata = {
 
 
 static struct platform_device *smdk2413_devices[] __initdata = {
-	&s3c_device_usb,
+	&s3c_device_ohci,
 	//&s3c_device_lcd,
 	&s3c_device_wdt,
 	&s3c_device_i2c0,
diff --git a/arch/arm/mach-s3c2412/mach-vstms.c b/arch/arm/mach-s3c2412/mach-vstms.c
index a6ba591..3ca9265 100644
--- a/arch/arm/mach-s3c2412/mach-vstms.c
+++ b/arch/arm/mach-s3c2412/mach-vstms.c
@@ -121,7 +121,7 @@ static struct s3c2410_platform_nand __initdata vstms_nand_info = {
 };
 
 static struct platform_device *vstms_devices[] __initdata = {
-	&s3c_device_usb,
+	&s3c_device_ohci,
 	&s3c_device_wdt,
 	&s3c_device_i2c0,
 	&s3c_device_iis,
diff --git a/arch/arm/mach-s3c2440/mach-anubis.c b/arch/arm/mach-s3c2440/mach-anubis.c
index 62a4c3e..b73f78a 100644
--- a/arch/arm/mach-s3c2440/mach-anubis.c
+++ b/arch/arm/mach-s3c2440/mach-anubis.c
@@ -409,7 +409,7 @@ static struct platform_device anubis_device_sm501 = {
 /* Standard Anubis devices */
 
 static struct platform_device *anubis_devices[] __initdata = {
-	&s3c_device_usb,
+	&s3c_device_ohci,
 	&s3c_device_wdt,
 	&s3c_device_adc,
 	&s3c_device_i2c0,
diff --git a/arch/arm/mach-s3c2440/mach-at2440evb.c b/arch/arm/mach-s3c2440/mach-at2440evb.c
index aa69290..0defde6 100644
--- a/arch/arm/mach-s3c2440/mach-at2440evb.c
+++ b/arch/arm/mach-s3c2440/mach-at2440evb.c
@@ -203,7 +203,7 @@ static struct s3c2410fb_mach_info at2440evb_fb_info __initdata = {
 };
 
 static struct platform_device *at2440evb_devices[] __initdata = {
-	&s3c_device_usb,
+	&s3c_device_ohci,
 	&s3c_device_wdt,
 	&s3c_device_adc,
 	&s3c_device_i2c0,
diff --git a/arch/arm/mach-s3c2440/mach-mini2440.c b/arch/arm/mach-s3c2440/mach-mini2440.c
index 2068e90..347eb6d 100644
--- a/arch/arm/mach-s3c2440/mach-mini2440.c
+++ b/arch/arm/mach-s3c2440/mach-mini2440.c
@@ -506,7 +506,7 @@ static struct i2c_board_info mini2440_i2c_devs[] __initdata = {
 };
 
 static struct platform_device *mini2440_devices[] __initdata = {
-	&s3c_device_usb,
+	&s3c_device_ohci,
 	&s3c_device_wdt,
 /*	&s3c_device_adc,*/ /* ADC doesn't like living with touchscreen ! */
 	&s3c_device_i2c0,
diff --git a/arch/arm/mach-s3c2440/mach-nexcoder.c b/arch/arm/mach-s3c2440/mach-nexcoder.c
index d43eded..86a243b 100644
--- a/arch/arm/mach-s3c2440/mach-nexcoder.c
+++ b/arch/arm/mach-s3c2440/mach-nexcoder.c
@@ -106,7 +106,7 @@ static struct platform_device nexcoder_device_nor = {
 /* Standard Nexcoder devices */
 
 static struct platform_device *nexcoder_devices[] __initdata = {
-	&s3c_device_usb,
+	&s3c_device_ohci,
 	&s3c_device_lcd,
 	&s3c_device_wdt,
 	&s3c_device_i2c0,
diff --git a/arch/arm/mach-s3c2440/mach-rx3715.c b/arch/arm/mach-s3c2440/mach-rx3715.c
index a952a13..1e836e5 100644
--- a/arch/arm/mach-s3c2440/mach-rx3715.c
+++ b/arch/arm/mach-s3c2440/mach-rx3715.c
@@ -176,7 +176,7 @@ static struct s3c2410_platform_nand __initdata rx3715_nand_info = {
 };
 
 static struct platform_device *rx3715_devices[] __initdata = {
-	&s3c_device_usb,
+	&s3c_device_ohci,
 	&s3c_device_lcd,
 	&s3c_device_wdt,
 	&s3c_device_i2c0,
diff --git a/arch/arm/mach-s3c2440/mach-smdk2440.c b/arch/arm/mach-s3c2440/mach-smdk2440.c
index ec13e74..df3e9a3 100644
--- a/arch/arm/mach-s3c2440/mach-smdk2440.c
+++ b/arch/arm/mach-s3c2440/mach-smdk2440.c
@@ -150,7 +150,7 @@ static struct s3c2410fb_mach_info smdk2440_fb_info __initdata = {
 };
 
 static struct platform_device *smdk2440_devices[] __initdata = {
-	&s3c_device_usb,
+	&s3c_device_ohci,
 	&s3c_device_lcd,
 	&s3c_device_wdt,
 	&s3c_device_i2c0,
diff --git a/arch/arm/mach-s3c2442/mach-gta02.c b/arch/arm/mach-s3c2442/mach-gta02.c
index 0b4a3a0..825800b 100644
--- a/arch/arm/mach-s3c2442/mach-gta02.c
+++ b/arch/arm/mach-s3c2442/mach-gta02.c
@@ -565,7 +565,7 @@ static void __init gta02_map_io(void)
 /* These are the guys that don't need to be children of PMU. */
 
 static struct platform_device *gta02_devices[] __initdata = {
-	&s3c_device_usb,
+	&s3c_device_ohci,
 	&s3c_device_wdt,
 	&s3c_device_sdi,
 	&s3c_device_usbgadget,
@@ -623,7 +623,7 @@ static void __init gta02_machine_init(void)
 	INIT_DELAYED_WORK(&gta02_charger_work, gta02_charger_worker);
 #endif
 
-	s3c_device_usb.dev.platform_data = &gta02_usb_info;
+	s3c_device_ohci.dev.platform_data = &gta02_usb_info;
 
 	s3c24xx_udc_set_platdata(&gta02_udc_cfg);
 	s3c_nand_set_platdata(&gta02_nand_info);
diff --git a/arch/arm/mach-s3c6410/mach-hmt.c b/arch/arm/mach-s3c6410/mach-hmt.c
index cdd4b53..284886c 100644
--- a/arch/arm/mach-s3c6410/mach-hmt.c
+++ b/arch/arm/mach-s3c6410/mach-hmt.c
@@ -233,7 +233,7 @@ static struct platform_device *hmt_devices[] __initdata = {
 	&s3c_device_i2c0,
 	&s3c_device_nand,
 	&s3c_device_fb,
-	&s3c_device_usb,
+	&s3c_device_ohci,
 	&s3c_device_timer[1],
 	&hmt_backlight_device,
 	&hmt_leds_device,
diff --git a/arch/arm/mach-s3c6410/mach-smdk6410.c b/arch/arm/mach-s3c6410/mach-smdk6410.c
index 8969fe7..e2811fc 100644
--- a/arch/arm/mach-s3c6410/mach-smdk6410.c
+++ b/arch/arm/mach-s3c6410/mach-smdk6410.c
@@ -235,7 +235,7 @@ static struct platform_device *smdk6410_devices[] __initdata = {
 	&s3c_device_i2c0,
 	&s3c_device_i2c1,
 	&s3c_device_fb,
-	&s3c_device_usb,
+	&s3c_device_ohci,
 	&s3c_device_usb_hsotg,
 
 #ifdef CONFIG_REGULATOR
diff --git a/arch/arm/plat-s3c/include/plat/devs.h b/arch/arm/plat-s3c/include/plat/devs.h
index 8a4153b..543a351 100644
--- a/arch/arm/plat-s3c/include/plat/devs.h
+++ b/arch/arm/plat-s3c/include/plat/devs.h
@@ -34,7 +34,7 @@ extern struct platform_device s3c64xx_device_pcm1;
 
 extern struct platform_device s3c_device_ts;
 extern struct platform_device s3c_device_fb;
-extern struct platform_device s3c_device_usb;
+extern struct platform_device s3c_device_ohci;
 extern struct platform_device s3c_device_lcd;
 extern struct platform_device s3c_device_wdt;
 extern struct platform_device s3c_device_i2c0;
diff --git a/arch/arm/plat-samsung/dev-usb.c b/arch/arm/plat-samsung/dev-usb.c
index 2ee85ab..431ae5d 100644
--- a/arch/arm/plat-samsung/dev-usb.c
+++ b/arch/arm/plat-samsung/dev-usb.c
@@ -36,7 +36,7 @@ static struct resource s3c_usb_resource[] = {
 
 static u64 s3c_device_usb_dmamask = 0xffffffffUL;
 
-struct platform_device s3c_device_usb = {
+struct platform_device s3c_device_ohci = {
 	.name		  = "s3c2410-ohci",
 	.id		  = -1,
 	.num_resources	  = ARRAY_SIZE(s3c_usb_resource),
@@ -47,4 +47,4 @@ struct platform_device s3c_device_usb = {
 	}
 };
 
-EXPORT_SYMBOL(s3c_device_usb);
+EXPORT_SYMBOL(s3c_device_ohci);
-- 
1.6.0.4
