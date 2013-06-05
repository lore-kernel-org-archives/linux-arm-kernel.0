From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  5 Jun 2013 17:25:39 +0900
Subject: [PATCH 048/130] ARM: shmobile: ap4evb: Register pinctrl mapping for
 KEYSC
In-Reply-To: <1370420821-28420-1-git-send-email-horms+renesas@verge.net.au>
References: <1370420821-28420-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1370420821-28420-49-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Replace the GPIO-based KEYSC pinmux configuration by a pinctrl mapping.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-ap4evb.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-ap4evb.c b/arch/arm/mach-shmobile/board-ap4evb.c
index 2dfa235..c7a9efc 100644
--- a/arch/arm/mach-shmobile/board-ap4evb.c
+++ b/arch/arm/mach-shmobile/board-ap4evb.c
@@ -1102,6 +1102,11 @@ static const struct pinctrl_map ap4evb_pinctrl_map[] = {
 	/* HDMI */
 	PIN_MAP_MUX_GROUP_DEFAULT("sh-mobile-hdmi", "pfc-sh7372",
 				  "hdmi", "hdmi"),
+	/* KEYSC */
+	PIN_MAP_MUX_GROUP_DEFAULT("sh_keysc", "pfc-sh7372",
+				  "keysc_in04_0", "keysc"),
+	PIN_MAP_MUX_GROUP_DEFAULT("sh_keysc", "pfc-sh7372",
+				  "keysc_out5", "keysc"),
 	/* MMCIF */
 	PIN_MAP_MUX_GROUP_DEFAULT("sh_mmcif.0", "pfc-sh7372",
 				  "mmc0_data8_0", "mmc0"),
@@ -1219,18 +1224,6 @@ static void __init ap4evb_init(void)
 	 * IRQ28 for Touch Panel, set dip switches S3, S43 as OFF, ON.
 	 */
 
-	/* enable KEYSC */
-	gpio_request(GPIO_FN_KEYOUT0, NULL);
-	gpio_request(GPIO_FN_KEYOUT1, NULL);
-	gpio_request(GPIO_FN_KEYOUT2, NULL);
-	gpio_request(GPIO_FN_KEYOUT3, NULL);
-	gpio_request(GPIO_FN_KEYOUT4, NULL);
-	gpio_request(GPIO_FN_KEYIN0_136, NULL);
-	gpio_request(GPIO_FN_KEYIN1_135, NULL);
-	gpio_request(GPIO_FN_KEYIN2_134, NULL);
-	gpio_request(GPIO_FN_KEYIN3_133, NULL);
-	gpio_request(GPIO_FN_KEYIN4,     NULL);
-
 	/* enable TouchScreen */
 	irq_set_irq_type(IRQ28, IRQ_TYPE_LEVEL_LOW);
 
-- 
1.8.2.1
