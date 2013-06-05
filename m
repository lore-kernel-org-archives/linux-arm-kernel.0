From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  5 Jun 2013 17:25:34 +0900
Subject: [PATCH 043/130] ARM: shmobile: mackerel: Register pinctrl mapping for
 TCA6416
In-Reply-To: <1370420821-28420-1-git-send-email-horms+renesas@verge.net.au>
References: <1370420821-28420-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1370420821-28420-44-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Replace the GPIO-based TCA6416 pinmux configuration by a pinctrl
mapping.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-mackerel.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-mackerel.c b/arch/arm/mach-shmobile/board-mackerel.c
index 8350635..397e73c 100644
--- a/arch/arm/mach-shmobile/board-mackerel.c
+++ b/arch/arm/mach-shmobile/board-mackerel.c
@@ -1387,6 +1387,9 @@ static const struct pinctrl_map mackerel_pinctrl_map[] = {
 	/* ST1232 */
 	PIN_MAP_MUX_GROUP_DEFAULT("0-0055", "pfc-sh7372",
 				  "intc_irq7_0", "intc"),
+	/* TCA6416 */
+	PIN_MAP_MUX_GROUP_DEFAULT("0-0020", "pfc-sh7372",
+				  "intc_irq9_0", "intc"),
 };
 
 #define GPIO_PORT9CR	IOMEM(0xE6051009)
@@ -1464,8 +1467,7 @@ static void __init mackerel_init(void)
 		clk_put(clk);
 	}
 
-	/* enable Keypad */
-	gpio_request(GPIO_FN_IRQ9_42,	NULL);
+	/* Keypad */
 	irq_set_irq_type(IRQ9, IRQ_TYPE_LEVEL_HIGH);
 
 	/* Touchscreen */
-- 
1.8.2.1
