From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 23 Dec 2013 11:07:10 +0900
Subject: [PATCH 14/26] ARM: shmobile: lager: mark GPIO keys as wake-up sources
In-Reply-To: <cover.1387763524.git.horms+renesas@verge.net.au>
References: <cover.1387763524.git.horms+renesas@verge.net.au>
Message-ID: <e0554d90b076da1c543b42599c1d6636286ca47f.1387763524.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shinya Kuribayashi <shinya.kuribayashi.px@renesas.com>

Enable wakeup for the GPIO keys on the Lager board.

Signed-off-by: Shinya Kuribayashi <shinya.kuribayashi.px@renesas.com>
Signed-off-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-lager.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/board-lager.c b/arch/arm/mach-shmobile/board-lager.c
index fcf06fd..f5dab34 100644
--- a/arch/arm/mach-shmobile/board-lager.c
+++ b/arch/arm/mach-shmobile/board-lager.c
@@ -121,7 +121,7 @@ static const struct gpio_led_platform_data lager_leds_pdata __initconst = {
 /* GPIO KEY */
 #define GPIO_KEY(c, g, d, ...) \
 	{ .code = c, .gpio = g, .desc = d, .active_low = 1, \
-	  .debounce_interval = 20 }
+	  .wakeup = 1, .debounce_interval = 20 }
 
 static struct gpio_keys_button gpio_buttons[] = {
 	GPIO_KEY(KEY_4,		RCAR_GP_PIN(1, 28),	"SW2-pin4"),
-- 
1.8.4
