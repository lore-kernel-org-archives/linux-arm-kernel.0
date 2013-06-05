From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  5 Jun 2013 17:25:02 +0900
Subject: [PATCH 011/130] sh-pfc: r8a7790: Add INTC pin groups and functions
In-Reply-To: <1370420821-28420-1-git-send-email-horms+renesas@verge.net.au>
References: <1370420821-28420-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1370420821-28420-12-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 drivers/pinctrl/sh-pfc/pfc-r8a7790.c | 40 ++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7790.c b/drivers/pinctrl/sh-pfc/pfc-r8a7790.c
index 3774242..a92b204 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7790.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7790.c
@@ -1855,12 +1855,45 @@ static const unsigned int eth_rmii_mux[] = {
 	ETH_RXD0_MARK, ETH_RXD1_MARK, ETH_RX_ER_MARK, ETH_CRS_DV_MARK,
 	ETH_TXD0_MARK, ETH_TXD1_MARK, ETH_TX_EN_MARK, ETH_REF_CLK_MARK,
 };
+/* - INTC ------------------------------------------------------------------- */
+static const unsigned int intc_irq0_pins[] = {
+	/* IRQ */
+	RCAR_GP_PIN(1, 25),
+};
+static const unsigned int intc_irq0_mux[] = {
+	IRQ0_MARK,
+};
+static const unsigned int intc_irq1_pins[] = {
+	/* IRQ */
+	RCAR_GP_PIN(1, 27),
+};
+static const unsigned int intc_irq1_mux[] = {
+	IRQ1_MARK,
+};
+static const unsigned int intc_irq2_pins[] = {
+	/* IRQ */
+	RCAR_GP_PIN(1, 29),
+};
+static const unsigned int intc_irq2_mux[] = {
+	IRQ2_MARK,
+};
+static const unsigned int intc_irq3_pins[] = {
+	/* IRQ */
+	RCAR_GP_PIN(1, 23),
+};
+static const unsigned int intc_irq3_mux[] = {
+	IRQ3_MARK,
+};
 
 static const struct sh_pfc_pin_group pinmux_groups[] = {
 	SH_PFC_PIN_GROUP(eth_link),
 	SH_PFC_PIN_GROUP(eth_magic),
 	SH_PFC_PIN_GROUP(eth_mdio),
 	SH_PFC_PIN_GROUP(eth_rmii),
+	SH_PFC_PIN_GROUP(intc_irq0),
+	SH_PFC_PIN_GROUP(intc_irq1),
+	SH_PFC_PIN_GROUP(intc_irq2),
+	SH_PFC_PIN_GROUP(intc_irq3),
 };
 
 static const char * const eth_groups[] = {
@@ -1870,8 +1903,15 @@ static const char * const eth_groups[] = {
 	"eth_rmii",
 };
 
+static const char * const intc_groups[] = {
+	"intc_irq0",
+	"intc_irq1",
+	"intc_irq2",
+	"intc_irq3",
+};
 static const struct sh_pfc_function pinmux_functions[] = {
 	SH_PFC_FUNCTION(eth),
+	SH_PFC_FUNCTION(intc),
 };
 
 #define PINMUX_FN_BASE	ARRAY_SIZE(pinmux_pins)
-- 
1.8.2.1
