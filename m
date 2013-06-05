From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  5 Jun 2013 17:25:41 +0900
Subject: [PATCH 050/130] ARM: shmobile: ap4evb: Register pinctrl mapping for
 SCIF
In-Reply-To: <1370420821-28420-1-git-send-email-horms+renesas@verge.net.au>
References: <1370420821-28420-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1370420821-28420-51-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Replace the GPIO-based SCIF pinmux configuration by a pinctrl mapping.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-ap4evb.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-ap4evb.c b/arch/arm/mach-shmobile/board-ap4evb.c
index c6e1e44..3163983 100644
--- a/arch/arm/mach-shmobile/board-ap4evb.c
+++ b/arch/arm/mach-shmobile/board-ap4evb.c
@@ -1119,6 +1119,9 @@ static const struct pinctrl_map ap4evb_pinctrl_map[] = {
 				  "mmc0_data8_0", "mmc0"),
 	PIN_MAP_MUX_GROUP_DEFAULT("sh_mmcif.0", "pfc-sh7372",
 				  "mmc0_ctrl_0", "mmc0"),
+	/* SCIFA0 */
+	PIN_MAP_MUX_GROUP_DEFAULT("sh-sci.0", "pfc-sh7372",
+				  "scifa0_data", "scifa0"),
 	/* SDHI0 */
 	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_sdhi.0", "pfc-sh7372",
 				  "sdhi0_data4", "sdhi0"),
@@ -1165,10 +1168,6 @@ static void __init ap4evb_init(void)
 				  ARRAY_SIZE(ap4evb_pinctrl_map));
 	sh7372_pinmux_init();
 
-	/* enable SCIFA0 */
-	gpio_request(GPIO_FN_SCIFA0_TXD, NULL);
-	gpio_request(GPIO_FN_SCIFA0_RXD, NULL);
-
 	/* enable SMSC911X */
 	gpio_request(GPIO_FN_CS5A,	NULL);
 	gpio_request(GPIO_FN_IRQ6_39,	NULL);
-- 
1.8.2.1
