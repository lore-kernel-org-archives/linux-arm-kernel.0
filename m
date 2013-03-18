From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 18 Mar 2013 20:05:58 +0900
Subject: [PATCH 062/142] sh-pfc: sh73a0: Add KEYSC pin groups and functions
In-Reply-To: <1363604838-29359-1-git-send-email-horms+renesas@verge.net.au>
References: <1363604838-29359-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1363604838-29359-63-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/pinctrl/sh-pfc/pfc-sh73a0.c |  213 +++++++++++++++++++++++++++++++++++
 1 file changed, 213 insertions(+)

diff --git a/drivers/pinctrl/sh-pfc/pfc-sh73a0.c b/drivers/pinctrl/sh-pfc/pfc-sh73a0.c
index ed5cbaf..aad8004 100644
--- a/drivers/pinctrl/sh-pfc/pfc-sh73a0.c
+++ b/drivers/pinctrl/sh-pfc/pfc-sh73a0.c
@@ -1846,6 +1846,12 @@ static const struct pinmux_range pinmux_ranges[] = {
 	{.begin = 288, .end = 309,},
 };
 
+/* Pin numbers for pins without a corresponding GPIO port number are computed
+ * from the row and column numbers with a 1000 offset to avoid collisions with
+ * GPIO port numbers.
+ */
+#define PIN_NUMBER(row, col)		(1000+((row)-1)*34+(col)-1)
+
 /* - FSIA ------------------------------------------------------------------- */
 static const unsigned int fsia_mclk_in_pins[] = {
 	/* CK */
@@ -2069,6 +2075,165 @@ static const unsigned int i2c3_2_pins[] = {
 static const unsigned int i2c3_2_mux[] = {
 	PORT115_I2C_SCL3_MARK, PORT116_I2C_SDA3_MARK,
 };
+/* - KEYSC ------------------------------------------------------------------ */
+static const unsigned int keysc_in5_pins[] = {
+	/* KEYIN[0:4] */
+	66, 67, 68, 69, 70,
+};
+static const unsigned int keysc_in5_mux[] = {
+	KEYIN0_MARK, KEYIN1_MARK, KEYIN2_MARK, KEYIN3_MARK,
+	KEYIN4_MARK,
+};
+static const unsigned int keysc_in6_pins[] = {
+	/* KEYIN[0:5] */
+	66, 67, 68, 69, 70, 71,
+};
+static const unsigned int keysc_in6_mux[] = {
+	KEYIN0_MARK, KEYIN1_MARK, KEYIN2_MARK, KEYIN3_MARK,
+	KEYIN4_MARK, KEYIN5_MARK,
+};
+static const unsigned int keysc_in7_pins[] = {
+	/* KEYIN[0:6] */
+	66, 67, 68, 69, 70, 71, 72,
+};
+static const unsigned int keysc_in7_mux[] = {
+	KEYIN0_MARK, KEYIN1_MARK, KEYIN2_MARK, KEYIN3_MARK,
+	KEYIN4_MARK, KEYIN5_MARK, KEYIN6_MARK,
+};
+static const unsigned int keysc_in8_pins[] = {
+	/* KEYIN[0:7] */
+	66, 67, 68, 69, 70, 71, 72, 73,
+};
+static const unsigned int keysc_in8_mux[] = {
+	KEYIN0_MARK, KEYIN1_MARK, KEYIN2_MARK, KEYIN3_MARK,
+	KEYIN4_MARK, KEYIN5_MARK, KEYIN6_MARK, KEYIN7_MARK,
+};
+static const unsigned int keysc_out04_pins[] = {
+	/* KEYOUT[0:4] */
+	65, 64, 63, 62, 61,
+};
+static const unsigned int keysc_out04_mux[] = {
+	KEYOUT0_MARK, KEYOUT1_MARK, KEYOUT2_MARK, KEYOUT3_MARK, KEYOUT4_MARK,
+};
+static const unsigned int keysc_out5_pins[] = {
+	/* KEYOUT5 */
+	60,
+};
+static const unsigned int keysc_out5_mux[] = {
+	KEYOUT5_MARK,
+};
+static const unsigned int keysc_out6_0_pins[] = {
+	/* KEYOUT6 */
+	59,
+};
+static const unsigned int keysc_out6_0_mux[] = {
+	PORT59_KEYOUT6_MARK,
+};
+static const unsigned int keysc_out6_1_pins[] = {
+	/* KEYOUT6 */
+	131,
+};
+static const unsigned int keysc_out6_1_mux[] = {
+	PORT131_KEYOUT6_MARK,
+};
+static const unsigned int keysc_out6_2_pins[] = {
+	/* KEYOUT6 */
+	143,
+};
+static const unsigned int keysc_out6_2_mux[] = {
+	PORT143_KEYOUT6_MARK,
+};
+static const unsigned int keysc_out7_0_pins[] = {
+	/* KEYOUT7 */
+	58,
+};
+static const unsigned int keysc_out7_0_mux[] = {
+	PORT58_KEYOUT7_MARK,
+};
+static const unsigned int keysc_out7_1_pins[] = {
+	/* KEYOUT7 */
+	132,
+};
+static const unsigned int keysc_out7_1_mux[] = {
+	PORT132_KEYOUT7_MARK,
+};
+static const unsigned int keysc_out7_2_pins[] = {
+	/* KEYOUT7 */
+	144,
+};
+static const unsigned int keysc_out7_2_mux[] = {
+	PORT144_KEYOUT7_MARK,
+};
+static const unsigned int keysc_out8_0_pins[] = {
+	/* KEYOUT8 */
+	PIN_NUMBER(6, 26),
+};
+static const unsigned int keysc_out8_0_mux[] = {
+	KEYOUT8_MARK,
+};
+static const unsigned int keysc_out8_1_pins[] = {
+	/* KEYOUT8 */
+	136,
+};
+static const unsigned int keysc_out8_1_mux[] = {
+	PORT136_KEYOUT8_MARK,
+};
+static const unsigned int keysc_out8_2_pins[] = {
+	/* KEYOUT8 */
+	138,
+};
+static const unsigned int keysc_out8_2_mux[] = {
+	PORT138_KEYOUT8_MARK,
+};
+static const unsigned int keysc_out9_0_pins[] = {
+	/* KEYOUT9 */
+	137,
+};
+static const unsigned int keysc_out9_0_mux[] = {
+	PORT137_KEYOUT9_MARK,
+};
+static const unsigned int keysc_out9_1_pins[] = {
+	/* KEYOUT9 */
+	139,
+};
+static const unsigned int keysc_out9_1_mux[] = {
+	PORT139_KEYOUT9_MARK,
+};
+static const unsigned int keysc_out9_2_pins[] = {
+	/* KEYOUT9 */
+	149,
+};
+static const unsigned int keysc_out9_2_mux[] = {
+	PORT149_KEYOUT9_MARK,
+};
+static const unsigned int keysc_out10_0_pins[] = {
+	/* KEYOUT10 */
+	132,
+};
+static const unsigned int keysc_out10_0_mux[] = {
+	PORT132_KEYOUT10_MARK,
+};
+static const unsigned int keysc_out10_1_pins[] = {
+	/* KEYOUT10 */
+	142,
+};
+static const unsigned int keysc_out10_1_mux[] = {
+	PORT142_KEYOUT10_MARK,
+};
+static const unsigned int keysc_out11_0_pins[] = {
+	/* KEYOUT11 */
+	131,
+};
+static const unsigned int keysc_out11_0_mux[] = {
+	PORT131_KEYOUT11_MARK,
+};
+static const unsigned int keysc_out11_1_pins[] = {
+	/* KEYOUT11 */
+	143,
+};
+static const unsigned int keysc_out11_1_mux[] = {
+	PORT143_KEYOUT11_MARK,
+};
 /* - LCD -------------------------------------------------------------------- */
 static const unsigned int lcd_data8_pins[] = {
 	/* D[0:7] */
@@ -2683,6 +2848,28 @@ static const struct sh_pfc_pin_group pinmux_groups[] = {
 	SH_PFC_PIN_GROUP(i2c3_0),
 	SH_PFC_PIN_GROUP(i2c3_1),
 	SH_PFC_PIN_GROUP(i2c3_2),
+	SH_PFC_PIN_GROUP(keysc_in5),
+	SH_PFC_PIN_GROUP(keysc_in6),
+	SH_PFC_PIN_GROUP(keysc_in7),
+	SH_PFC_PIN_GROUP(keysc_in8),
+	SH_PFC_PIN_GROUP(keysc_out04),
+	SH_PFC_PIN_GROUP(keysc_out5),
+	SH_PFC_PIN_GROUP(keysc_out6_0),
+	SH_PFC_PIN_GROUP(keysc_out6_1),
+	SH_PFC_PIN_GROUP(keysc_out6_2),
+	SH_PFC_PIN_GROUP(keysc_out7_0),
+	SH_PFC_PIN_GROUP(keysc_out7_1),
+	SH_PFC_PIN_GROUP(keysc_out7_2),
+	SH_PFC_PIN_GROUP(keysc_out8_0),
+	SH_PFC_PIN_GROUP(keysc_out8_1),
+	SH_PFC_PIN_GROUP(keysc_out8_2),
+	SH_PFC_PIN_GROUP(keysc_out9_0),
+	SH_PFC_PIN_GROUP(keysc_out9_1),
+	SH_PFC_PIN_GROUP(keysc_out9_2),
+	SH_PFC_PIN_GROUP(keysc_out10_0),
+	SH_PFC_PIN_GROUP(keysc_out10_1),
+	SH_PFC_PIN_GROUP(keysc_out11_0),
+	SH_PFC_PIN_GROUP(keysc_out11_1),
 	SH_PFC_PIN_GROUP(lcd_data8),
 	SH_PFC_PIN_GROUP(lcd_data9),
 	SH_PFC_PIN_GROUP(lcd_data12),
@@ -2806,6 +2993,31 @@ static const char * const i2c3_groups[] = {
 	"i2c3_2",
 };
 
+static const char * const keysc_groups[] = {
+	"keysc_in5",
+	"keysc_in6",
+	"keysc_in7",
+	"keysc_in8",
+	"keysc_out04",
+	"keysc_out5",
+	"keysc_out6_0",
+	"keysc_out6_1",
+	"keysc_out6_2",
+	"keysc_out7_0",
+	"keysc_out7_1",
+	"keysc_out7_2",
+	"keysc_out8_0",
+	"keysc_out8_1",
+	"keysc_out8_2",
+	"keysc_out9_0",
+	"keysc_out9_1",
+	"keysc_out9_2",
+	"keysc_out10_0",
+	"keysc_out10_1",
+	"keysc_out11_0",
+	"keysc_out11_1",
+};
+
 static const char * const lcd_groups[] = {
 	"lcd_data8",
 	"lcd_data9",
@@ -2931,6 +3143,7 @@ static const struct sh_pfc_function pinmux_functions[] = {
 	SH_PFC_FUNCTION(fsid),
 	SH_PFC_FUNCTION(i2c2),
 	SH_PFC_FUNCTION(i2c3),
+	SH_PFC_FUNCTION(keysc),
 	SH_PFC_FUNCTION(lcd),
 	SH_PFC_FUNCTION(lcd2),
 	SH_PFC_FUNCTION(mmc0),
-- 
1.7.10.4
