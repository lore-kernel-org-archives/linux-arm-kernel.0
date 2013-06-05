From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  5 Jun 2013 17:25:59 +0900
Subject: [PATCH 068/130] ARM: shmobile: armadillo800eva: Register pinctrl
 mapping for GETHER
In-Reply-To: <1370420821-28420-1-git-send-email-horms+renesas@verge.net.au>
References: <1370420821-28420-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1370420821-28420-69-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Replace the GPIO-based GETHER pinmux configuration by a pinctrl mapping.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-armadillo800eva.c | 25 +++++--------------------
 1 file changed, 5 insertions(+), 20 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-armadillo800eva.c b/arch/arm/mach-shmobile/board-armadillo800eva.c
index 8d8b362..328f650 100644
--- a/arch/arm/mach-shmobile/board-armadillo800eva.c
+++ b/arch/arm/mach-shmobile/board-armadillo800eva.c
@@ -1046,6 +1046,11 @@ static struct platform_device *eva_devices[] __initdata = {
 };
 
 static const struct pinctrl_map eva_pinctrl_map[] = {
+	/* GETHER */
+	PIN_MAP_MUX_GROUP_DEFAULT("sh-eth", "pfc-r8a7740",
+				  "gether_mii", "gether"),
+	PIN_MAP_MUX_GROUP_DEFAULT("sh-eth", "pfc-r8a7740",
+				  "gether_int", "gether"),
 	/* LCD0 */
 	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_lcdc_fb.0", "pfc-r8a7740",
 				  "lcd0_data24_0", "lcd0"),
@@ -1139,26 +1144,6 @@ static void __init eva_init(void)
 	gpio_request_one(166, GPIOF_OUT_INIT_HIGH, NULL); /* TP_RST_B */
 
 	/* GETHER */
-	gpio_request(GPIO_FN_ET_CRS,		NULL);
-	gpio_request(GPIO_FN_ET_MDC,		NULL);
-	gpio_request(GPIO_FN_ET_MDIO,		NULL);
-	gpio_request(GPIO_FN_ET_TX_ER,		NULL);
-	gpio_request(GPIO_FN_ET_RX_ER,		NULL);
-	gpio_request(GPIO_FN_ET_ERXD0,		NULL);
-	gpio_request(GPIO_FN_ET_ERXD1,		NULL);
-	gpio_request(GPIO_FN_ET_ERXD2,		NULL);
-	gpio_request(GPIO_FN_ET_ERXD3,		NULL);
-	gpio_request(GPIO_FN_ET_TX_CLK,		NULL);
-	gpio_request(GPIO_FN_ET_TX_EN,		NULL);
-	gpio_request(GPIO_FN_ET_ETXD0,		NULL);
-	gpio_request(GPIO_FN_ET_ETXD1,		NULL);
-	gpio_request(GPIO_FN_ET_ETXD2,		NULL);
-	gpio_request(GPIO_FN_ET_ETXD3,		NULL);
-	gpio_request(GPIO_FN_ET_PHY_INT,	NULL);
-	gpio_request(GPIO_FN_ET_COL,		NULL);
-	gpio_request(GPIO_FN_ET_RX_DV,		NULL);
-	gpio_request(GPIO_FN_ET_RX_CLK,		NULL);
-
 	gpio_request_one(18, GPIOF_OUT_INIT_HIGH, NULL); /* PHY_RST */
 
 	/* USB */
-- 
1.8.2.1
