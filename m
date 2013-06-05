From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  5 Jun 2013 17:25:40 +0900
Subject: [PATCH 049/130] ARM: shmobile: ap4evb: Register pinctrl mapping for
 LCD
In-Reply-To: <1370420821-28420-1-git-send-email-horms+renesas@verge.net.au>
References: <1370420821-28420-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1370420821-28420-50-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Replace the GPIO-based LCD pinmux configuration by a pinctrl mapping.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-ap4evb.c | 29 +++++++----------------------
 1 file changed, 7 insertions(+), 22 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-ap4evb.c b/arch/arm/mach-shmobile/board-ap4evb.c
index c7a9efc..c6e1e44 100644
--- a/arch/arm/mach-shmobile/board-ap4evb.c
+++ b/arch/arm/mach-shmobile/board-ap4evb.c
@@ -1107,6 +1107,13 @@ static const struct pinctrl_map ap4evb_pinctrl_map[] = {
 				  "keysc_in04_0", "keysc"),
 	PIN_MAP_MUX_GROUP_DEFAULT("sh_keysc", "pfc-sh7372",
 				  "keysc_out5", "keysc"),
+#ifndef CONFIG_AP4EVB_QHD
+	/* LCDC */
+	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_lcdc_fb.0", "pfc-sh7372",
+				  "lcd_data18", "lcd"),
+	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_lcdc_fb.0", "pfc-sh7372",
+				  "lcd_sync", "lcd"),
+#endif
 	/* MMCIF */
 	PIN_MAP_MUX_GROUP_DEFAULT("sh_mmcif.0", "pfc-sh7372",
 				  "mmc0_data8_0", "mmc0"),
@@ -1245,28 +1252,6 @@ static void __init ap4evb_init(void)
 	 * For WVGA Panel (18-bit RGB, CONFIG_AP4EVB_WVGA=y) and
 	 * IRQ7 for Touch Panel, set dip switches S3, S43 to ON, OFF.
 	 */
-
-	gpio_request(GPIO_FN_LCDD17,   NULL);
-	gpio_request(GPIO_FN_LCDD16,   NULL);
-	gpio_request(GPIO_FN_LCDD15,   NULL);
-	gpio_request(GPIO_FN_LCDD14,   NULL);
-	gpio_request(GPIO_FN_LCDD13,   NULL);
-	gpio_request(GPIO_FN_LCDD12,   NULL);
-	gpio_request(GPIO_FN_LCDD11,   NULL);
-	gpio_request(GPIO_FN_LCDD10,   NULL);
-	gpio_request(GPIO_FN_LCDD9,    NULL);
-	gpio_request(GPIO_FN_LCDD8,    NULL);
-	gpio_request(GPIO_FN_LCDD7,    NULL);
-	gpio_request(GPIO_FN_LCDD6,    NULL);
-	gpio_request(GPIO_FN_LCDD5,    NULL);
-	gpio_request(GPIO_FN_LCDD4,    NULL);
-	gpio_request(GPIO_FN_LCDD3,    NULL);
-	gpio_request(GPIO_FN_LCDD2,    NULL);
-	gpio_request(GPIO_FN_LCDD1,    NULL);
-	gpio_request(GPIO_FN_LCDD0,    NULL);
-	gpio_request(GPIO_FN_LCDDISP,  NULL);
-	gpio_request(GPIO_FN_LCDDCK,   NULL);
-
 	gpio_request_one(189, GPIOF_OUT_INIT_HIGH, NULL); /* backlight */
 	gpio_request_one(151, GPIOF_OUT_INIT_HIGH, NULL); /* LCDDON */
 
-- 
1.8.2.1
