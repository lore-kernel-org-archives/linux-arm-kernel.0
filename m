From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  3 Apr 2013 11:04:59 +0900
Subject: [PATCH 21/28] sh-pfc: r8a73a4: Add IRQC pin groups and functions
In-Reply-To: <1364954706-14727-1-git-send-email-horms+renesas@verge.net.au>
References: <1364954706-14727-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1364954706-14727-22-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

V2 of PINCTRL support for r8a73a4 IRQC hardware
and in particular the external pins IRQ0 -> IRQ57.

Signed-off-by: Magnus Damm <damm@opensource.se>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 drivers/pinctrl/sh-pfc/pfc-r8a73a4.c |  186 ++++++++++++++++++++++++++++++++++
 1 file changed, 186 insertions(+)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a73a4.c b/drivers/pinctrl/sh-pfc/pfc-r8a73a4.c
index cd5c5fd..8a5288c 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a73a4.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a73a4.c
@@ -1576,6 +1576,72 @@ static const struct pinmux_range pinmux_ranges[] = {
 	{.begin = 320, .end = 329,},
 };
 
+/* - IRQC ------------------------------------------------------------------- */
+#define IRQC_PINS_MUX(pin, irq_mark)				\
+static const unsigned int irqc_irq##irq_mark##_pins[] = {	\
+	pin,							\
+};								\
+static const unsigned int irqc_irq##irq_mark##_mux[] = {	\
+	IRQ##irq_mark##_MARK,					\
+}
+IRQC_PINS_MUX(0, 0);
+IRQC_PINS_MUX(1, 1);
+IRQC_PINS_MUX(2, 2);
+IRQC_PINS_MUX(3, 3);
+IRQC_PINS_MUX(4, 4);
+IRQC_PINS_MUX(5, 5);
+IRQC_PINS_MUX(6, 6);
+IRQC_PINS_MUX(7, 7);
+IRQC_PINS_MUX(8, 8);
+IRQC_PINS_MUX(9, 9);
+IRQC_PINS_MUX(10, 10);
+IRQC_PINS_MUX(11, 11);
+IRQC_PINS_MUX(12, 12);
+IRQC_PINS_MUX(13, 13);
+IRQC_PINS_MUX(14, 14);
+IRQC_PINS_MUX(15, 15);
+IRQC_PINS_MUX(66, 40);
+IRQC_PINS_MUX(84, 19);
+IRQC_PINS_MUX(85, 18);
+IRQC_PINS_MUX(102, 41);
+IRQC_PINS_MUX(103, 42);
+IRQC_PINS_MUX(109, 43);
+IRQC_PINS_MUX(110, 44);
+IRQC_PINS_MUX(111, 45);
+IRQC_PINS_MUX(112, 46);
+IRQC_PINS_MUX(113, 47);
+IRQC_PINS_MUX(114, 48);
+IRQC_PINS_MUX(115, 49);
+IRQC_PINS_MUX(160, 20);
+IRQC_PINS_MUX(161, 21);
+IRQC_PINS_MUX(162, 22);
+IRQC_PINS_MUX(163, 23);
+IRQC_PINS_MUX(175, 24);
+IRQC_PINS_MUX(176, 25);
+IRQC_PINS_MUX(177, 26);
+IRQC_PINS_MUX(178, 27);
+IRQC_PINS_MUX(192, 31);
+IRQC_PINS_MUX(193, 32);
+IRQC_PINS_MUX(194, 33);
+IRQC_PINS_MUX(195, 34);
+IRQC_PINS_MUX(196, 35);
+IRQC_PINS_MUX(197, 36);
+IRQC_PINS_MUX(198, 37);
+IRQC_PINS_MUX(199, 38);
+IRQC_PINS_MUX(200, 39);
+IRQC_PINS_MUX(290, 51);
+IRQC_PINS_MUX(296, 52);
+IRQC_PINS_MUX(301, 50);
+IRQC_PINS_MUX(320, 16);
+IRQC_PINS_MUX(321, 17);
+IRQC_PINS_MUX(322, 28);
+IRQC_PINS_MUX(323, 29);
+IRQC_PINS_MUX(324, 30);
+IRQC_PINS_MUX(325, 53);
+IRQC_PINS_MUX(326, 54);
+IRQC_PINS_MUX(327, 55);
+IRQC_PINS_MUX(328, 56);
+IRQC_PINS_MUX(329, 57);
 /* - SCIFA0 ----------------------------------------------------------------- */
 static const unsigned int scifa0_data_pins[] = {
 	/* SCIFA0_RXD, SCIFA0_TXD */
@@ -1773,6 +1839,64 @@ static const unsigned int scifb3_ctrl_b_mux[] = {
 };
 
 static const struct sh_pfc_pin_group pinmux_groups[] = {
+	SH_PFC_PIN_GROUP(irqc_irq0),
+	SH_PFC_PIN_GROUP(irqc_irq1),
+	SH_PFC_PIN_GROUP(irqc_irq2),
+	SH_PFC_PIN_GROUP(irqc_irq3),
+	SH_PFC_PIN_GROUP(irqc_irq4),
+	SH_PFC_PIN_GROUP(irqc_irq5),
+	SH_PFC_PIN_GROUP(irqc_irq6),
+	SH_PFC_PIN_GROUP(irqc_irq7),
+	SH_PFC_PIN_GROUP(irqc_irq8),
+	SH_PFC_PIN_GROUP(irqc_irq9),
+	SH_PFC_PIN_GROUP(irqc_irq10),
+	SH_PFC_PIN_GROUP(irqc_irq11),
+	SH_PFC_PIN_GROUP(irqc_irq12),
+	SH_PFC_PIN_GROUP(irqc_irq13),
+	SH_PFC_PIN_GROUP(irqc_irq14),
+	SH_PFC_PIN_GROUP(irqc_irq15),
+	SH_PFC_PIN_GROUP(irqc_irq16),
+	SH_PFC_PIN_GROUP(irqc_irq17),
+	SH_PFC_PIN_GROUP(irqc_irq18),
+	SH_PFC_PIN_GROUP(irqc_irq19),
+	SH_PFC_PIN_GROUP(irqc_irq20),
+	SH_PFC_PIN_GROUP(irqc_irq21),
+	SH_PFC_PIN_GROUP(irqc_irq22),
+	SH_PFC_PIN_GROUP(irqc_irq23),
+	SH_PFC_PIN_GROUP(irqc_irq24),
+	SH_PFC_PIN_GROUP(irqc_irq25),
+	SH_PFC_PIN_GROUP(irqc_irq26),
+	SH_PFC_PIN_GROUP(irqc_irq27),
+	SH_PFC_PIN_GROUP(irqc_irq28),
+	SH_PFC_PIN_GROUP(irqc_irq29),
+	SH_PFC_PIN_GROUP(irqc_irq30),
+	SH_PFC_PIN_GROUP(irqc_irq31),
+	SH_PFC_PIN_GROUP(irqc_irq32),
+	SH_PFC_PIN_GROUP(irqc_irq33),
+	SH_PFC_PIN_GROUP(irqc_irq34),
+	SH_PFC_PIN_GROUP(irqc_irq35),
+	SH_PFC_PIN_GROUP(irqc_irq36),
+	SH_PFC_PIN_GROUP(irqc_irq37),
+	SH_PFC_PIN_GROUP(irqc_irq38),
+	SH_PFC_PIN_GROUP(irqc_irq39),
+	SH_PFC_PIN_GROUP(irqc_irq40),
+	SH_PFC_PIN_GROUP(irqc_irq41),
+	SH_PFC_PIN_GROUP(irqc_irq42),
+	SH_PFC_PIN_GROUP(irqc_irq43),
+	SH_PFC_PIN_GROUP(irqc_irq44),
+	SH_PFC_PIN_GROUP(irqc_irq45),
+	SH_PFC_PIN_GROUP(irqc_irq46),
+	SH_PFC_PIN_GROUP(irqc_irq47),
+	SH_PFC_PIN_GROUP(irqc_irq48),
+	SH_PFC_PIN_GROUP(irqc_irq49),
+	SH_PFC_PIN_GROUP(irqc_irq50),
+	SH_PFC_PIN_GROUP(irqc_irq51),
+	SH_PFC_PIN_GROUP(irqc_irq52),
+	SH_PFC_PIN_GROUP(irqc_irq53),
+	SH_PFC_PIN_GROUP(irqc_irq54),
+	SH_PFC_PIN_GROUP(irqc_irq55),
+	SH_PFC_PIN_GROUP(irqc_irq56),
+	SH_PFC_PIN_GROUP(irqc_irq57),
 	SH_PFC_PIN_GROUP(scifa0_data),
 	SH_PFC_PIN_GROUP(scifa0_clk),
 	SH_PFC_PIN_GROUP(scifa0_ctrl),
@@ -1802,6 +1926,67 @@ static const struct sh_pfc_pin_group pinmux_groups[] = {
 	SH_PFC_PIN_GROUP(scifb3_ctrl_b),
 };
 
+static const char * const irqc_groups[] = {
+	"irqc_irq0",
+	"irqc_irq1",
+	"irqc_irq2",
+	"irqc_irq3",
+	"irqc_irq4",
+	"irqc_irq5",
+	"irqc_irq6",
+	"irqc_irq7",
+	"irqc_irq8",
+	"irqc_irq9",
+	"irqc_irq10",
+	"irqc_irq11",
+	"irqc_irq12",
+	"irqc_irq13",
+	"irqc_irq14",
+	"irqc_irq15",
+	"irqc_irq16",
+	"irqc_irq17",
+	"irqc_irq18",
+	"irqc_irq19",
+	"irqc_irq20",
+	"irqc_irq21",
+	"irqc_irq22",
+	"irqc_irq23",
+	"irqc_irq24",
+	"irqc_irq25",
+	"irqc_irq26",
+	"irqc_irq27",
+	"irqc_irq28",
+	"irqc_irq29",
+	"irqc_irq30",
+	"irqc_irq31",
+	"irqc_irq32",
+	"irqc_irq33",
+	"irqc_irq34",
+	"irqc_irq35",
+	"irqc_irq36",
+	"irqc_irq37",
+	"irqc_irq38",
+	"irqc_irq39",
+	"irqc_irq40",
+	"irqc_irq41",
+	"irqc_irq42",
+	"irqc_irq43",
+	"irqc_irq44",
+	"irqc_irq45",
+	"irqc_irq46",
+	"irqc_irq47",
+	"irqc_irq48",
+	"irqc_irq49",
+	"irqc_irq50",
+	"irqc_irq51",
+	"irqc_irq52",
+	"irqc_irq53",
+	"irqc_irq54",
+	"irqc_irq55",
+	"irqc_irq56",
+	"irqc_irq57",
+};
+
 static const char * const scifa0_groups[] = {
 	"scifa0_data",
 	"scifa0_clk",
@@ -1848,6 +2033,7 @@ static const char * const scifb3_groups[] = {
 };
 
 static const struct sh_pfc_function pinmux_functions[] = {
+	SH_PFC_FUNCTION(irqc),
 	SH_PFC_FUNCTION(scifa0),
 	SH_PFC_FUNCTION(scifa1),
 	SH_PFC_FUNCTION(scifb0),
-- 
1.7.10.4
