From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 18 Mar 2013 20:05:55 +0900
Subject: [PATCH 059/142] sh-pfc: sh73a0: Add I2C2 and I2C3 pin groups and
 functions
In-Reply-To: <1363604838-29359-1-git-send-email-horms+renesas@verge.net.au>
References: <1363604838-29359-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1363604838-29359-60-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/pinctrl/sh-pfc/pfc-sh73a0.c |   64 +++++++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/drivers/pinctrl/sh-pfc/pfc-sh73a0.c b/drivers/pinctrl/sh-pfc/pfc-sh73a0.c
index 4b0a349..fad11d7 100644
--- a/drivers/pinctrl/sh-pfc/pfc-sh73a0.c
+++ b/drivers/pinctrl/sh-pfc/pfc-sh73a0.c
@@ -1846,6 +1846,50 @@ static const struct pinmux_range pinmux_ranges[] = {
 	{.begin = 288, .end = 309,},
 };
 
+/* - I2C2 ------------------------------------------------------------------- */
+static const unsigned int i2c2_0_pins[] = {
+	/* SCL, SDA */
+	237, 236,
+};
+static const unsigned int i2c2_0_mux[] = {
+	PORT237_I2C_SCL2_MARK, PORT236_I2C_SDA2_MARK,
+};
+static const unsigned int i2c2_1_pins[] = {
+	/* SCL, SDA */
+	27, 28,
+};
+static const unsigned int i2c2_1_mux[] = {
+	PORT27_I2C_SCL2_MARK, PORT28_I2C_SDA2_MARK,
+};
+static const unsigned int i2c2_2_pins[] = {
+	/* SCL, SDA */
+	115, 116,
+};
+static const unsigned int i2c2_2_mux[] = {
+	PORT115_I2C_SCL2_MARK, PORT116_I2C_SDA2_MARK,
+};
+/* - I2C3 ------------------------------------------------------------------- */
+static const unsigned int i2c3_0_pins[] = {
+	/* SCL, SDA */
+	248, 249,
+};
+static const unsigned int i2c3_0_mux[] = {
+	PORT248_I2C_SCL3_MARK, PORT249_I2C_SDA3_MARK,
+};
+static const unsigned int i2c3_1_pins[] = {
+	/* SCL, SDA */
+	27, 28,
+};
+static const unsigned int i2c3_1_mux[] = {
+	PORT27_I2C_SCL3_MARK, PORT28_I2C_SDA3_MARK,
+};
+static const unsigned int i2c3_2_pins[] = {
+	/* SCL, SDA */
+	115, 116,
+};
+static const unsigned int i2c3_2_mux[] = {
+	PORT115_I2C_SCL3_MARK, PORT116_I2C_SDA3_MARK,
+};
 /* - LCD -------------------------------------------------------------------- */
 static const unsigned int lcd_data8_pins[] = {
 	/* D[0:7] */
@@ -2289,6 +2333,12 @@ static const unsigned int scifb_ctrl_1_mux[] = {
 };
 
 static const struct sh_pfc_pin_group pinmux_groups[] = {
+	SH_PFC_PIN_GROUP(i2c2_0),
+	SH_PFC_PIN_GROUP(i2c2_1),
+	SH_PFC_PIN_GROUP(i2c2_2),
+	SH_PFC_PIN_GROUP(i2c3_0),
+	SH_PFC_PIN_GROUP(i2c3_1),
+	SH_PFC_PIN_GROUP(i2c3_2),
 	SH_PFC_PIN_GROUP(lcd_data8),
 	SH_PFC_PIN_GROUP(lcd_data9),
 	SH_PFC_PIN_GROUP(lcd_data12),
@@ -2345,6 +2395,18 @@ static const struct sh_pfc_pin_group pinmux_groups[] = {
 	SH_PFC_PIN_GROUP(scifb_ctrl_1),
 };
 
+static const char * const i2c2_groups[] = {
+	"i2c2_0",
+	"i2c2_1",
+	"i2c2_2",
+};
+
+static const char * const i2c3_groups[] = {
+	"i2c3_0",
+	"i2c3_1",
+	"i2c3_2",
+};
+
 static const char * const lcd_groups[] = {
 	"lcd_data8",
 	"lcd_data9",
@@ -2433,6 +2495,8 @@ static const char * const scifb_groups[] = {
 };
 
 static const struct sh_pfc_function pinmux_functions[] = {
+	SH_PFC_FUNCTION(i2c2),
+	SH_PFC_FUNCTION(i2c3),
 	SH_PFC_FUNCTION(lcd),
 	SH_PFC_FUNCTION(lcd2),
 	SH_PFC_FUNCTION(scifa0),
-- 
1.7.10.4
