From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  5 Jun 2013 17:26:14 +0900
Subject: [PATCH 083/130] sh-pfc: r8a7740: Remove CEU function GPIOS
In-Reply-To: <1370420821-28420-1-git-send-email-horms+renesas@verge.net.au>
References: <1370420821-28420-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1370420821-28420-84-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

All r8a7740 platforms now use the pinctrl API to control the CEU pins,
the corresponding function GPIOS are unused. Remove them.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 drivers/pinctrl/sh-pfc/pfc-r8a7740.c | 28 ----------------------------
 1 file changed, 28 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7740.c b/drivers/pinctrl/sh-pfc/pfc-r8a7740.c
index 58fbe6b..7ab4ff2 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7740.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7740.c
@@ -3232,34 +3232,6 @@ static const struct pinmux_func pinmux_func_gpios[] = {
 	GPIO_FN(RSPI_SSL3_A),	GPIO_FN(RSPI_CK_A),	GPIO_FN(RSPI_MOSI_A),
 	GPIO_FN(RSPI_MISO_A),
 
-	/* VIO CKO */
-	GPIO_FN(VIO_CKO1),
-	GPIO_FN(VIO_CKO2),
-	GPIO_FN(VIO_CKO_1),
-	GPIO_FN(VIO_CKO),
-
-	/* VIO0 */
-	GPIO_FN(VIO0_D0),	GPIO_FN(VIO0_D1),	GPIO_FN(VIO0_D2),
-	GPIO_FN(VIO0_D3),	GPIO_FN(VIO0_D4),	GPIO_FN(VIO0_D5),
-	GPIO_FN(VIO0_D6),	GPIO_FN(VIO0_D7),	GPIO_FN(VIO0_D8),
-	GPIO_FN(VIO0_D9),	GPIO_FN(VIO0_D10),	GPIO_FN(VIO0_D11),
-	GPIO_FN(VIO0_D12),	GPIO_FN(VIO0_VD),	GPIO_FN(VIO0_HD),
-	GPIO_FN(VIO0_CLK),	GPIO_FN(VIO0_FIELD),
-
-	GPIO_FN(VIO0_D13_PORT26), /* MSEL5CR_27_0 */
-	GPIO_FN(VIO0_D14_PORT25),
-	GPIO_FN(VIO0_D15_PORT24),
-
-	GPIO_FN(VIO0_D13_PORT22), /* MSEL5CR_27_1 */
-	GPIO_FN(VIO0_D14_PORT95),
-	GPIO_FN(VIO0_D15_PORT96),
-
-	/* VIO1 */
-	GPIO_FN(VIO1_D0),	GPIO_FN(VIO1_D1),	GPIO_FN(VIO1_D2),
-	GPIO_FN(VIO1_D3),	GPIO_FN(VIO1_D4),	GPIO_FN(VIO1_D5),
-	GPIO_FN(VIO1_D6),	GPIO_FN(VIO1_D7),	GPIO_FN(VIO1_VD),
-	GPIO_FN(VIO1_HD),	GPIO_FN(VIO1_CLK),	GPIO_FN(VIO1_FIELD),
-
 	/* TPU0 */
 	GPIO_FN(TPU0TO0),	GPIO_FN(TPU0TO1),	GPIO_FN(TPU0TO3),
 	GPIO_FN(TPU0TO2_PORT66), /* TPU0TO2 Port 66/202 */
-- 
1.8.2.1
