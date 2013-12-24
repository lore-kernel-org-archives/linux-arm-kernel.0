From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 24 Dec 2013 23:18:07 +0900
Subject: [PATCH 03/12] ARM: shmobile: armadillo: Set backlight enable GPIO
In-Reply-To: <cover.1387891831.git.horms+renesas@verge.net.au>
References: <cover.1387891831.git.horms+renesas@verge.net.au>
Message-ID: <9a3beb04ec32cab91a8e562ae068433387b84547.1387891831.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

The Armadillo 800 EVA panel module has a backlight enable signal
connected to GPIO 61. Instead of requesting the GPIO in board code and
setting it to a high level unconditionally, pass the GPIO number to the
PWM backlight driver as the backlight enable GPIO.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-armadillo800eva.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-armadillo800eva.c b/arch/arm/mach-shmobile/board-armadillo800eva.c
index d9e28c7a..2ea8935 100644
--- a/arch/arm/mach-shmobile/board-armadillo800eva.c
+++ b/arch/arm/mach-shmobile/board-armadillo800eva.c
@@ -423,7 +423,7 @@ static struct platform_pwm_backlight_data pwm_backlight_data = {
 	.max_brightness = 255,
 	.dft_brightness = 255,
 	.pwm_period_ns = 33333, /* 30kHz */
-	.enable_gpio = -1,
+	.enable_gpio = 61,
 };
 
 static struct platform_device pwm_backlight_device = {
@@ -1203,9 +1203,6 @@ static void __init eva_init(void)
 	r8a7740_pinmux_init();
 	r8a7740_meram_workaround();
 
-	/* LCDC0 */
-	gpio_request_one(61, GPIOF_OUT_INIT_HIGH, NULL); /* LCDDON */
-
 	/* GETHER */
 	gpio_request_one(18, GPIOF_OUT_INIT_HIGH, NULL); /* PHY_RST */
 
-- 
1.8.4
