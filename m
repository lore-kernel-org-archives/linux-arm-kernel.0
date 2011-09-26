From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Mon, 26 Sep 2011 08:50:55 +0200
Subject: [PATCH] ARM: imx/mx31moboard: use mc13xxx structs instead of removed
	mc13783 structs
Message-ID: <1317019855-10215-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is needed with patch

	mfd: Remove mc13783 API functions and symbols

(currently cde41c030 in next)

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-imx/mach-mx31moboard.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-imx/mach-mx31moboard.c b/arch/arm/mach-imx/mach-mx31moboard.c
index e910d5f..1dd16c0 100644
--- a/arch/arm/mach-imx/mach-mx31moboard.c
+++ b/arch/arm/mach-imx/mach-mx31moboard.c
@@ -224,7 +224,7 @@ static struct mc13xxx_regulator_init_data moboard_regulators[] = {
 	},
 };
 
-static struct mc13783_led_platform_data moboard_led[] = {
+static struct mc13xxx_led_platform_data moboard_led[] = {
 	{
 		.id = MC13783_LED_R1,
 		.name = "coreboard-led-4:red",
@@ -257,7 +257,7 @@ static struct mc13783_led_platform_data moboard_led[] = {
 	},
 };
 
-static struct mc13783_leds_platform_data moboard_leds = {
+static struct mc13xxx_leds_platform_data moboard_leds = {
 	.num_leds = ARRAY_SIZE(moboard_led),
 	.led = moboard_led,
 	.flags = MC13783_LED_SLEWLIMTC,
@@ -266,7 +266,7 @@ static struct mc13783_leds_platform_data moboard_leds = {
 	.tc2_period = MC13783_LED_PERIOD_10MS,
 };
 
-static struct mc13783_buttons_platform_data moboard_buttons = {
+static struct mc13xxx_buttons_platform_data moboard_buttons = {
 	.b1on_flags = MC13783_BUTTON_DBNC_750MS | MC13783_BUTTON_ENABLE |
 			MC13783_BUTTON_POL_INVERT,
 	.b1on_key = KEY_POWER,
-- 
1.7.6.3
