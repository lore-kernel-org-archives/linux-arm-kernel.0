From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Thu,  5 Aug 2010 16:08:52 +0200
Subject: [PATCH 18/19] ARM: s3c64xx: don't put smartq7_leds in .init.data
In-Reply-To: <20100805140813.GA13859@pengutronix.de>
References: <20100805140813.GA13859@pengutronix.de>
Message-ID: <1281017333-5563-18-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This fixes a section mismatch found by modpost:

	WARNING: arch/arm/mach-s3c64xx/built-in.o(.data+0x2c1c): Section mismatch in reference from the variable smartq7_led_data to the (unknown reference) .init.data:(unknown)
	The variable smartq7_led_data references
	the (unknown reference) __initdata (unknown)
	If the reference is valid then annotate the
	variable with __init* or __refdata (see linux/init.h) or name the variable:
	*_template, *_timer, *_sht, *_ops, *_probe, *_probe_one, *_console,

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-s3c64xx/mach-smartq7.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-s3c64xx/mach-smartq7.c b/arch/arm/mach-s3c64xx/mach-smartq7.c
index e0bc78e..34e846b 100644
--- a/arch/arm/mach-s3c64xx/mach-smartq7.c
+++ b/arch/arm/mach-s3c64xx/mach-smartq7.c
@@ -58,7 +58,7 @@ static struct platform_device smartq7_lcd_control_device = {
 	.dev.platform_data	= &smartq7_lcd_control,
 };
 
-static struct gpio_led smartq7_leds[] __initdata = {
+static struct gpio_led smartq7_leds[] = {
 	{
 		.name			= "smartq7:red",
 		.active_low		= 1,
-- 
1.7.1
