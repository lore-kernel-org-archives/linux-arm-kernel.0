From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 28 Jun 2012 11:44:57 +0800
Subject: [PATCH 01/11] ARM: dts: mxs: add comments for pinmux-ids
In-Reply-To: <1340855107-4664-1-git-send-email-shawn.guo@linaro.org>
References: <1340855107-4664-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1340855107-4664-2-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add comments for pinmux-ids so that we do not have to keep looking at
Documentation/devicetree/bindings/pinctrl/fsl,mxs-pinctrl.txt to read
all these pinmux-ids.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/boot/dts/imx23.dtsi |   26 +++++++--
 arch/arm/boot/dts/imx28.dtsi |  130 +++++++++++++++++++++++++++++++++--------
 2 files changed, 125 insertions(+), 31 deletions(-)

diff --git a/arch/arm/boot/dts/imx23.dtsi b/arch/arm/boot/dts/imx23.dtsi
index 0af43c0..7274273 100644
--- a/arch/arm/boot/dts/imx23.dtsi
+++ b/arch/arm/boot/dts/imx23.dtsi
@@ -114,7 +114,10 @@
 
 				duart_pins_a: duart at 0 {
 					reg = <0>;
-					fsl,pinmux-ids = <0x11a2 0x11b2>;
+					fsl,pinmux-ids = <
+						0x11a2 /* MX23_PAD_PWM0__DUART_RX */
+						0x11b2 /* MX23_PAD_PWM1__DUART_TX */
+					>;
 					fsl,drive-strength = <0>;
 					fsl,voltage = <1>;
 					fsl,pull-up = <0>;
@@ -122,16 +125,29 @@
 
 				mmc0_8bit_pins_a: mmc0-8bit at 0 {
 					reg = <0>;
-					fsl,pinmux-ids = <0x2020 0x2030 0x2040
-						0x2050 0x0082 0x0092 0x00a2
-						0x00b2 0x2000 0x2010 0x2060>;
+					fsl,pinmux-ids = <
+						0x2020 /* MX23_PAD_SSP1_DATA0__SSP1_DATA0 */
+						0x2030 /* MX23_PAD_SSP1_DATA1__SSP1_DATA1 */
+						0x2040 /* MX23_PAD_SSP1_DATA2__SSP1_DATA2 */
+						0x2050 /* MX23_PAD_SSP1_DATA3__SSP1_DATA3 */
+						0x0082 /* MX23_PAD_GPMI_D08__SSP1_DATA4 */
+						0x0092 /* MX23_PAD_GPMI_D09__SSP1_DATA5 */
+						0x00a2 /* MX23_PAD_GPMI_D10__SSP1_DATA6 */
+						0x00b2 /* MX23_PAD_GPMI_D11__SSP1_DATA7 */
+						0x2000 /* MX23_PAD_SSP1_CMD__SSP1_CMD */
+						0x2010 /* MX23_PAD_SSP1_DETECT__SSP1_DETECT */
+						0x2060 /* MX23_PAD_SSP1_SCK__SSP1_SCK */
+					>;
 					fsl,drive-strength = <1>;
 					fsl,voltage = <1>;
 					fsl,pull-up = <1>;
 				};
 
 				mmc0_pins_fixup: mmc0-pins-fixup {
-					fsl,pinmux-ids = <0x2010 0x2060>;
+					fsl,pinmux-ids = <
+						0x2010 /* MX23_PAD_SSP1_DETECT__SSP1_DETECT */
+						0x2060 /* MX23_PAD_SSP1_SCK__SSP1_SCK */
+					>;
 					fsl,pull-up = <0>;
 				};
 			};
diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
index 65d6a53..42d6078 100644
--- a/arch/arm/boot/dts/imx28.dtsi
+++ b/arch/arm/boot/dts/imx28.dtsi
@@ -166,7 +166,10 @@
 
 				duart_pins_a: duart at 0 {
 					reg = <0>;
-					fsl,pinmux-ids = <0x3102 0x3112>;
+					fsl,pinmux-ids = <
+						0x3102 /* MX28_PAD_PWM0__DUART_RX */
+						0x3112 /* MX28_PAD_PWM1__DUART_TX */
+					>;
 					fsl,drive-strength = <0>;
 					fsl,voltage = <1>;
 					fsl,pull-up = <0>;
@@ -174,7 +177,10 @@
 
 				duart_pins_b: duart at 1 {
 					reg = <1>;
-					fsl,pinmux-ids = <0x3022 0x3032>;
+					fsl,pinmux-ids = <
+						0x3022 /* MX28_PAD_AUART0_CTS__DUART_RX */
+						0x3032 /* MX28_PAD_AUART0_RTS__DUART_TX */
+					>;
 					fsl,drive-strength = <0>;
 					fsl,voltage = <1>;
 					fsl,pull-up = <0>;
@@ -182,24 +188,47 @@
 
 				gpmi_pins_a: gpmi-nand at 0 {
 					reg = <0>;
-					fsl,pinmux-ids = <0x0000 0x0010 0x0020
-						0x0030 0x0040 0x0050 0x0060
-						0x0070 0x0100 0x0110 0x0140
-						0x0150 0x0180 0x0190 0x01a0
-						0x01b0 0x01c0>;
+					fsl,pinmux-ids = <
+						0x0000 /* MX28_PAD_GPMI_D00__GPMI_D0 */
+						0x0010 /* MX28_PAD_GPMI_D01__GPMI_D1 */
+						0x0020 /* MX28_PAD_GPMI_D02__GPMI_D2 */
+						0x0030 /* MX28_PAD_GPMI_D03__GPMI_D3 */
+						0x0040 /* MX28_PAD_GPMI_D04__GPMI_D4 */
+						0x0050 /* MX28_PAD_GPMI_D05__GPMI_D5 */
+						0x0060 /* MX28_PAD_GPMI_D06__GPMI_D6 */
+						0x0070 /* MX28_PAD_GPMI_D07__GPMI_D7 */
+						0x0100 /* MX28_PAD_GPMI_CE0N__GPMI_CE0N */
+						0x0110 /* MX28_PAD_GPMI_CE1N__GPMI_CE1N */
+						0x0140 /* MX28_PAD_GPMI_RDY0__GPMI_READY0 */
+						0x0150 /* MX28_PAD_GPMI_RDY1__GPMI_READY1 */
+						0x0180 /* MX28_PAD_GPMI_RDN__GPMI_RDN */
+						0x0190 /* MX28_PAD_GPMI_WRN__GPMI_WRN */
+						0x01a0 /* MX28_PAD_GPMI_ALE__GPMI_ALE */
+						0x01b0 /* MX28_PAD_GPMI_CLE__GPMI_CLE */
+						0x01c0 /* MX28_PAD_GPMI_RESETN__GPMI_RESETN */
+					>;
 					fsl,drive-strength = <0>;
 					fsl,voltage = <1>;
 					fsl,pull-up = <0>;
 				};
 
 				gpmi_status_cfg: gpmi-status-cfg {
-					fsl,pinmux-ids = <0x0180 0x0190 0x01c0>;
+					fsl,pinmux-ids = <
+						0x0180 /* MX28_PAD_GPMI_RDN__GPMI_RDN */
+						0x0190 /* MX28_PAD_GPMI_WRN__GPMI_WRN */
+						0x01c0 /* MX28_PAD_GPMI_RESETN__GPMI_RESETN */
+					>;
 					fsl,drive-strength = <2>;
 				};
 
 				auart0_pins_a: auart0 at 0 {
 					reg = <0>;
-					fsl,pinmux-ids = <0x3000 0x3010 0x3020 0x3030>;
+					fsl,pinmux-ids = <
+						0x3000 /* MX28_PAD_AUART0_RX__AUART0_RX */
+						0x3010 /* MX28_PAD_AUART0_TX__AUART0_TX */
+						0x3020 /* MX28_PAD_AUART0_CTS__AUART0_CTS */
+						0x3030 /* MX28_PAD_AUART0_RTS__AUART0_RTS */
+					>;
 					fsl,drive-strength = <0>;
 					fsl,voltage = <1>;
 					fsl,pull-up = <0>;
@@ -207,7 +236,12 @@
 
 				auart3_pins_a: auart3 at 0 {
 					reg = <0>;
-					fsl,pinmux-ids = <0x30c0 0x30d0 0x30e0 0x30f0>;
+					fsl,pinmux-ids = <
+						0x30c0 /* MX28_PAD_AUART3_RX__AUART3_RX */
+						0x30d0 /* MX28_PAD_AUART3_TX__AUART3_TX */
+						0x30e0 /* MX28_PAD_AUART3_CTS__AUART3_CTS */
+						0x30f0 /* MX28_PAD_AUART3_RTS__AUART3_RTS */
+					>;
 					fsl,drive-strength = <0>;
 					fsl,voltage = <1>;
 					fsl,pull-up = <0>;
@@ -215,9 +249,17 @@
 
 				mac0_pins_a: mac0 at 0 {
 					reg = <0>;
-					fsl,pinmux-ids = <0x4000 0x4010 0x4020
-						0x4030 0x4040 0x4060 0x4070
-						0x4080 0x4100>;
+					fsl,pinmux-ids = <
+						0x4000 /* MX28_PAD_ENET0_MDC__ENET0_MDC */
+						0x4010 /* MX28_PAD_ENET0_MDIO__ENET0_MDIO */
+						0x4020 /* MX28_PAD_ENET0_RX_EN__ENET0_RX_EN */
+						0x4030 /* MX28_PAD_ENET0_RXD0__ENET0_RXD0 */
+						0x4040 /* MX28_PAD_ENET0_RXD1__ENET0_RXD1 */
+						0x4060 /* MX28_PAD_ENET0_TX_EN__ENET0_TX_EN */
+						0x4070 /* MX28_PAD_ENET0_TXD0__ENET0_TXD0 */
+						0x4080 /* MX28_PAD_ENET0_TXD1__ENET0_TXD1 */
+						0x4100 /* MX28_PAD_ENET_CLK__CLKCTRL_ENET */
+					>;
 					fsl,drive-strength = <1>;
 					fsl,voltage = <1>;
 					fsl,pull-up = <1>;
@@ -225,8 +267,14 @@
 
 				mac1_pins_a: mac1 at 0 {
 					reg = <0>;
-					fsl,pinmux-ids = <0x40f1 0x4091 0x40a1
-						0x40e1 0x40b1 0x40c1>;
+					fsl,pinmux-ids = <
+						0x40f1 /* MX28_PAD_ENET0_CRS__ENET1_RX_EN */
+						0x4091 /* MX28_PAD_ENET0_RXD2__ENET1_RXD0 */
+						0x40a1 /* MX28_PAD_ENET0_RXD3__ENET1_RXD1 */
+						0x40e1 /* MX28_PAD_ENET0_COL__ENET1_TX_EN */
+						0x40b1 /* MX28_PAD_ENET0_TXD2__ENET1_TXD0 */
+						0x40c1 /* MX28_PAD_ENET0_TXD3__ENET1_TXD1 */
+					>;
 					fsl,drive-strength = <1>;
 					fsl,voltage = <1>;
 					fsl,pull-up = <1>;
@@ -234,9 +282,19 @@
 
 				mmc0_8bit_pins_a: mmc0-8bit at 0 {
 					reg = <0>;
-					fsl,pinmux-ids = <0x2000 0x2010 0x2020
-						0x2030 0x2040 0x2050 0x2060
-						0x2070 0x2080 0x2090 0x20a0>;
+					fsl,pinmux-ids = <
+						0x2000 /* MX28_PAD_SSP0_DATA0__SSP0_D0 */
+						0x2010 /* MX28_PAD_SSP0_DATA1__SSP0_D1 */
+						0x2020 /* MX28_PAD_SSP0_DATA2__SSP0_D2 */
+						0x2030 /* MX28_PAD_SSP0_DATA3__SSP0_D3 */
+						0x2040 /* MX28_PAD_SSP0_DATA4__SSP0_D4 */
+						0x2050 /* MX28_PAD_SSP0_DATA5__SSP0_D5 */
+						0x2060 /* MX28_PAD_SSP0_DATA6__SSP0_D6 */
+						0x2070 /* MX28_PAD_SSP0_DATA7__SSP0_D7 */
+						0x2080 /* MX28_PAD_SSP0_CMD__SSP0_CMD */
+						0x2090 /* MX28_PAD_SSP0_DETECT__SSP0_CARD_DETECT */
+						0x20a0 /* MX28_PAD_SSP0_SCK__SSP0_SCK */
+					>;
 					fsl,drive-strength = <1>;
 					fsl,voltage = <1>;
 					fsl,pull-up = <1>;
@@ -244,27 +302,41 @@
 
 				mmc0_4bit_pins_a: mmc0-4bit at 0 {
 					reg = <0>;
-					fsl,pinmux-ids = <0x2000 0x2010 0x2020
-						0x2030 0x2080 0x2090 0x20a0>;
+					fsl,pinmux-ids = <
+						0x2000 /* MX28_PAD_SSP0_DATA0__SSP0_D0 */
+						0x2010 /* MX28_PAD_SSP0_DATA1__SSP0_D1 */
+						0x2020 /* MX28_PAD_SSP0_DATA2__SSP0_D2 */
+						0x2030 /* MX28_PAD_SSP0_DATA3__SSP0_D3 */
+						0x2080 /* MX28_PAD_SSP0_CMD__SSP0_CMD */
+						0x2090 /* MX28_PAD_SSP0_DETECT__SSP0_CARD_DETECT */
+						0x20a0 /* MX28_PAD_SSP0_SCK__SSP0_SCK */
+					>;
 					fsl,drive-strength = <1>;
 					fsl,voltage = <1>;
 					fsl,pull-up = <1>;
 				};
 
 				mmc0_cd_cfg: mmc0-cd-cfg {
-					fsl,pinmux-ids = <0x2090>;
+					fsl,pinmux-ids = <
+						0x2090 /* MX28_PAD_SSP0_DETECT__SSP0_CARD_DETECT */
+					>;
 					fsl,pull-up = <0>;
 				};
 
 				mmc0_sck_cfg: mmc0-sck-cfg {
-					fsl,pinmux-ids = <0x20a0>;
+					fsl,pinmux-ids = <
+						0x20a0 /* MX28_PAD_SSP0_SCK__SSP0_SCK */
+					>;
 					fsl,drive-strength = <2>;
 					fsl,pull-up = <0>;
 				};
 
 				i2c0_pins_a: i2c0 at 0 {
 					reg = <0>;
-					fsl,pinmux-ids = <0x3180 0x3190>;
+					fsl,pinmux-ids = <
+						0x3180 /* MX28_PAD_I2C0_SCL__I2C0_SCL */
+						0x3190 /* MX28_PAD_I2C0_SDA__I2C0_SDA */
+					>;
 					fsl,drive-strength = <1>;
 					fsl,voltage = <1>;
 					fsl,pull-up = <1>;
@@ -272,8 +344,12 @@
 
 				saif0_pins_a: saif0 at 0 {
 					reg = <0>;
-					fsl,pinmux-ids =
-						<0x3140 0x3150 0x3160 0x3170>;
+					fsl,pinmux-ids = <
+						0x3140 /* MX28_PAD_SAIF0_MCLK__SAIF0_MCLK */
+						0x3150 /* MX28_PAD_SAIF0_LRCLK__SAIF0_LRCLK */
+						0x3160 /* MX28_PAD_SAIF0_BITCLK__SAIF0_BITCLK */
+						0x3170 /* MX28_PAD_SAIF0_SDATA0__SAIF0_SDATA0 */
+					>;
 					fsl,drive-strength = <2>;
 					fsl,voltage = <1>;
 					fsl,pull-up = <1>;
@@ -281,7 +357,9 @@
 
 				saif1_pins_a: saif1 at 0 {
 					reg = <0>;
-					fsl,pinmux-ids = <0x31a0>;
+					fsl,pinmux-ids = <
+						0x31a0 /* MX28_PAD_SAIF1_SDATA0__SAIF1_SDATA0 */
+					>;
 					fsl,drive-strength = <2>;
 					fsl,voltage = <1>;
 					fsl,pull-up = <1>;
-- 
1.7.5.4
