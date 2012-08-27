From: horms@verge.net.au (Simon Horman)
Date: Mon, 27 Aug 2012 15:40:10 +0900
Subject: [PATCH 2/2] ARM: mach-shmobile: armadillo800eva: Enable power button
 as wakeup source
In-Reply-To: <1346049610-2266-1-git-send-email-horms@verge.net.au>
References: <1346049610-2266-1-git-send-email-horms@verge.net.au>
Message-ID: <1346049610-2266-3-git-send-email-horms@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms@verge.net.au>
---
 arch/arm/mach-shmobile/board-armadillo800eva.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-armadillo800eva.c b/arch/arm/mach-shmobile/board-armadillo800eva.c
index a002504..65cb793 100644
--- a/arch/arm/mach-shmobile/board-armadillo800eva.c
+++ b/arch/arm/mach-shmobile/board-armadillo800eva.c
@@ -520,10 +520,11 @@ static struct platform_device hdmi_lcdc_device = {
 };
 
 /* GPIO KEY */
-#define GPIO_KEY(c, g, d) { .code = c, .gpio = g, .desc = d, .active_low = 1 }
+#define GPIO_KEY(c, g, d, ...) \
+	{ .code = c, .gpio = g, .desc = d, .active_low = 1, __VA_ARGS__ }
 
 static struct gpio_keys_button gpio_buttons[] = {
-	GPIO_KEY(KEY_POWER,	GPIO_PORT99,	"SW3"),
+	GPIO_KEY(KEY_POWER,	GPIO_PORT99,	"SW3", .wakeup = 1),
 	GPIO_KEY(KEY_BACK,	GPIO_PORT100,	"SW4"),
 	GPIO_KEY(KEY_MENU,	GPIO_PORT97,	"SW5"),
 	GPIO_KEY(KEY_HOME,	GPIO_PORT98,	"SW6"),
-- 
1.7.10.2.484.gcd07cc5
