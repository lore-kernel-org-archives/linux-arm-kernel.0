From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Fri,  3 Jan 2014 16:34:14 +0100
Subject: [PATCH 1/3] pinctrl: sh-pfc: r8a7791: Add QSPI pin groups
In-Reply-To: <1388763256-25851-1-git-send-email-geert@linux-m68k.org>
References: <1388763256-25851-1-git-send-email-geert@linux-m68k.org>
Message-ID: <1388763256-25851-2-git-send-email-geert@linux-m68k.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@linux-m68k.org>

Signed-off-by: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
Cc: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/pinctrl/sh-pfc/pfc-r8a7791.c |   27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7791.c b/drivers/pinctrl/sh-pfc/pfc-r8a7791.c
index 654bef369ab8..0070243c859e 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7791.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7791.c
@@ -2135,6 +2135,25 @@ static const unsigned int msiof2_tx_pins[] = {
 static const unsigned int msiof2_tx_mux[] = {
 	MSIOF2_TXD_MARK,
 };
+/* - QSPI ------------------------------------------------------------------- */
+static const unsigned int qspi_pins[] = {
+	/* SPCLK, MOSI_IO0, MISO_IO1, IO2, IO3, SSL */
+	RCAR_GP_PIN(1, 4), RCAR_GP_PIN(1, 5), RCAR_GP_PIN(1, 6),
+	RCAR_GP_PIN(1, 7), RCAR_GP_PIN(1, 8), RCAR_GP_PIN(1, 9),
+};
+static const unsigned int qspi_mux[] = {
+	SPCLK_MARK, MOSI_IO0_MARK, MISO_IO1_MARK,
+	IO2_MARK, IO3_MARK, SSL_MARK
+};
+static const unsigned int qspi_b_pins[] = {
+	/* SPCLK, MOSI_IO0, MISO_IO1, IO2, IO3, SSL */
+	RCAR_GP_PIN(6, 0), RCAR_GP_PIN(6, 1), RCAR_GP_PIN(6, 2),
+	RCAR_GP_PIN(6, 3), RCAR_GP_PIN(6, 4), RCAR_GP_PIN(6, 5),
+};
+static const unsigned int qspi_b_mux[] = {
+	SPCLK_B_MARK, MOSI_IO0_B_MARK, MISO_IO1_B_MARK,
+	IO2_B_MARK, IO3_B_MARK, SSL_B_MARK
+};
 /* - SCIF0 ------------------------------------------------------------------ */
 static const unsigned int scif0_data_pins[] = {
 	/* RX, TX */
@@ -2877,6 +2896,8 @@ static const struct sh_pfc_pin_group pinmux_groups[] = {
 	SH_PFC_PIN_GROUP(msiof2_ss2),
 	SH_PFC_PIN_GROUP(msiof2_rx),
 	SH_PFC_PIN_GROUP(msiof2_tx),
+	SH_PFC_PIN_GROUP(qspi),
+	SH_PFC_PIN_GROUP(qspi_b),
 	SH_PFC_PIN_GROUP(scif0_data),
 	SH_PFC_PIN_GROUP(scif0_data_b),
 	SH_PFC_PIN_GROUP(scif0_data_c),
@@ -3074,6 +3095,11 @@ static const char * const msiof2_groups[] = {
 	"msiof2_tx",
 };
 
+static const char * const qspi_groups[] = {
+	"qspi",
+	"qspi_b",
+};
+
 static const char * const scif0_groups[] = {
 	"scif0_data",
 	"scif0_data_b",
@@ -3230,6 +3256,7 @@ static const struct sh_pfc_function pinmux_functions[] = {
 	SH_PFC_FUNCTION(msiof0),
 	SH_PFC_FUNCTION(msiof1),
 	SH_PFC_FUNCTION(msiof2),
+	SH_PFC_FUNCTION(qspi),
 	SH_PFC_FUNCTION(scif0),
 	SH_PFC_FUNCTION(scif1),
 	SH_PFC_FUNCTION(scif2),
-- 
1.7.9.5
