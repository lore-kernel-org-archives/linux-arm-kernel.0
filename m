From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  5 Jun 2013 17:26:48 +0900
Subject: [PATCH 117/130] pinctrl: sh-pfc: fix r8a7790 Function Select register
 tables
In-Reply-To: <1370420821-28420-1-git-send-email-horms+renesas@verge.net.au>
References: <1370420821-28420-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1370420821-28420-118-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

Fix several errors in Peripheral Function Select register tables for
r8a7790, which prevent various function pins from being correctly
configured.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 drivers/pinctrl/sh-pfc/pfc-r8a7790.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7790.c b/drivers/pinctrl/sh-pfc/pfc-r8a7790.c
index 5be2999..a2f83ae 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7790.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7790.c
@@ -3175,7 +3175,7 @@ static struct pinmux_cfg_reg pinmux_config_regs[] = {
 		FN_SIM0_D_B, 0, 0, 0, 0, 0, 0, 0, }
 	},
 	{ PINMUX_CFG_REG_VAR("IPSR11", 0xE606004C, 32,
-			     2, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3) {
+			     2, 3, 3, 2, 4, 3, 2, 2, 2, 2, 2, 1, 4) {
 		/* IP11_31_30 [2] */
 		FN_SSI_SCK0129, FN_CAN_CLK_B, FN_MOUT0, 0,
 		/* IP11_29_27 [3] */
@@ -3441,12 +3441,10 @@ static struct pinmux_cfg_reg pinmux_config_regs[] = {
 		FN_SEL_SOF0_0, FN_SEL_SOF0_1, }
 	},
 	{ PINMUX_CFG_REG_VAR("MOD_SEL2", 0xE6060094, 32,
-			     2, 1, 1, 1, 1, 2, 1, 2, 1,
-			     2, 1, 1, 1, 3, 3, 2, 3, 2, 2) {
-		/* RESEVED [2] */
+			     3, 1, 1, 1, 2, 1, 2, 1, 2,
+			     1, 1, 1, 3, 3, 2, 3, 2, 2) {
+		/* RESEVED [3] */
 		0, 0, 0, 0, 0, 0, 0, 0,
-		/* RESEVED [1] */
-		0, 0,
 		/* SEL_TMU1 [1] */
 		FN_SEL_TMU1_0, FN_SEL_TMU1_1,
 		/* SEL_HSCIF1 [1] */
@@ -3462,8 +3460,8 @@ static struct pinmux_cfg_reg pinmux_config_regs[] = {
 		/* SEL_CAN1 [1] */
 		FN_SEL_CAN1_0, FN_SEL_CAN1_1,
 		/* RESEVED [2] */
-		0, 0, 0, 0, 0, 0, 0, 0,
-		/* RESEVED [1] */
+		0, 0, 0, 0,
+		/* RESEVED [1] (actually TX2, RX2 vs. TX2_B, RX2_B of SCIF2) */
 		0, 0,
 		/* SEL_ADI [1] */
 		FN_SEL_ADI_0, FN_SEL_ADI_1,
-- 
1.8.2.1
