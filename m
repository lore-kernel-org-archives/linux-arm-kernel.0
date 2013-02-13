From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 13 Feb 2013 11:44:49 +0900
Subject: [PATCH 13/21] sh-pfc: r8a7740: Remove LCD0 and LCD1 function GPIOS
In-Reply-To: <1360723497-23266-1-git-send-email-horms+renesas@verge.net.au>
References: <1360723497-23266-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1360723497-23266-14-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

All r8a7740 platforms now use the pinctrl API to control the LCD0 and
LCD1 pins, the corresponding function GPIOS are unused. Remove them.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 drivers/pinctrl/sh-pfc/pfc-r8a7740.c |   37 ----------------------------------
 1 file changed, 37 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7740.c b/drivers/pinctrl/sh-pfc/pfc-r8a7740.c
index bcd1a91..d0b7165 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7740.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7740.c
@@ -2064,43 +2064,6 @@ static struct pinmux_func pinmux_func_gpios[] = {
 	GPIO_FN(SCIFB_RTS_PORT172),
 	GPIO_FN(SCIFB_CTS_PORT173),
 
-	/* LCD0 */
-	GPIO_FN(LCD0_D0),	GPIO_FN(LCD0_D1),	GPIO_FN(LCD0_D2),
-	GPIO_FN(LCD0_D3),	GPIO_FN(LCD0_D4),	GPIO_FN(LCD0_D5),
-	GPIO_FN(LCD0_D6),	GPIO_FN(LCD0_D7),	GPIO_FN(LCD0_D8),
-	GPIO_FN(LCD0_D9),	GPIO_FN(LCD0_D10),	GPIO_FN(LCD0_D11),
-	GPIO_FN(LCD0_D12),	GPIO_FN(LCD0_D13),	GPIO_FN(LCD0_D14),
-	GPIO_FN(LCD0_D15),	GPIO_FN(LCD0_D16),	GPIO_FN(LCD0_D17),
-	GPIO_FN(LCD0_DON),	GPIO_FN(LCD0_VCPWC),	GPIO_FN(LCD0_VEPWC),
-	GPIO_FN(LCD0_DCK),	GPIO_FN(LCD0_VSYN),
-	GPIO_FN(LCD0_HSYN),	GPIO_FN(LCD0_DISP),
-	GPIO_FN(LCD0_WR),	GPIO_FN(LCD0_RD),
-	GPIO_FN(LCD0_CS),	GPIO_FN(LCD0_RS),
-
-	GPIO_FN(LCD0_D18_PORT163),	GPIO_FN(LCD0_D19_PORT162),
-	GPIO_FN(LCD0_D20_PORT161),	GPIO_FN(LCD0_D21_PORT158),
-	GPIO_FN(LCD0_D22_PORT160),	GPIO_FN(LCD0_D23_PORT159),
-	GPIO_FN(LCD0_LCLK_PORT165),	/* MSEL5CR_6_1 */
-
-	GPIO_FN(LCD0_D18_PORT40),	GPIO_FN(LCD0_D19_PORT4),
-	GPIO_FN(LCD0_D20_PORT3),	GPIO_FN(LCD0_D21_PORT2),
-	GPIO_FN(LCD0_D22_PORT0),	GPIO_FN(LCD0_D23_PORT1),
-	GPIO_FN(LCD0_LCLK_PORT102),	/* MSEL5CR_6_0 */
-
-	/* LCD1 */
-	GPIO_FN(LCD1_D0),	GPIO_FN(LCD1_D1),	GPIO_FN(LCD1_D2),
-	GPIO_FN(LCD1_D3),	GPIO_FN(LCD1_D4),	GPIO_FN(LCD1_D5),
-	GPIO_FN(LCD1_D6),	GPIO_FN(LCD1_D7),	GPIO_FN(LCD1_D8),
-	GPIO_FN(LCD1_D9),	GPIO_FN(LCD1_D10),	GPIO_FN(LCD1_D11),
-	GPIO_FN(LCD1_D12),	GPIO_FN(LCD1_D13),	GPIO_FN(LCD1_D14),
-	GPIO_FN(LCD1_D15),	GPIO_FN(LCD1_D16),	GPIO_FN(LCD1_D17),
-	GPIO_FN(LCD1_D18),	GPIO_FN(LCD1_D19),	GPIO_FN(LCD1_D20),
-	GPIO_FN(LCD1_D21),	GPIO_FN(LCD1_D22),	GPIO_FN(LCD1_D23),
-	GPIO_FN(LCD1_RS),	GPIO_FN(LCD1_RD),	GPIO_FN(LCD1_CS),
-	GPIO_FN(LCD1_WR),	GPIO_FN(LCD1_DCK),	GPIO_FN(LCD1_DON),
-	GPIO_FN(LCD1_VCPWC),	GPIO_FN(LCD1_LCLK),	GPIO_FN(LCD1_HSYN),
-	GPIO_FN(LCD1_VSYN),	GPIO_FN(LCD1_VEPWC),	GPIO_FN(LCD1_DISP),
-
 	/* RSPI */
 	GPIO_FN(RSPI_SSL0_A),	GPIO_FN(RSPI_SSL1_A),	GPIO_FN(RSPI_SSL2_A),
 	GPIO_FN(RSPI_SSL3_A),	GPIO_FN(RSPI_CK_A),	GPIO_FN(RSPI_MOSI_A),
-- 
1.7.10.4
