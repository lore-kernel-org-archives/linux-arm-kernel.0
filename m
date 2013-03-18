From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 18 Mar 2013 20:06:27 +0900
Subject: [PATCH 091/142] ARM: shmobile: kzm9g: Register pinctrl mappings for
 SCIF
In-Reply-To: <1363604838-29359-1-git-send-email-horms+renesas@verge.net.au>
References: <1363604838-29359-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1363604838-29359-92-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Replace the GPIO-based SCIF pinmux configuration by pinctrl mappings.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/mach-shmobile/board-kzm9g.c |   11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-kzm9g.c b/arch/arm/mach-shmobile/board-kzm9g.c
index 7cef005..3d2cdc4 100644
--- a/arch/arm/mach-shmobile/board-kzm9g.c
+++ b/arch/arm/mach-shmobile/board-kzm9g.c
@@ -606,6 +606,11 @@ static const struct pinctrl_map kzm_pinctrl_map[] = {
 				  "lcd_data24", "lcd"),
 	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_lcdc_fb.0", "pfc-sh73a0",
 				  "lcd_sync", "lcd"),
+	/* SCIFA4 */
+	PIN_MAP_MUX_GROUP_DEFAULT("sh-sci.4", "pfc-sh73a0",
+				  "scifa4_data", "scifa4"),
+	PIN_MAP_MUX_GROUP_DEFAULT("sh-sci.4", "pfc-sh73a0",
+				  "scifa4_ctrl", "scifa4"),
 };
 
 /*
@@ -673,12 +678,6 @@ static void __init kzm_init(void)
 
 	sh73a0_pinmux_init();
 
-	/* enable SCIFA4 */
-	gpio_request(GPIO_FN_SCIFA4_TXD, NULL);
-	gpio_request(GPIO_FN_SCIFA4_RXD, NULL);
-	gpio_request(GPIO_FN_SCIFA4_RTS_, NULL);
-	gpio_request(GPIO_FN_SCIFA4_CTS_, NULL);
-
 	/* CS4 for SMSC/USB */
 	gpio_request(GPIO_FN_CS4_, NULL); /* CS4 */
 
-- 
1.7.10.4
