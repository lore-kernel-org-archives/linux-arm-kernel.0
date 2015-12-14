From: ulrich.hecht+renesas@gmail.com (Ulrich Hecht)
Date: Mon, 14 Dec 2015 16:42:36 +0100
Subject: [PATCH 4/6] pinctrl: sh-pfc: r8a7795: Add SATA support
In-Reply-To: <1450107758-2544-1-git-send-email-ulrich.hecht+renesas@gmail.com>
References: <1450107758-2544-1-git-send-email-ulrich.hecht+renesas@gmail.com>
Message-ID: <1450107758-2544-5-git-send-email-ulrich.hecht+renesas@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Takeshi Kihara <takeshi.kihara.df@renesas.com>

This patch adds SATA0 pinmux support to r8a7795 SoC.

Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
[uli: adjusted for new PFC driver]
Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
---
 drivers/pinctrl/sh-pfc/pfc-r8a7795.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7795.c b/drivers/pinctrl/sh-pfc/pfc-r8a7795.c
index 35e0172..d036c92 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7795.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7795.c
@@ -2492,6 +2492,22 @@ static const unsigned int msiof3_rxd_d_mux[] = {
 	MSIOF3_RXD_D_MARK,
 };
 
+/* - SATA --------------------------------------------------------------------*/
+static const unsigned int sata0_devslp_a_pins[] = {
+	/* DEVSLP */
+	RCAR_GP_PIN(6, 16),
+};
+static const unsigned int sata0_devslp_a_mux[] = {
+	SATA_DEVSLP_A_MARK,
+};
+static const unsigned int sata0_devslp_b_pins[] = {
+	/* DEVSLP */
+	RCAR_GP_PIN(4, 6),
+};
+static const unsigned int sata0_devslp_b_mux[] = {
+	SATA_DEVSLP_B_MARK,
+};
+
 /* - SCIF0 ------------------------------------------------------------------ */
 static const unsigned int scif0_data_pins[] = {
 	/* RX, TX */
@@ -3020,6 +3036,8 @@ static const struct sh_pfc_pin_group pinmux_groups[] = {
 	SH_PFC_PIN_GROUP(msiof3_ss1_d),
 	SH_PFC_PIN_GROUP(msiof3_txd_d),
 	SH_PFC_PIN_GROUP(msiof3_rxd_d),
+	SH_PFC_PIN_GROUP(sata0_devslp_a),
+	SH_PFC_PIN_GROUP(sata0_devslp_b),
 	SH_PFC_PIN_GROUP(scif0_data),
 	SH_PFC_PIN_GROUP(scif0_clk),
 	SH_PFC_PIN_GROUP(scif0_ctrl),
@@ -3267,6 +3285,11 @@ static const char * const msiof3_groups[] = {
 	"msiof3_rxd_d",
 };
 
+static const char * const sata0_groups[] = {
+	"sata0_devslp_a",
+	"sata0_devslp_b",
+};
+
 static const char * const scif0_groups[] = {
 	"scif0_data",
 	"scif0_clk",
@@ -3358,6 +3381,7 @@ static const struct sh_pfc_function pinmux_functions[] = {
 	SH_PFC_FUNCTION(msiof1),
 	SH_PFC_FUNCTION(msiof2),
 	SH_PFC_FUNCTION(msiof3),
+	SH_PFC_FUNCTION(sata0),
 	SH_PFC_FUNCTION(scif0),
 	SH_PFC_FUNCTION(scif1),
 	SH_PFC_FUNCTION(scif2),
-- 
2.6.3
