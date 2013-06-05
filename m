From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  5 Jun 2013 17:26:51 +0900
Subject: [PATCH 120/130] sh-pfc: r8a7778: add HSPI pin groups
In-Reply-To: <1370420821-28420-1-git-send-email-horms+renesas@verge.net.au>
References: <1370420821-28420-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1370420821-28420-121-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Add HSPI CLK/CS/RX/TX pin groups to R8A7778 PFC driver.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 drivers/pinctrl/sh-pfc/pfc-r8a7778.c | 61 ++++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7778.c b/drivers/pinctrl/sh-pfc/pfc-r8a7778.c
index 605f8ae..bf5e3d8 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7778.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7778.c
@@ -1371,6 +1371,43 @@ SCIF_PFC_CLK(hscif1_clk_a,	HSCK1_A);
 SCIF_PFC_PIN(hscif1_clk_b,	RCAR_GP_PIN(4, 2));
 SCIF_PFC_CLK(hscif1_clk_b,	HSCK1_B);
 
+/* - HSPI macro --------------------------------------------------------------*/
+#define HSPI_PFC_PIN(name, args...)		SH_PFC_PINS(name, args)
+#define HSPI_PFC_DAT(name, clk, cs, rx, tx)	SH_PFC_MUX4(name, clk, cs, rx, tx)
+
+/* - HSPI0 -------------------------------------------------------------------*/
+HSPI_PFC_PIN(hspi0_a,	RCAR_GP_PIN(3, 19),	RCAR_GP_PIN(3, 20),
+			RCAR_GP_PIN(3, 21),	RCAR_GP_PIN(3, 22));
+HSPI_PFC_DAT(hspi0_a,	HSPI_CLK0_A,		HSPI_CS0_A,
+			HSPI_RX0_A,		HSPI_TX0);
+
+HSPI_PFC_PIN(hspi0_b,	RCAR_GP_PIN(2, 25),	RCAR_GP_PIN(2, 26),
+			RCAR_GP_PIN(2, 24),	RCAR_GP_PIN(2, 27));
+HSPI_PFC_DAT(hspi0_b,	HSPI_CLK0_B,		HSPI_CS0_B,
+			HSPI_RX0_B,		HSPI_TX0_B);
+
+/* - HSPI1 -------------------------------------------------------------------*/
+HSPI_PFC_PIN(hspi1_a,	RCAR_GP_PIN(3, 26),	RCAR_GP_PIN(3, 27),
+			RCAR_GP_PIN(3, 25),	RCAR_GP_PIN(3, 28));
+HSPI_PFC_DAT(hspi1_a,	HSPI_CLK1_A,		HSPI_CS1_A,
+			HSPI_RX1_A,		HSPI_TX1_A);
+
+HSPI_PFC_PIN(hspi1_b,	RCAR_GP_PIN(0, 27),	RCAR_GP_PIN(0, 26),
+			PIN_NUMBER(20, 1),	PIN_NUMBER(25, 2));
+HSPI_PFC_DAT(hspi1_b,	HSPI_CLK1_B,		HSPI_CS1_B,
+			HSPI_RX1_B,		HSPI_TX1_B);
+
+/* - HSPI2 -------------------------------------------------------------------*/
+HSPI_PFC_PIN(hspi2_a,	RCAR_GP_PIN(2, 29),	RCAR_GP_PIN(3, 8),
+			RCAR_GP_PIN(2, 28),	RCAR_GP_PIN(2, 30));
+HSPI_PFC_DAT(hspi2_a,	HSPI_CLK2_A,		HSPI_CS2_A,
+			HSPI_RX2_A,		HSPI_TX2_A);
+
+HSPI_PFC_PIN(hspi2_b,	RCAR_GP_PIN(4, 21),	RCAR_GP_PIN(4, 22),
+			RCAR_GP_PIN(4, 23),	RCAR_GP_PIN(4, 24));
+HSPI_PFC_DAT(hspi2_b,	HSPI_CLK2_B,		HSPI_CS2_B,
+			HSPI_RX2_B,		HSPI_TX2_B);
+
 /* - I2C macro ------------------------------------------------------------- */
 #define I2C_PFC_PIN(name, args...)	SH_PFC_PINS(name, args)
 #define I2C_PFC_MUX(name, sda, scl)	SH_PFC_MUX2(name, sda, scl)
@@ -1610,6 +1647,12 @@ static const struct sh_pfc_pin_group pinmux_groups[] = {
 	SH_PFC_PIN_GROUP(hscif1_ctrl_b),
 	SH_PFC_PIN_GROUP(hscif1_clk_a),
 	SH_PFC_PIN_GROUP(hscif1_clk_b),
+	SH_PFC_PIN_GROUP(hspi0_a),
+	SH_PFC_PIN_GROUP(hspi0_b),
+	SH_PFC_PIN_GROUP(hspi1_a),
+	SH_PFC_PIN_GROUP(hspi1_b),
+	SH_PFC_PIN_GROUP(hspi2_a),
+	SH_PFC_PIN_GROUP(hspi2_b),
 	SH_PFC_PIN_GROUP(i2c1_a),
 	SH_PFC_PIN_GROUP(i2c1_b),
 	SH_PFC_PIN_GROUP(i2c2_a),
@@ -1710,6 +1753,21 @@ static const char * const hscif1_groups[] = {
 	"hscif1_clk_b",
 };
 
+static const char * const hspi0_groups[] = {
+	"hspi0_a",
+	"hspi0_b",
+};
+
+static const char * const hspi1_groups[] = {
+	"hspi1_a",
+	"hspi1_b",
+};
+
+static const char * const hspi2_groups[] = {
+	"hspi2_a",
+	"hspi2_b",
+};
+
 static const char * const i2c1_groups[] = {
 	"i2c1_a",
 	"i2c1_b",
@@ -1841,6 +1899,9 @@ static const struct sh_pfc_function pinmux_functions[] = {
 	SH_PFC_FUNCTION(ether),
 	SH_PFC_FUNCTION(hscif0),
 	SH_PFC_FUNCTION(hscif1),
+	SH_PFC_FUNCTION(hspi0),
+	SH_PFC_FUNCTION(hspi1),
+	SH_PFC_FUNCTION(hspi2),
 	SH_PFC_FUNCTION(i2c1),
 	SH_PFC_FUNCTION(i2c2),
 	SH_PFC_FUNCTION(i2c3),
-- 
1.8.2.1
