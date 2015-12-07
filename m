From: ilya@compulab.co.il (Ilya Ledvich)
Date: Mon,  7 Dec 2015 09:14:35 +0200
Subject: [PATCH 4/8] ARM: dts: imx7d: cl-som-imx7: add fec1 support
In-Reply-To: <1449472479-2521-1-git-send-email-ilya@compulab.co.il>
References: <1449472479-2521-1-git-send-email-ilya@compulab.co.il>
Message-ID: <1449472479-2521-5-git-send-email-ilya@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for the 1-st Freescale Ethernet Controller (FEC1).

Signed-off-by: Ilya Ledvich <ilya@compulab.co.il>
Acked-by: Igor Grinberg <grinberg@compulab.co.il>
---
 arch/arm/boot/dts/imx7d-cl-som-imx7.dts | 41 +++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/arch/arm/boot/dts/imx7d-cl-som-imx7.dts b/arch/arm/boot/dts/imx7d-cl-som-imx7.dts
index 44849ab..97e96c6 100644
--- a/arch/arm/boot/dts/imx7d-cl-som-imx7.dts
+++ b/arch/arm/boot/dts/imx7d-cl-som-imx7.dts
@@ -43,6 +43,28 @@
 	arm-supply = <&sw1a_reg>;
 };
 
+&fec1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_enet1>;
+	assigned-clocks = <&clks IMX7D_ENET1_TIME_ROOT_SRC>,
+			  <&clks IMX7D_ENET1_TIME_ROOT_CLK>;
+	assigned-clock-parents = <&clks IMX7D_PLL_ENET_MAIN_100M_CLK>;
+	assigned-clock-rates = <0>, <100000000>;
+	phy-mode = "rgmii";
+	phy-handle = <&ethphy0>;
+	fsl,magic-packet;
+	status = "okay";
+
+	mdio {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		ethphy0: ethernet-phy at 0 {
+			reg = <0>;
+		};
+	};
+};
+
 &i2c2 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_i2c2>;
@@ -167,6 +189,25 @@
 
 &iomuxc {
 	cl-som-imx7 {
+		pinctrl_enet1: enet1grp {
+			fsl,pins = <
+				MX7D_PAD_SD2_CD_B__ENET1_MDIO			0x3
+				MX7D_PAD_SD2_WP__ENET1_MDC			0x3
+				MX7D_PAD_ENET1_RGMII_TXC__ENET1_RGMII_TXC	0x1
+				MX7D_PAD_ENET1_RGMII_TD0__ENET1_RGMII_TD0	0x1
+				MX7D_PAD_ENET1_RGMII_TD1__ENET1_RGMII_TD1	0x1
+				MX7D_PAD_ENET1_RGMII_TD2__ENET1_RGMII_TD2	0x1
+				MX7D_PAD_ENET1_RGMII_TD3__ENET1_RGMII_TD3	0x1
+				MX7D_PAD_ENET1_RGMII_TX_CTL__ENET1_RGMII_TX_CTL	0x1
+				MX7D_PAD_ENET1_RGMII_RXC__ENET1_RGMII_RXC	0x1
+				MX7D_PAD_ENET1_RGMII_RD0__ENET1_RGMII_RD0	0x1
+				MX7D_PAD_ENET1_RGMII_RD1__ENET1_RGMII_RD1	0x1
+				MX7D_PAD_ENET1_RGMII_RD2__ENET1_RGMII_RD2	0x1
+				MX7D_PAD_ENET1_RGMII_RD3__ENET1_RGMII_RD3	0x1
+				MX7D_PAD_ENET1_RGMII_RX_CTL__ENET1_RGMII_RX_CTL	0x1
+			>;
+		};
+
 		pinctrl_i2c2: i2c2grp {
 			fsl,pins = <
 				MX7D_PAD_I2C2_SDA__I2C2_SDA		0x4000007f
-- 
1.9.1
