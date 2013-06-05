From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  5 Jun 2013 17:26:12 +0900
Subject: [PATCH 081/130] sh-pfc: r8a7740: Remove BSC function GPIOS
In-Reply-To: <1370420821-28420-1-git-send-email-horms+renesas@verge.net.au>
References: <1370420821-28420-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1370420821-28420-82-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

All r8a7740 platforms now use the pinctrl API to control the BSC pins,
the corresponding function GPIOS are unused. Remove them.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 drivers/pinctrl/sh-pfc/pfc-r8a7740.c | 26 ++------------------------
 1 file changed, 2 insertions(+), 24 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7740.c b/drivers/pinctrl/sh-pfc/pfc-r8a7740.c
index 0429c7d..c78eda8 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7740.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7740.c
@@ -3377,11 +3377,7 @@ static const struct pinmux_func pinmux_func_gpios[] = {
 	GPIO_FN(BBIF2_TSCK2_PORT89),
 	GPIO_FN(BBIF2_TSYNC2_PORT184),
 
-	/* BSC / FLCTL / PCMCIA */
-	GPIO_FN(CS0),	GPIO_FN(CS2),	GPIO_FN(CS4),
-	GPIO_FN(CS5B),	GPIO_FN(CS6A),
-	GPIO_FN(CS5A_PORT105), /* CS5A PORT 19/105 */
-	GPIO_FN(CS5A_PORT19),
+	/* FLCTL / PCMCIA */
 	GPIO_FN(IOIS16), /* ? */
 
 	GPIO_FN(A0),	GPIO_FN(A1),	GPIO_FN(A2),	GPIO_FN(A3),
@@ -3393,25 +3389,7 @@ static const struct pinmux_func pinmux_func_gpios[] = {
 	GPIO_FN(A22),	GPIO_FN(A23),	GPIO_FN(A24),	GPIO_FN(A25),
 	GPIO_FN(A26),
 
-	GPIO_FN(D0_NAF0),	GPIO_FN(D1_NAF1),	/* share with FLCTL */
-	GPIO_FN(D2_NAF2),	GPIO_FN(D3_NAF3),	/* share with FLCTL */
-	GPIO_FN(D4_NAF4),	GPIO_FN(D5_NAF5),	/* share with FLCTL */
-	GPIO_FN(D6_NAF6),	GPIO_FN(D7_NAF7),	/* share with FLCTL */
-	GPIO_FN(D8_NAF8),	GPIO_FN(D9_NAF9),	/* share with FLCTL */
-	GPIO_FN(D10_NAF10),	GPIO_FN(D11_NAF11),	/* share with FLCTL */
-	GPIO_FN(D12_NAF12),	GPIO_FN(D13_NAF13),	/* share with FLCTL */
-	GPIO_FN(D14_NAF14),	GPIO_FN(D15_NAF15),	/* share with FLCTL */
-	GPIO_FN(D16),	GPIO_FN(D17),	GPIO_FN(D18),	GPIO_FN(D19),
-	GPIO_FN(D20),	GPIO_FN(D21),	GPIO_FN(D22),	GPIO_FN(D23),
-	GPIO_FN(D24),	GPIO_FN(D25),	GPIO_FN(D26),	GPIO_FN(D27),
-	GPIO_FN(D28),	GPIO_FN(D29),	GPIO_FN(D30),	GPIO_FN(D31),
-
-	GPIO_FN(WE0_FWE),	/* share with FLCTL */
-	GPIO_FN(WE1),
-	GPIO_FN(WE2_ICIORD),	/* share with PCMCIA */
-	GPIO_FN(WE3_ICIOWR),	/* share with PCMCIA */
-	GPIO_FN(CKO),	GPIO_FN(BS),	GPIO_FN(RDWR),
-	GPIO_FN(RD_FSC),	/* share with FLCTL */
+	GPIO_FN(CKO),
 	GPIO_FN(WAIT_PORT177), /* WAIT Port 90/177 */
 	GPIO_FN(WAIT_PORT90),
 
-- 
1.8.2.1
