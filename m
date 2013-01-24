From: g.liakhovetski@gmx.de (Guennadi Liakhovetski)
Date: Thu, 24 Jan 2013 17:07:31 +0100
Subject: [PATCH 1/3] pinctrl: add ethernet pin groups to r8a7740
In-Reply-To: <1359043653-11374-1-git-send-email-g.liakhovetski@gmx.de>
References: <1359043653-11374-1-git-send-email-g.liakhovetski@gmx.de>
Message-ID: <1359043653-11374-2-git-send-email-g.liakhovetski@gmx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

r8a7740 SoCs have an integrated gigabit ethernet MAC. This patch adds two
pin groups: base for 100mbps and additional pins for the gigabit mode.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/pinctrl/sh-pfc/pfc-r8a7740.c |   31 +++++++++++++++++++++++++++++++
 1 files changed, 31 insertions(+), 0 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7740.c b/drivers/pinctrl/sh-pfc/pfc-r8a7740.c
index 4c92af8..d7f69dd 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7740.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7740.c
@@ -2052,6 +2052,29 @@ static const unsigned int mmc0_ctrl_1_mux[] = {
 	MMC1_CMD_PORT104_MARK, MMC1_CLK_PORT103_MARK,
 };
 
+static const unsigned int eth_base_pins[] = {
+	203, 204, 205, 206, 207,
+	183, 184,
+	185, 186, 187, 188,
+	171, 170, 169, 168,
+	161, 163, 164, 174,
+};
+static const unsigned int eth_base_mux[] = {
+	ET_TX_ER_MARK, ET_RX_ER_MARK, ET_CRS_MARK, ET_MDC_MARK, ET_MDIO_MARK,
+	ET_TX_EN_MARK, ET_TX_CLK_MARK,
+	ET_ERXD0_MARK, ET_ERXD1_MARK, ET_ERXD2_MARK, ET_ERXD3_MARK,
+	ET_ETXD0_MARK, ET_ETXD1_MARK, ET_ETXD2_MARK, ET_ETXD3_MARK,
+	ET_RX_DV_MARK, ET_COL_MARK, ET_PHY_INT_MARK, ET_RX_CLK_MARK,
+};
+static const unsigned int eth_gbit_pins[] = {
+	189, 190, 191, 192,
+	167, 166, 173, 172,
+};
+static const unsigned int eth_gbit_mux[] = {
+	ET_ERXD4_MARK, ET_ERXD5_MARK, ET_ERXD6_MARK, ET_ERXD7_MARK,
+	ET_ETXD4_MARK, ET_ETXD5_MARK, ET_ETXD6_MARK, ET_ETXD7_MARK,
+};
+
 static const struct sh_pfc_pin_group pinmux_groups[] = {
 	SH_PFC_PIN_GROUP(lcd0_data8),
 	SH_PFC_PIN_GROUP(lcd0_data9),
@@ -2100,6 +2123,8 @@ static const struct sh_pfc_pin_group pinmux_groups[] = {
 	SH_PFC_PIN_GROUP(mmc0_data4_1),
 	SH_PFC_PIN_GROUP(mmc0_data8_1),
 	SH_PFC_PIN_GROUP(mmc0_ctrl_1),
+	SH_PFC_PIN_GROUP(eth_base),
+	SH_PFC_PIN_GROUP(eth_gbit),
 };
 
 static const char * const lcd0_groups[] = {
@@ -2167,6 +2192,11 @@ static const char * const mmc0_groups[] = {
 	"mmc0_ctrl_1",
 };
 
+static const char * const eth_groups[] = {
+	"eth_base",
+	"eth_gbit",
+};
+
 static const struct sh_pfc_function pinmux_functions[] = {
 	SH_PFC_FUNCTION(lcd0),
 	SH_PFC_FUNCTION(lcd1),
@@ -2174,6 +2204,7 @@ static const struct sh_pfc_function pinmux_functions[] = {
 	SH_PFC_FUNCTION(sdhi1),
 	SH_PFC_FUNCTION(sdhi2),
 	SH_PFC_FUNCTION(mmc0),
+	SH_PFC_FUNCTION(eth),
 };
 
 #define PINMUX_FN_BASE	ARRAY_SIZE(pinmux_pins)
-- 
1.7.2.5
