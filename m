From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  5 Jun 2013 17:25:30 +0900
Subject: [PATCH 039/130] ARM: shmobile: mackerel: Register pinctrl mapping for
 SCIF
In-Reply-To: <1370420821-28420-1-git-send-email-horms+renesas@verge.net.au>
References: <1370420821-28420-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1370420821-28420-40-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Replace the GPIO-based SCIF pinmux configuration by a pinctrl mapping.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-mackerel.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-mackerel.c b/arch/arm/mach-shmobile/board-mackerel.c
index 07eeb55..bd3666b 100644
--- a/arch/arm/mach-shmobile/board-mackerel.c
+++ b/arch/arm/mach-shmobile/board-mackerel.c
@@ -1346,6 +1346,12 @@ static const struct pinctrl_map mackerel_pinctrl_map[] = {
 				  "lcd_data24", "lcd"),
 	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_lcdc_fb.0", "pfc-sh7372",
 				  "lcd_sync", "lcd"),
+	/* SCIFA0 */
+	PIN_MAP_MUX_GROUP_DEFAULT("sh-sci.0", "pfc-sh7372",
+				  "scifa0_data", "scifa0"),
+	/* SCIFA2 (GT-720F GPS module) */
+	PIN_MAP_MUX_GROUP_DEFAULT("sh-sci.2", "pfc-sh7372",
+				  "scifa2_data", "scifa2"),
 	/* SDHI0 */
 	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_sdhi.0", "pfc-sh7372",
 				  "sdhi0_data4", "sdhi0"),
@@ -1414,10 +1420,6 @@ static void __init mackerel_init(void)
 				  ARRAY_SIZE(mackerel_pinctrl_map));
 	sh7372_pinmux_init();
 
-	/* enable SCIFA0 */
-	gpio_request(GPIO_FN_SCIFA0_TXD, NULL);
-	gpio_request(GPIO_FN_SCIFA0_RXD, NULL);
-
 	/* enable SMSC911X */
 	gpio_request(GPIO_FN_CS5A,	NULL);
 	gpio_request(GPIO_FN_IRQ6_39,	NULL);
@@ -1470,10 +1472,6 @@ static void __init mackerel_init(void)
 	/* SDHI0 PORT172 card-detect IRQ26 */
 	gpio_request(GPIO_FN_IRQ26_172, NULL);
 
-	/* enable GPS module (GT-720F) */
-	gpio_request(GPIO_FN_SCIFA2_TXD1, NULL);
-	gpio_request(GPIO_FN_SCIFA2_RXD1, NULL);
-
 	/* Reset HDMI, must be held at least one EXTALR (32768Hz) period */
 	srcr4 = __raw_readl(SRCR4);
 	__raw_writel(srcr4 | (1 << 13), SRCR4);
-- 
1.8.2.1
