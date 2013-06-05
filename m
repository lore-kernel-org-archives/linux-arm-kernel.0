From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  5 Jun 2013 17:26:11 +0900
Subject: [PATCH 080/130] sh-pfc: r8a7740: Remove INTC function GPIOS
In-Reply-To: <1370420821-28420-1-git-send-email-horms+renesas@verge.net.au>
References: <1370420821-28420-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1370420821-28420-81-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

All r8a7740 platforms now use the pinctrl API to control the INTC pins,
the corresponding function GPIOS are unused. Remove them.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 drivers/pinctrl/sh-pfc/pfc-r8a7740.c | 34 ----------------------------------
 1 file changed, 34 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7740.c b/drivers/pinctrl/sh-pfc/pfc-r8a7740.c
index 3b53193..0429c7d 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7740.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7740.c
@@ -3200,40 +3200,6 @@ static const struct sh_pfc_function pinmux_functions[] = {
 #define PINMUX_FN_BASE	ARRAY_SIZE(pinmux_pins)
 
 static const struct pinmux_func pinmux_func_gpios[] = {
-	/* IRQ */
-	GPIO_FN(IRQ0_PORT2),	GPIO_FN(IRQ0_PORT13),
-	GPIO_FN(IRQ1),
-	GPIO_FN(IRQ2_PORT11),	GPIO_FN(IRQ2_PORT12),
-	GPIO_FN(IRQ3_PORT10),	GPIO_FN(IRQ3_PORT14),
-	GPIO_FN(IRQ4_PORT15),	GPIO_FN(IRQ4_PORT172),
-	GPIO_FN(IRQ5_PORT0),	GPIO_FN(IRQ5_PORT1),
-	GPIO_FN(IRQ6_PORT121),	GPIO_FN(IRQ6_PORT173),
-	GPIO_FN(IRQ7_PORT120),	GPIO_FN(IRQ7_PORT209),
-	GPIO_FN(IRQ8),
-	GPIO_FN(IRQ9_PORT118),	GPIO_FN(IRQ9_PORT210),
-	GPIO_FN(IRQ10),
-	GPIO_FN(IRQ11),
-	GPIO_FN(IRQ12_PORT42),	GPIO_FN(IRQ12_PORT97),
-	GPIO_FN(IRQ13_PORT64),	GPIO_FN(IRQ13_PORT98),
-	GPIO_FN(IRQ14_PORT63),	GPIO_FN(IRQ14_PORT99),
-	GPIO_FN(IRQ15_PORT62),	GPIO_FN(IRQ15_PORT100),
-	GPIO_FN(IRQ16_PORT68),	GPIO_FN(IRQ16_PORT211),
-	GPIO_FN(IRQ17),
-	GPIO_FN(IRQ18),
-	GPIO_FN(IRQ19),
-	GPIO_FN(IRQ20),
-	GPIO_FN(IRQ21),
-	GPIO_FN(IRQ22),
-	GPIO_FN(IRQ23),
-	GPIO_FN(IRQ24),
-	GPIO_FN(IRQ25),
-	GPIO_FN(IRQ26_PORT58),	GPIO_FN(IRQ26_PORT81),
-	GPIO_FN(IRQ27_PORT57),	GPIO_FN(IRQ27_PORT168),
-	GPIO_FN(IRQ28_PORT56),	GPIO_FN(IRQ28_PORT169),
-	GPIO_FN(IRQ29_PORT50),	GPIO_FN(IRQ29_PORT170),
-	GPIO_FN(IRQ30_PORT49),	GPIO_FN(IRQ30_PORT171),
-	GPIO_FN(IRQ31_PORT41),	GPIO_FN(IRQ31_PORT167),
-
 	/* Function */
 
 	/* DBGT */
-- 
1.8.2.1
