From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 13 Feb 2013 12:26:30 +0900
Subject: [PATCH 12/21] sh-pfc: sh73a0: Remove FSI function GPIOS
In-Reply-To: <1360725999-14514-1-git-send-email-horms+renesas@verge.net.au>
References: <1360725999-14514-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1360725999-14514-13-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

All sh73a0 platforms now use the pinctrl API to control the FSI pins,
the corresponding function GPIOS are unused. Remove them.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 drivers/pinctrl/sh-pfc/pfc-sh73a0.c |   36 -----------------------------------
 1 file changed, 36 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/pfc-sh73a0.c b/drivers/pinctrl/sh-pfc/pfc-sh73a0.c
index 56c135d..b048fa4 100644
--- a/drivers/pinctrl/sh-pfc/pfc-sh73a0.c
+++ b/drivers/pinctrl/sh-pfc/pfc-sh73a0.c
@@ -2473,7 +2473,6 @@ static struct pinmux_func pinmux_func_gpios[] = {
 	GPIO_FN(GPO6), \
 	GPIO_FN(MFG1_OUT2),
 	GPIO_FN(GPO5), \
-	GPIO_FN(FSICOSLDT3), \
 	GPIO_FN(PORT16_VIO_CKOR),
 	GPIO_FN(PORT19_VIO_CKO2),
 	GPIO_FN(GPO0),
@@ -2498,55 +2497,20 @@ static struct pinmux_func pinmux_func_gpios[] = {
 	GPIO_FN(SIM_D), \
 	GPIO_FN(PORT31_IROUT),
 	GPIO_FN(XWUP),
-	GPIO_FN(FSIBOBT), \
-	GPIO_FN(FSIBIBT),
-	GPIO_FN(FSIBOLR), \
-	GPIO_FN(FSIBILR),
-	GPIO_FN(FSIBOSLD),
-	GPIO_FN(FSIBISLD),
 	GPIO_FN(VACK),
 	GPIO_FN(XTAL1L),
-	GPIO_FN(FSICOSLDT2),
-	GPIO_FN(FSICOSLDT1),
-	GPIO_FN(FSICOBT), \
-	GPIO_FN(FSICIBT), \
-	GPIO_FN(FSIDOBT), \
-	GPIO_FN(FSIDIBT),
-	GPIO_FN(FSICOLR), \
-	GPIO_FN(FSICILR), \
-	GPIO_FN(FSIDOLR), \
-	GPIO_FN(FSIDILR),
-	GPIO_FN(FSICOSLD), \
-	GPIO_FN(PORT47_FSICSPDIF),
-	GPIO_FN(FSICISLD), \
-	GPIO_FN(FSIDISLD),
-	GPIO_FN(FSIACK), \
 	GPIO_FN(PORT49_IRDA_OUT), \
 	GPIO_FN(PORT49_IROUT), \
-	GPIO_FN(FSIAOMC),
-	GPIO_FN(FSIAOLR), \
 	GPIO_FN(BBIF2_TSYNC2), \
 	GPIO_FN(TPU2TO2), \
-	GPIO_FN(FSIAILR),
 
-	GPIO_FN(FSIAOBT), \
 	GPIO_FN(BBIF2_TSCK2), \
 	GPIO_FN(TPU2TO3), \
-	GPIO_FN(FSIAIBT),
-	GPIO_FN(FSIAOSLD), \
 	GPIO_FN(BBIF2_TXD2),
-	GPIO_FN(FSIASPDIF), \
 	GPIO_FN(PORT53_IRDA_IN), \
 	GPIO_FN(TPU3TO3), \
-	GPIO_FN(FSIBSPDIF), \
-	GPIO_FN(PORT53_FSICSPDIF),
-	GPIO_FN(FSIBCK), \
 	GPIO_FN(PORT54_IRDA_FIRSEL), \
 	GPIO_FN(TPU3TO2), \
-	GPIO_FN(FSIBOMC), \
-	GPIO_FN(FSICCK), \
-	GPIO_FN(FSICOMC),
-	GPIO_FN(FSIAISLD), \
 	GPIO_FN(TPU0TO0),
 	GPIO_FN(A0), \
 	GPIO_FN(BS_),
-- 
1.7.10.4
