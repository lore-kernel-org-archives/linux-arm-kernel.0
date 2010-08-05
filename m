From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Thu,  5 Aug 2010 16:08:51 +0200
Subject: [PATCH 17/19] ARM: s3c64xx: don't put smartq5_leds in .init.data
In-Reply-To: <20100805140813.GA13859@pengutronix.de>
References: <20100805140813.GA13859@pengutronix.de>
Message-ID: <1281017333-5563-17-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This fixes a section mismatch found by modpost:

	WARNING: arch/arm/mach-s3c64xx/built-in.o(.data+0x2814): Section mismatch in reference from the variable smartq5_led_data to the (unknown reference) .init.data:(unknown)
	The variable smartq5_led_data references
	the (unknown reference) __initdata (unknown)
	If the reference is valid then annotate the
	variable with __init* or __refdata (see linux/init.h) or name the variable:
	*_template, *_timer, *_sht, *_ops, *_probe, *_probe_one, *_console,

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-s3c64xx/mach-smartq5.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-s3c64xx/mach-smartq5.c b/arch/arm/mach-s3c64xx/mach-smartq5.c
index 1d0326e..76deb8c 100644
--- a/arch/arm/mach-s3c64xx/mach-smartq5.c
+++ b/arch/arm/mach-s3c64xx/mach-smartq5.c
@@ -58,7 +58,7 @@ static struct platform_device smartq5_lcd_control_device = {
 	.dev.platform_data	= &smartq5_lcd_control,
 };
 
-static struct gpio_led smartq5_leds[] __initdata = {
+static struct gpio_led smartq5_leds[] = {
 	{
 		.name			= "smartq5:green",
 		.active_low		= 1,
-- 
1.7.1
