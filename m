From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 18 Mar 2013 20:06:40 +0900
Subject: [PATCH 104/142] sh-pfc: sh7372: Remove SDHI and MMCIF function GPIOS
In-Reply-To: <1363604838-29359-1-git-send-email-horms+renesas@verge.net.au>
References: <1363604838-29359-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1363604838-29359-105-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

All sh7372 platforms now use the pinctrl API to control the SDHI and
MMCIF pins, the corresponding function GPIOS are unused. Remove them.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/pinctrl/sh-pfc/pfc-sh7372.c |   25 -------------------------
 1 file changed, 25 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/pfc-sh7372.c b/drivers/pinctrl/sh-pfc/pfc-sh7372.c
index cef4d6a..df0ae21 100644
--- a/drivers/pinctrl/sh-pfc/pfc-sh7372.c
+++ b/drivers/pinctrl/sh-pfc/pfc-sh7372.c
@@ -1277,18 +1277,6 @@ static const struct pinmux_func pinmux_func_gpios[] = {
 	GPIO_FN(D11_NAF11),	GPIO_FN(D12_NAF12),	GPIO_FN(D13_NAF13),
 	GPIO_FN(D14_NAF14),	GPIO_FN(D15_NAF15),
 
-	/* MMCIF(1) */
-	GPIO_FN(MMCD0_0),	GPIO_FN(MMCD0_1),	GPIO_FN(MMCD0_2),
-	GPIO_FN(MMCD0_3),	GPIO_FN(MMCD0_4),	GPIO_FN(MMCD0_5),
-	GPIO_FN(MMCD0_6),	GPIO_FN(MMCD0_7),	GPIO_FN(MMCCMD0),
-	GPIO_FN(MMCCLK0),
-
-	/* MMCIF(2) */
-	GPIO_FN(MMCD1_0),	GPIO_FN(MMCD1_1),	GPIO_FN(MMCD1_2),
-	GPIO_FN(MMCD1_3),	GPIO_FN(MMCD1_4),	GPIO_FN(MMCD1_5),
-	GPIO_FN(MMCD1_6),	GPIO_FN(MMCD1_7),	GPIO_FN(MMCCLK1),
-	GPIO_FN(MMCCMD1),
-
 	/* SPU2 */
 	GPIO_FN(VINT_I),
 
@@ -1385,19 +1373,6 @@ static const struct pinmux_func pinmux_func_gpios[] = {
 	/* HDMI */
 	GPIO_FN(HDMI_HPD),	GPIO_FN(HDMI_CEC),
 
-	/* SDHI0 */
-	GPIO_FN(SDHICLK0),	GPIO_FN(SDHICD0),	GPIO_FN(SDHICMD0),
-	GPIO_FN(SDHIWP0),	GPIO_FN(SDHID0_0),	GPIO_FN(SDHID0_1),
-	GPIO_FN(SDHID0_2),	GPIO_FN(SDHID0_3),
-
-	/* SDHI1 */
-	GPIO_FN(SDHICLK1),	GPIO_FN(SDHICMD1),	GPIO_FN(SDHID1_0),
-	GPIO_FN(SDHID1_1),	GPIO_FN(SDHID1_2),	GPIO_FN(SDHID1_3),
-
-	/* SDHI2 */
-	GPIO_FN(SDHICLK2),	GPIO_FN(SDHICMD2),	GPIO_FN(SDHID2_0),
-	GPIO_FN(SDHID2_1),	GPIO_FN(SDHID2_2),	GPIO_FN(SDHID2_3),
-
 	/* SDENC */
 	GPIO_FN(SDENC_CPG),
 	GPIO_FN(SDENC_DV_CLKI),
-- 
1.7.10.4
