From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 18 Mar 2013 20:06:49 +0900
Subject: [PATCH 113/142] sh-pfc: sh73a0: Remove IrDA function GPIOS
In-Reply-To: <1363604838-29359-1-git-send-email-horms+renesas@verge.net.au>
References: <1363604838-29359-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1363604838-29359-114-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

All sh73a0 platforms now use the pinctrl API to control the IrDA pins,
the corresponding function GPIOS are unused. Remove them.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/pinctrl/sh-pfc/pfc-sh73a0.c |    6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/pfc-sh73a0.c b/drivers/pinctrl/sh-pfc/pfc-sh73a0.c
index 273345c..cde4387 100644
--- a/drivers/pinctrl/sh-pfc/pfc-sh73a0.c
+++ b/drivers/pinctrl/sh-pfc/pfc-sh73a0.c
@@ -2979,7 +2979,6 @@ static const struct pinmux_func pinmux_func_gpios[] = {
 	GPIO_FN(XWUP),
 	GPIO_FN(VACK),
 	GPIO_FN(XTAL1L),
-	GPIO_FN(PORT49_IRDA_OUT), \
 	GPIO_FN(PORT49_IROUT), \
 	GPIO_FN(BBIF2_TSYNC2), \
 	GPIO_FN(TPU2TO2), \
@@ -2987,9 +2986,7 @@ static const struct pinmux_func pinmux_func_gpios[] = {
 	GPIO_FN(BBIF2_TSCK2), \
 	GPIO_FN(TPU2TO3), \
 	GPIO_FN(BBIF2_TXD2),
-	GPIO_FN(PORT53_IRDA_IN), \
 	GPIO_FN(TPU3TO3), \
-	GPIO_FN(PORT54_IRDA_FIRSEL), \
 	GPIO_FN(TPU3TO2), \
 	GPIO_FN(TPU0TO0),
 	GPIO_FN(A0), \
@@ -3188,13 +3185,10 @@ static const struct pinmux_func pinmux_func_gpios[] = {
 	GPIO_FN(VIO2_FIELD2), \
 	GPIO_FN(MSIOF1_SS2), \
 	GPIO_FN(VIO2_HD2), \
-	GPIO_FN(PORT241_IRDA_OUT), \
 	GPIO_FN(PORT241_IROUT), \
 	GPIO_FN(MFG4_OUT1), \
 	GPIO_FN(TPU4TO0),
-	GPIO_FN(PORT242_IRDA_IN), \
 	GPIO_FN(MFG4_IN2),
-	GPIO_FN(PORT243_IRDA_FIRSEL), \
 	GPIO_FN(PORT243_VIO_CKO2),
 	GPIO_FN(MFG2_IN1), \
 	GPIO_FN(MSIOF2R_RXD),
-- 
1.7.10.4
