From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  5 Jun 2013 17:25:25 +0900
Subject: [PATCH 034/130] ARM: shmobile: mackerel: Register pinctrl mapping for
 CEU
In-Reply-To: <1370420821-28420-1-git-send-email-horms+renesas@verge.net.au>
References: <1370420821-28420-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1370420821-28420-35-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Replace the GPIO-based CEU pinmux configuration by a pinctrl mapping.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-mackerel.c | 24 +++++++++---------------
 1 file changed, 9 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-mackerel.c b/arch/arm/mach-shmobile/board-mackerel.c
index d40d9da..fdd7e3f 100644
--- a/arch/arm/mach-shmobile/board-mackerel.c
+++ b/arch/arm/mach-shmobile/board-mackerel.c
@@ -1312,6 +1312,15 @@ static const struct pinctrl_map mackerel_pinctrl_map[] = {
 	/* ADXL34X */
 	PIN_MAP_MUX_GROUP_DEFAULT("1-0053", "pfc-sh7372",
 				  "intc_irq21", "intc"),
+	/* CEU */
+	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_ceu.0", "pfc-sh7372",
+				  "ceu_data_0_7", "ceu"),
+	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_ceu.0", "pfc-sh7372",
+				  "ceu_clk_0", "ceu"),
+	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_ceu.0", "pfc-sh7372",
+				  "ceu_sync", "ceu"),
+	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_ceu.0", "pfc-sh7372",
+				  "ceu_field", "ceu"),
 	/* SDHI0 */
 	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_sdhi.0", "pfc-sh7372",
 				  "sdhi0_data4", "sdhi0"),
@@ -1497,21 +1506,6 @@ static void __init mackerel_init(void)
 	gpio_request(GPIO_FN_SCIFA2_TXD1, NULL);
 	gpio_request(GPIO_FN_SCIFA2_RXD1, NULL);
 
-	/* CEU */
-	gpio_request(GPIO_FN_VIO_CLK, NULL);
-	gpio_request(GPIO_FN_VIO_VD, NULL);
-	gpio_request(GPIO_FN_VIO_HD, NULL);
-	gpio_request(GPIO_FN_VIO_FIELD, NULL);
-	gpio_request(GPIO_FN_VIO_CKO, NULL);
-	gpio_request(GPIO_FN_VIO_D7, NULL);
-	gpio_request(GPIO_FN_VIO_D6, NULL);
-	gpio_request(GPIO_FN_VIO_D5, NULL);
-	gpio_request(GPIO_FN_VIO_D4, NULL);
-	gpio_request(GPIO_FN_VIO_D3, NULL);
-	gpio_request(GPIO_FN_VIO_D2, NULL);
-	gpio_request(GPIO_FN_VIO_D1, NULL);
-	gpio_request(GPIO_FN_VIO_D0, NULL);
-
 	/* HDMI */
 	gpio_request(GPIO_FN_HDMI_HPD, NULL);
 	gpio_request(GPIO_FN_HDMI_CEC, NULL);
-- 
1.8.2.1
