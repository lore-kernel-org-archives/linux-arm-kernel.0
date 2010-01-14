From: uri.yosef@gmail.com (Uri Yosef)
Date: Thu, 14 Jan 2010 12:06:32 +0200
Subject: [PATCH] ARM: MINI2440: Fix mini2440 crash on boot due to improper
	__initdata qualifier
Message-ID: <c7df016d1001140206j79bdc36ajda53e632a305107b@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Uri Yosef <uri.yosef@gmail.com>

This patch fix mini2440 crash on boot due to improper __initdata
qualifier on mini2440_led1_pdata.

Signed-off-by: Uri Yosef <uri.yosef@gmail.com>
---

diff -ruN a/arch/arm/mach-s3c2440/mach-mini2440.c
b/arch/arm/mach-s3c2440/mach-mini2440.c
--- a/arch/arm/mach-s3c2440/mach-mini2440.c  2010-01-13 07:15:00.000000000 +0200
+++ b/arch/arm/mach-s3c2440/mach-mini2440.c  2010-01-14 11:45:39.992255745 +0200
@@ -399,35 +399,35 @@

 /* LEDS */

-static struct s3c24xx_led_platdata mini2440_led1_pdata __initdata = {
+static struct s3c24xx_led_platdata mini2440_led1_pdata = {
        .name           = "led1",
        .gpio           = S3C2410_GPB(5),
        .flags          = S3C24XX_LEDF_ACTLOW | S3C24XX_LEDF_TRISTATE,
        .def_trigger    = "heartbeat",
 };

-static struct s3c24xx_led_platdata mini2440_led2_pdata __initdata = {
+static struct s3c24xx_led_platdata mini2440_led2_pdata = {
        .name           = "led2",
        .gpio           = S3C2410_GPB(6),
        .flags          = S3C24XX_LEDF_ACTLOW | S3C24XX_LEDF_TRISTATE,
        .def_trigger    = "nand-disk",
 };

-static struct s3c24xx_led_platdata mini2440_led3_pdata __initdata = {
+static struct s3c24xx_led_platdata mini2440_led3_pdata = {
        .name           = "led3",
        .gpio           = S3C2410_GPB(7),
        .flags          = S3C24XX_LEDF_ACTLOW | S3C24XX_LEDF_TRISTATE,
        .def_trigger    = "mmc0",
 };

-static struct s3c24xx_led_platdata mini2440_led4_pdata __initdata = {
+static struct s3c24xx_led_platdata mini2440_led4_pdata = {
        .name           = "led4",
        .gpio           = S3C2410_GPB(8),
        .flags          = S3C24XX_LEDF_ACTLOW | S3C24XX_LEDF_TRISTATE,
        .def_trigger    = "",
 };

-static struct s3c24xx_led_platdata mini2440_led_backlight_pdata __initdata = {
+static struct s3c24xx_led_platdata mini2440_led_backlight_pdata = {
        .name           = "backlight",
        .gpio           = S3C2410_GPG(4),
        .def_trigger    = "backlight",
