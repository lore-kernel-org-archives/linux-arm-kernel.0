From: laurent.pinchart+renesas@ideasonboard.com (Laurent Pinchart)
Date: Wed, 11 Dec 2013 04:26:24 +0100
Subject: [PATCH 04/10] sh-pfc: sh73a0: Sort IRQ entries by IRQ number
In-Reply-To: <1386732390-31724-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1386732390-31724-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Message-ID: <1386732390-31724-5-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This makes catching duplicate entries easier. Merge the two IRQ9 entries
found after sorting.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/pinctrl/sh-pfc/pfc-sh73a0.c | 47 ++++++++++++++++++-------------------
 1 file changed, 23 insertions(+), 24 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/pfc-sh73a0.c b/drivers/pinctrl/sh-pfc/pfc-sh73a0.c
index f47df12..d6c57dd 100644
--- a/drivers/pinctrl/sh-pfc/pfc-sh73a0.c
+++ b/drivers/pinctrl/sh-pfc/pfc-sh73a0.c
@@ -3661,39 +3661,38 @@ static const struct pinmux_data_reg pinmux_data_regs[] = {
 };
 
 static const struct pinmux_irq pinmux_irqs[] = {
-	PINMUX_IRQ(irq_pin(15), 0),
-	PINMUX_IRQ(irq_pin(19), 9),
-	PINMUX_IRQ(irq_pin(1), 10),
 	PINMUX_IRQ(irq_pin(0), 11),
+	PINMUX_IRQ(irq_pin(1), 10),
+	PINMUX_IRQ(irq_pin(2), 149),
+	PINMUX_IRQ(irq_pin(3), 224),
+	PINMUX_IRQ(irq_pin(4), 159),
+	PINMUX_IRQ(irq_pin(5), 227),
+	PINMUX_IRQ(irq_pin(6), 147),
+	PINMUX_IRQ(irq_pin(7), 150),
+	PINMUX_IRQ(irq_pin(8), 223),
+	PINMUX_IRQ(irq_pin(9), 56, 308),
+	PINMUX_IRQ(irq_pin(10), 54),
+	PINMUX_IRQ(irq_pin(11), 238),
+	PINMUX_IRQ(irq_pin(12), 156),
+	PINMUX_IRQ(irq_pin(13), 239),
+	PINMUX_IRQ(irq_pin(14), 251),
+	PINMUX_IRQ(irq_pin(15), 0),
+	PINMUX_IRQ(irq_pin(16), 249),
+	PINMUX_IRQ(irq_pin(17), 234),
 	PINMUX_IRQ(irq_pin(18), 13),
+	PINMUX_IRQ(irq_pin(19), 9),
 	PINMUX_IRQ(irq_pin(20), 14),
 	PINMUX_IRQ(irq_pin(21), 15),
-	PINMUX_IRQ(irq_pin(31), 26),
-	PINMUX_IRQ(irq_pin(30), 27),
-	PINMUX_IRQ(irq_pin(29), 28),
 	PINMUX_IRQ(irq_pin(22), 40),
 	PINMUX_IRQ(irq_pin(23), 53),
-	PINMUX_IRQ(irq_pin(10), 54),
-	PINMUX_IRQ(irq_pin(9), 56),
+	PINMUX_IRQ(irq_pin(24), 118),
+	PINMUX_IRQ(irq_pin(25), 164),
 	PINMUX_IRQ(irq_pin(26), 115),
 	PINMUX_IRQ(irq_pin(27), 116),
 	PINMUX_IRQ(irq_pin(28), 117),
-	PINMUX_IRQ(irq_pin(24), 118),
-	PINMUX_IRQ(irq_pin(6), 147),
-	PINMUX_IRQ(irq_pin(2), 149),
-	PINMUX_IRQ(irq_pin(7), 150),
-	PINMUX_IRQ(irq_pin(12), 156),
-	PINMUX_IRQ(irq_pin(4), 159),
-	PINMUX_IRQ(irq_pin(25), 164),
-	PINMUX_IRQ(irq_pin(8), 223),
-	PINMUX_IRQ(irq_pin(3), 224),
-	PINMUX_IRQ(irq_pin(5), 227),
-	PINMUX_IRQ(irq_pin(17), 234),
-	PINMUX_IRQ(irq_pin(11), 238),
-	PINMUX_IRQ(irq_pin(13), 239),
-	PINMUX_IRQ(irq_pin(16), 249),
-	PINMUX_IRQ(irq_pin(14), 251),
-	PINMUX_IRQ(irq_pin(9), 308),
+	PINMUX_IRQ(irq_pin(29), 28),
+	PINMUX_IRQ(irq_pin(30), 27),
+	PINMUX_IRQ(irq_pin(31), 26),
 };
 
 /* -----------------------------------------------------------------------------
-- 
1.8.3.2
