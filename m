From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 23 Dec 2013 11:07:13 +0900
Subject: [PATCH 08/26] ARM: shmobile: lager: set .debounce_interval
In-Reply-To: <cover.1387763524.git.horms+renesas@verge.net.au>
References: <cover.1387763524.git.horms+renesas@verge.net.au>
Message-ID: <c9fd77d48a72d4210c992c4ee27ef8217a44da03.1387763524.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shinya Kuribayashi <shinya.kuribayashi.px@renesas.com>

In R-Car GPIO hardware block, 'chattering removal' feature can be
enabled on GPIO-n-[3:0] pins, but it's not supported on rest of pins
GPIO-n-[31:4].

Set an appropriate debounce interval, instead.  We could confirm that
spurious/unnecessary GPIO interrupts are prevented by this settings.

Signed-off-by: Shinya Kuribayashi <shinya.kuribayashi.px@renesas.com>
Acked-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-lager.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/board-lager.c b/arch/arm/mach-shmobile/board-lager.c
index 78a31b6..fcf06fd 100644
--- a/arch/arm/mach-shmobile/board-lager.c
+++ b/arch/arm/mach-shmobile/board-lager.c
@@ -120,7 +120,8 @@ static const struct gpio_led_platform_data lager_leds_pdata __initconst = {
 
 /* GPIO KEY */
 #define GPIO_KEY(c, g, d, ...) \
-	{ .code = c, .gpio = g, .desc = d, .active_low = 1 }
+	{ .code = c, .gpio = g, .desc = d, .active_low = 1, \
+	  .debounce_interval = 20 }
 
 static struct gpio_keys_button gpio_buttons[] = {
 	GPIO_KEY(KEY_4,		RCAR_GP_PIN(1, 28),	"SW2-pin4"),
-- 
1.8.4
