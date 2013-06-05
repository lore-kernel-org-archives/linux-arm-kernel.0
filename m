From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  5 Jun 2013 17:26:01 +0900
Subject: [PATCH 070/130] ARM: shmobile: armadillo800eva: Register pinctrl
 mapping for FSI
In-Reply-To: <1370420821-28420-1-git-send-email-horms+renesas@verge.net.au>
References: <1370420821-28420-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1370420821-28420-71-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Replace the GPIO-based FSI pinmux configuration by a pinctrl mapping.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-armadillo800eva.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-armadillo800eva.c b/arch/arm/mach-shmobile/board-armadillo800eva.c
index 4327f7e..4e1f8f3 100644
--- a/arch/arm/mach-shmobile/board-armadillo800eva.c
+++ b/arch/arm/mach-shmobile/board-armadillo800eva.c
@@ -1055,6 +1055,18 @@ static const struct pinctrl_map eva_pinctrl_map[] = {
 				  "ceu0_sync", "ceu0"),
 	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_ceu.0", "pfc-r8a7740",
 				  "ceu0_field", "ceu0"),
+	/* FSIA */
+	PIN_MAP_MUX_GROUP_DEFAULT("asoc-simple-card.0", "pfc-r8a7740",
+				  "fsia_sclk_in", "fsia"),
+	PIN_MAP_MUX_GROUP_DEFAULT("asoc-simple-card.0", "pfc-r8a7740",
+				  "fsia_mclk_out", "fsia"),
+	PIN_MAP_MUX_GROUP_DEFAULT("asoc-simple-card.0", "pfc-r8a7740",
+				  "fsia_data_in_1", "fsia"),
+	PIN_MAP_MUX_GROUP_DEFAULT("asoc-simple-card.0", "pfc-r8a7740",
+				  "fsia_data_out_0", "fsia"),
+	/* FSIB */
+	PIN_MAP_MUX_GROUP_DEFAULT("asoc-simple-card.1", "pfc-r8a7740",
+				  "fsib_mclk_in", "fsib"),
 	/* GETHER */
 	PIN_MAP_MUX_GROUP_DEFAULT("sh-eth", "pfc-r8a7740",
 				  "gether_mii", "gether"),
@@ -1181,20 +1193,11 @@ static void __init eva_init(void)
 	gpio_request_one(158, GPIOF_OUT_INIT_LOW, NULL);  /* CAM_PON */
 
 	/* FSI-WM8978 */
-	gpio_request(GPIO_FN_FSIAIBT,		NULL);
-	gpio_request(GPIO_FN_FSIAILR,		NULL);
-	gpio_request(GPIO_FN_FSIAOMC,		NULL);
-	gpio_request(GPIO_FN_FSIAOSLD,		NULL);
-	gpio_request(GPIO_FN_FSIAISLD_PORT5,	NULL);
-
 	gpio_request(7, NULL);
 	gpio_request(8, NULL);
 	gpio_direction_none(GPIO_PORT7CR); /* FSIAOBT needs no direction */
 	gpio_direction_none(GPIO_PORT8CR); /* FSIAOLR needs no direction */
 
-	/* FSI-HDMI */
-	gpio_request(GPIO_FN_FSIBCK,		NULL);
-
 	/* HDMI */
 	gpio_request(GPIO_FN_HDMI_HPD,		NULL);
 	gpio_request(GPIO_FN_HDMI_CEC,		NULL);
-- 
1.8.2.1
