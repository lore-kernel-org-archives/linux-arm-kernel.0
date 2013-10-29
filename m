From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 29 Oct 2013 17:57:30 +0900
Subject: [PATCH 1/2] ARM: shmobile: lager: set .debounce_interval
In-Reply-To: <1383037051-21427-1-git-send-email-horms+renesas@verge.net.au>
References: <1383037051-21427-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1383037051-21427-2-git-send-email-horms+renesas@verge.net.au>
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
