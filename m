From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Sun, 12 Jan 2014 12:00:30 +0100
Subject: [PATCH V2 1/4] pinctrl: sh-pfc: r8a7791: Add QSPI pin groups
In-Reply-To: <1389524433-2823-1-git-send-email-geert@linux-m68k.org>
References: <1389524433-2823-1-git-send-email-geert@linux-m68k.org>
Message-ID: <1389524433-2823-2-git-send-email-geert@linux-m68k.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@linux-m68k.org>

A QSPI function set consists of 3 groups:
  - qspi_ctrl (2 control wires)
  - qspi_data2 (2 data wires, for Single/Dual SPI)
  - qspi_data4 (4 data wires, for Quad SPI)

Signed-off-by: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
Cc: Cc: Linus Walleij <linus.walleij@linaro.org>
---
V2:
  - Split in 2 sets of 3 pin groups

 drivers/pinctrl/sh-pfc/pfc-r8a7791.c |   63 ++++++++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7791.c b/drivers/pinctrl/sh-pfc/pfc-r8a7791.c
index 654bef369ab8..0ac8264440df 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7791.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7791.c
@@ -2135,6 +2135,53 @@ static const unsigned int msiof2_tx_pins[] = {
 static const unsigned int msiof2_tx_mux[] = {
 	MSIOF2_TXD_MARK,
 };
+/* - QSPI ------------------------------------------------------------------- */
+static const unsigned int qspi_ctrl_pins[] = {
+	/* SPCLK, SSL */
+	RCAR_GP_PIN(1, 4), RCAR_GP_PIN(1, 9),
+};
+static const unsigned int qspi_ctrl_mux[] = {
+	SPCLK_MARK, SSL_MARK,
+};
+static const unsigned int qspi_data2_pins[] = {
+	/* MOSI_IO0, MISO_IO1 */
+	RCAR_GP_PIN(1, 5), RCAR_GP_PIN(1, 6),
+};
+static const unsigned int qspi_data2_mux[] = {
+	MOSI_IO0_MARK, MISO_IO1_MARK,
+};
+static const unsigned int qspi_data4_pins[] = {
+	/* MOSI_IO0, MISO_IO1, IO2, IO3 */
+	RCAR_GP_PIN(1, 5), RCAR_GP_PIN(1, 6), RCAR_GP_PIN(1, 7),
+	RCAR_GP_PIN(1, 8),
+};
+static const unsigned int qspi_data4_mux[] = {
+	MOSI_IO0_MARK, MISO_IO1_MARK, IO2_MARK, IO3_MARK,
+};
+
+static const unsigned int qspi_ctrl_b_pins[] = {
+	/* SPCLK, SSL */
+	RCAR_GP_PIN(6, 0), RCAR_GP_PIN(6, 5),
+};
+static const unsigned int qspi_ctrl_b_mux[] = {
+	SPCLK_B_MARK, SSL_B_MARK,
+};
+static const unsigned int qspi_data2_b_pins[] = {
+	/* MOSI_IO0, MISO_IO1 */
+	RCAR_GP_PIN(6, 1), RCAR_GP_PIN(6, 2),
+};
+static const unsigned int qspi_data2_b_mux[] = {
+	MOSI_IO0_B_MARK, MISO_IO1_B_MARK,
+};
+static const unsigned int qspi_data4_b_pins[] = {
+	/* MOSI_IO0, MISO_IO1, IO2, IO3 */
+	RCAR_GP_PIN(6, 1), RCAR_GP_PIN(6, 2), RCAR_GP_PIN(6, 3),
+	RCAR_GP_PIN(6, 4),
+};
+static const unsigned int qspi_data4_b_mux[] = {
+	SPCLK_B_MARK, MOSI_IO0_B_MARK, MISO_IO1_B_MARK,
+	IO2_B_MARK, IO3_B_MARK, SSL_B_MARK,
+};
 /* - SCIF0 ------------------------------------------------------------------ */
 static const unsigned int scif0_data_pins[] = {
 	/* RX, TX */
@@ -2877,6 +2924,12 @@ static const struct sh_pfc_pin_group pinmux_groups[] = {
 	SH_PFC_PIN_GROUP(msiof2_ss2),
 	SH_PFC_PIN_GROUP(msiof2_rx),
 	SH_PFC_PIN_GROUP(msiof2_tx),
+	SH_PFC_PIN_GROUP(qspi_ctrl),
+	SH_PFC_PIN_GROUP(qspi_data2),
+	SH_PFC_PIN_GROUP(qspi_data4),
+	SH_PFC_PIN_GROUP(qspi_ctrl_b),
+	SH_PFC_PIN_GROUP(qspi_data2_b),
+	SH_PFC_PIN_GROUP(qspi_data4_b),
 	SH_PFC_PIN_GROUP(scif0_data),
 	SH_PFC_PIN_GROUP(scif0_data_b),
 	SH_PFC_PIN_GROUP(scif0_data_c),
@@ -3074,6 +3127,15 @@ static const char * const msiof2_groups[] = {
 	"msiof2_tx",
 };
 
+static const char * const qspi_groups[] = {
+	"qspi_ctrl",
+	"qspi_data2",
+	"qspi_data4",
+	"qspi_ctrl_b",
+	"qspi_data2_b",
+	"qspi_data4_b",
+};
+
 static const char * const scif0_groups[] = {
 	"scif0_data",
 	"scif0_data_b",
@@ -3230,6 +3292,7 @@ static const struct sh_pfc_function pinmux_functions[] = {
 	SH_PFC_FUNCTION(msiof0),
 	SH_PFC_FUNCTION(msiof1),
 	SH_PFC_FUNCTION(msiof2),
+	SH_PFC_FUNCTION(qspi),
 	SH_PFC_FUNCTION(scif0),
 	SH_PFC_FUNCTION(scif1),
 	SH_PFC_FUNCTION(scif2),
-- 
1.7.9.5
