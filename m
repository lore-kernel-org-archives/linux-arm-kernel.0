From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  5 Jun 2013 17:26:15 +0900
Subject: [PATCH 084/130] sh-pfc: r8a7740: Remove FSI function GPIOS
In-Reply-To: <1370420821-28420-1-git-send-email-horms+renesas@verge.net.au>
References: <1370420821-28420-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1370420821-28420-85-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

All r8a7740 platforms now use the pinctrl API to control the FSI pins,
the corresponding function GPIOS are unused. Remove them.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 drivers/pinctrl/sh-pfc/pfc-r8a7740.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7740.c b/drivers/pinctrl/sh-pfc/pfc-r8a7740.c
index 7ab4ff2..a93fd84 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7740.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7740.c
@@ -3207,18 +3207,6 @@ static const struct pinmux_func pinmux_func_gpios[] = {
 	GPIO_FN(DBGMD10),	GPIO_FN(DBGMD11),	GPIO_FN(DBGMD20),
 	GPIO_FN(DBGMD21),
 
-	/* FSI-A */
-	GPIO_FN(FSIAISLD_PORT0),	/* FSIAISLD Port 0/5 */
-	GPIO_FN(FSIAISLD_PORT5),
-	GPIO_FN(FSIASPDIF_PORT9),	/* FSIASPDIF Port 9/18 */
-	GPIO_FN(FSIASPDIF_PORT18),
-	GPIO_FN(FSIAOSLD1),	GPIO_FN(FSIAOSLD2),	GPIO_FN(FSIAOLR),
-	GPIO_FN(FSIAOBT),	GPIO_FN(FSIAOSLD),	GPIO_FN(FSIAOMC),
-	GPIO_FN(FSIACK),	GPIO_FN(FSIAILR),	GPIO_FN(FSIAIBT),
-
-	/* FSI-B */
-	GPIO_FN(FSIBCK),
-
 	/* FMSI */
 	GPIO_FN(FMSISLD_PORT1), /* FMSISLD Port 1/6 */
 	GPIO_FN(FMSISLD_PORT6),
-- 
1.8.2.1
