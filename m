From: laurent.pinchart+renesas@ideasonboard.com (Laurent Pinchart)
Date: Wed, 24 Jul 2013 15:09:28 +0200
Subject: [PATCH 3/3] sh-pfc: sh73a0: Remove EXT_IRQ16L and EXT_IRQ16H macros
In-Reply-To: <1374671368-4681-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1374671368-4681-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Message-ID: <1374671368-4681-4-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The macros expand to irq_pin() calls and where most probably introduced
from a copy&paste of the sh7372 PFC data. Replace them with irq_pin().

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/pinctrl/sh-pfc/pfc-sh73a0.c | 68 +++++++++++++++++--------------------
 1 file changed, 32 insertions(+), 36 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/pfc-sh73a0.c b/drivers/pinctrl/sh-pfc/pfc-sh73a0.c
index 7956df5..d2e8168 100644
--- a/drivers/pinctrl/sh-pfc/pfc-sh73a0.c
+++ b/drivers/pinctrl/sh-pfc/pfc-sh73a0.c
@@ -3674,43 +3674,39 @@ static const struct pinmux_data_reg pinmux_data_regs[] = {
 	{ },
 };
 
-/* External IRQ pins mapped at IRQPIN_BASE */
-#define EXT_IRQ16L(n) irq_pin(n)
-#define EXT_IRQ16H(n) irq_pin(n)
-
 static const struct pinmux_irq pinmux_irqs[] = {
-	PINMUX_IRQ(EXT_IRQ16H(19), 9),
-	PINMUX_IRQ(EXT_IRQ16L(1), 10),
-	PINMUX_IRQ(EXT_IRQ16L(0), 11),
-	PINMUX_IRQ(EXT_IRQ16H(18), 13),
-	PINMUX_IRQ(EXT_IRQ16H(20), 14),
-	PINMUX_IRQ(EXT_IRQ16H(21), 15),
-	PINMUX_IRQ(EXT_IRQ16H(31), 26),
-	PINMUX_IRQ(EXT_IRQ16H(30), 27),
-	PINMUX_IRQ(EXT_IRQ16H(29), 28),
-	PINMUX_IRQ(EXT_IRQ16H(22), 40),
-	PINMUX_IRQ(EXT_IRQ16H(23), 53),
-	PINMUX_IRQ(EXT_IRQ16L(10), 54),
-	PINMUX_IRQ(EXT_IRQ16L(9), 56),
-	PINMUX_IRQ(EXT_IRQ16H(26), 115),
-	PINMUX_IRQ(EXT_IRQ16H(27), 116),
-	PINMUX_IRQ(EXT_IRQ16H(28), 117),
-	PINMUX_IRQ(EXT_IRQ16H(24), 118),
-	PINMUX_IRQ(EXT_IRQ16L(6), 147),
-	PINMUX_IRQ(EXT_IRQ16L(2), 149),
-	PINMUX_IRQ(EXT_IRQ16L(7), 150),
-	PINMUX_IRQ(EXT_IRQ16L(12), 156),
-	PINMUX_IRQ(EXT_IRQ16L(4), 159),
-	PINMUX_IRQ(EXT_IRQ16H(25), 164),
-	PINMUX_IRQ(EXT_IRQ16L(8), 223),
-	PINMUX_IRQ(EXT_IRQ16L(3), 224),
-	PINMUX_IRQ(EXT_IRQ16L(5), 227),
-	PINMUX_IRQ(EXT_IRQ16H(17), 234),
-	PINMUX_IRQ(EXT_IRQ16L(11), 238),
-	PINMUX_IRQ(EXT_IRQ16L(13), 239),
-	PINMUX_IRQ(EXT_IRQ16H(16), 249),
-	PINMUX_IRQ(EXT_IRQ16L(14), 251),
-	PINMUX_IRQ(EXT_IRQ16L(9), 308),
+	PINMUX_IRQ(irq_pin(19), 9),
+	PINMUX_IRQ(irq_pin(1), 10),
+	PINMUX_IRQ(irq_pin(0), 11),
+	PINMUX_IRQ(irq_pin(18), 13),
+	PINMUX_IRQ(irq_pin(20), 14),
+	PINMUX_IRQ(irq_pin(21), 15),
+	PINMUX_IRQ(irq_pin(31), 26),
+	PINMUX_IRQ(irq_pin(30), 27),
+	PINMUX_IRQ(irq_pin(29), 28),
+	PINMUX_IRQ(irq_pin(22), 40),
+	PINMUX_IRQ(irq_pin(23), 53),
+	PINMUX_IRQ(irq_pin(10), 54),
+	PINMUX_IRQ(irq_pin(9), 56),
+	PINMUX_IRQ(irq_pin(26), 115),
+	PINMUX_IRQ(irq_pin(27), 116),
+	PINMUX_IRQ(irq_pin(28), 117),
+	PINMUX_IRQ(irq_pin(24), 118),
+	PINMUX_IRQ(irq_pin(6), 147),
+	PINMUX_IRQ(irq_pin(2), 149),
+	PINMUX_IRQ(irq_pin(7), 150),
+	PINMUX_IRQ(irq_pin(12), 156),
+	PINMUX_IRQ(irq_pin(4), 159),
+	PINMUX_IRQ(irq_pin(25), 164),
+	PINMUX_IRQ(irq_pin(8), 223),
+	PINMUX_IRQ(irq_pin(3), 224),
+	PINMUX_IRQ(irq_pin(5), 227),
+	PINMUX_IRQ(irq_pin(17), 234),
+	PINMUX_IRQ(irq_pin(11), 238),
+	PINMUX_IRQ(irq_pin(13), 239),
+	PINMUX_IRQ(irq_pin(16), 249),
+	PINMUX_IRQ(irq_pin(14), 251),
+	PINMUX_IRQ(irq_pin(9), 308),
 };
 
 /* -----------------------------------------------------------------------------
-- 
1.8.1.5
