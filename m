From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  3 Apr 2013 11:04:56 +0900
Subject: [PATCH 18/28] sh-pfc: r8a73a4: GPIO IRQ support
In-Reply-To: <1364954706-14727-1-git-send-email-horms+renesas@verge.net.au>
References: <1364954706-14727-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1364954706-14727-19-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

V2 of code to add GPIO -> IRQ mappings to the
PFC table for the r8a73a4 SoC. Requires the IRQs
to be mapped at a fixed location in Linux IRQ
space. The actual IRQs are not handled by the
PFC, instead IRQC is used on r8a73a4.

Signed-off-by: Magnus Damm <damm@opensource.se>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 drivers/pinctrl/sh-pfc/pfc-r8a73a4.c |   63 ++++++++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a73a4.c b/drivers/pinctrl/sh-pfc/pfc-r8a73a4.c
index 5dd68fb9..0177329 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a73a4.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a73a4.c
@@ -2818,6 +2818,66 @@ static const struct pinmux_data_reg pinmux_data_regs[] = {
 	{ },
 };
 
+static const struct pinmux_irq pinmux_irqs[] = {
+	PINMUX_IRQ(irq_pin(0), 0),
+	PINMUX_IRQ(irq_pin(1), 1),
+	PINMUX_IRQ(irq_pin(2), 2),
+	PINMUX_IRQ(irq_pin(3), 3),
+	PINMUX_IRQ(irq_pin(4), 4),
+	PINMUX_IRQ(irq_pin(5), 5),
+	PINMUX_IRQ(irq_pin(6), 6),
+	PINMUX_IRQ(irq_pin(7), 7),
+	PINMUX_IRQ(irq_pin(8), 8),
+	PINMUX_IRQ(irq_pin(9), 9),
+	PINMUX_IRQ(irq_pin(10), 10),
+	PINMUX_IRQ(irq_pin(11), 11),
+	PINMUX_IRQ(irq_pin(12), 12),
+	PINMUX_IRQ(irq_pin(13), 13),
+	PINMUX_IRQ(irq_pin(14), 14),
+	PINMUX_IRQ(irq_pin(15), 15),
+	PINMUX_IRQ(irq_pin(16), 320),
+	PINMUX_IRQ(irq_pin(17), 321),
+	PINMUX_IRQ(irq_pin(18), 85),
+	PINMUX_IRQ(irq_pin(19), 84),
+	PINMUX_IRQ(irq_pin(20), 160),
+	PINMUX_IRQ(irq_pin(21), 161),
+	PINMUX_IRQ(irq_pin(22), 162),
+	PINMUX_IRQ(irq_pin(23), 163),
+	PINMUX_IRQ(irq_pin(24), 175),
+	PINMUX_IRQ(irq_pin(25), 176),
+	PINMUX_IRQ(irq_pin(26), 177),
+	PINMUX_IRQ(irq_pin(27), 178),
+	PINMUX_IRQ(irq_pin(28), 322),
+	PINMUX_IRQ(irq_pin(29), 323),
+	PINMUX_IRQ(irq_pin(30), 324),
+	PINMUX_IRQ(irq_pin(31), 192),
+	PINMUX_IRQ(irq_pin(32), 193),
+	PINMUX_IRQ(irq_pin(33), 194),
+	PINMUX_IRQ(irq_pin(34), 195),
+	PINMUX_IRQ(irq_pin(35), 196),
+	PINMUX_IRQ(irq_pin(36), 197),
+	PINMUX_IRQ(irq_pin(37), 198),
+	PINMUX_IRQ(irq_pin(38), 199),
+	PINMUX_IRQ(irq_pin(39), 200),
+	PINMUX_IRQ(irq_pin(40), 66),
+	PINMUX_IRQ(irq_pin(41), 102),
+	PINMUX_IRQ(irq_pin(42), 103),
+	PINMUX_IRQ(irq_pin(43), 109),
+	PINMUX_IRQ(irq_pin(44), 110),
+	PINMUX_IRQ(irq_pin(45), 111),
+	PINMUX_IRQ(irq_pin(46), 112),
+	PINMUX_IRQ(irq_pin(47), 113),
+	PINMUX_IRQ(irq_pin(48), 114),
+	PINMUX_IRQ(irq_pin(49), 115),
+	PINMUX_IRQ(irq_pin(50), 301),
+	PINMUX_IRQ(irq_pin(51), 290),
+	PINMUX_IRQ(irq_pin(52), 296),
+	PINMUX_IRQ(irq_pin(53), 325),
+	PINMUX_IRQ(irq_pin(54), 326),
+	PINMUX_IRQ(irq_pin(55), 327),
+	PINMUX_IRQ(irq_pin(56), 328),
+	PINMUX_IRQ(irq_pin(57), 329),
+};
 const struct sh_pfc_soc_info r8a73a4_pinmux_info = {
 	.name		= "r8a73a4_pfc",
 
@@ -2839,4 +2899,7 @@ const struct sh_pfc_soc_info r8a73a4_pinmux_info = {
 
 	.gpio_data	= pinmux_data,
 	.gpio_data_size	= ARRAY_SIZE(pinmux_data),
+
+	.gpio_irq = pinmux_irqs,
+	.gpio_irq_size = ARRAY_SIZE(pinmux_irqs),
 };
-- 
1.7.10.4
