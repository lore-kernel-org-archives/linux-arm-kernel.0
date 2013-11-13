From: magnus.damm@gmail.com (Magnus Damm)
Date: Thu, 14 Nov 2013 07:40:26 +0900
Subject: [PATCH] ARM: shmobile: lager: mark GPIO keys as wake-up sources
Message-ID: <20131113224026.20904.35898.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shinya Kuribayashi <shinya.kuribayashi.px@renesas.com>

Enable wakeup for the GPIO keys on the Lager board.

Signed-off-by: Shinya Kuribayashi <shinya.kuribayashi.px@renesas.com>
Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/board-lager.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- 0002/arch/arm/mach-shmobile/board-lager.c
+++ work/arch/arm/mach-shmobile/board-lager.c	2013-11-13 17:22:08.000000000 +0900
@@ -121,7 +121,7 @@ static const struct gpio_led_platform_da
 /* GPIO KEY */
 #define GPIO_KEY(c, g, d, ...) \
 	{ .code = c, .gpio = g, .desc = d, .active_low = 1, \
-	  .debounce_interval = 20 }
+	  .wakeup = 1, .debounce_interval = 20 }
 
 static struct gpio_keys_button gpio_buttons[] = {
 	GPIO_KEY(KEY_4,		RCAR_GP_PIN(1, 28),	"SW2-pin4"),
