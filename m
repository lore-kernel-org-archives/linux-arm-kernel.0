From: Anson.Huang@nxp.com (Anson Huang)
Date: Mon, 23 Apr 2018 11:46:58 +0800
Subject: [PATCH 4/5] ARM: dts: imx6sx-sabreauto: add fec support
In-Reply-To: <1524455219-6736-1-git-send-email-Anson.Huang@nxp.com>
References: <1524455219-6736-1-git-send-email-Anson.Huang@nxp.com>
Message-ID: <1524455219-6736-4-git-send-email-Anson.Huang@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add FEC support on i.MX6SX Sabre Auto board.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm/boot/dts/imx6sx-sabreauto.dts | 70 ++++++++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/arch/arm/boot/dts/imx6sx-sabreauto.dts b/arch/arm/boot/dts/imx6sx-sabreauto.dts
index 812f40b..eadd483 100644
--- a/arch/arm/boot/dts/imx6sx-sabreauto.dts
+++ b/arch/arm/boot/dts/imx6sx-sabreauto.dts
@@ -41,6 +41,40 @@
 	clock-frequency = <24576000>;
 };
 
+&fec1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_enet1_1>;
+	phy-mode = "rgmii";
+	phy-handle = <&ethphy1>;
+	pinctrl-assert-gpios = <&max7322 0 GPIO_ACTIVE_HIGH>;
+	fsl,magic-packet;
+	status = "okay";
+
+	mdio {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		ethphy0: ethernet-phy at 0 {
+			compatible = "ethernet-phy-ieee802.3-c22";
+			reg = <0>;
+		};
+
+		ethphy1: ethernet-phy at 1 {
+			compatible = "ethernet-phy-ieee802.3-c22";
+			reg = <1>;
+		};
+	};
+};
+
+&fec2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_enet2_1>;
+	phy-mode = "rgmii";
+	phy-handle = <&ethphy0>;
+	fsl,magic-packet;
+	status = "okay";
+};
+
 &uart1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_uart1>;
@@ -75,6 +109,42 @@
 &iomuxc {
 	imx6x-sabreauto {
 
+		pinctrl_enet1_1: enet1grp-1 {
+			fsl,pins = <
+				MX6SX_PAD_ENET1_MDIO__ENET1_MDIO        0xa0b1
+				MX6SX_PAD_ENET1_MDC__ENET1_MDC          0xa0b1
+				MX6SX_PAD_RGMII1_TXC__ENET1_RGMII_TXC   0xa0b9
+				MX6SX_PAD_RGMII1_TD0__ENET1_TX_DATA_0   0xa0b1
+				MX6SX_PAD_RGMII1_TD1__ENET1_TX_DATA_1   0xa0b1
+				MX6SX_PAD_RGMII1_TD2__ENET1_TX_DATA_2   0xa0b1
+				MX6SX_PAD_RGMII1_TD3__ENET1_TX_DATA_3   0xa0b1
+				MX6SX_PAD_RGMII1_TX_CTL__ENET1_TX_EN    0xa0b1
+				MX6SX_PAD_RGMII1_RXC__ENET1_RX_CLK      0x3081
+				MX6SX_PAD_RGMII1_RD0__ENET1_RX_DATA_0   0x3081
+				MX6SX_PAD_RGMII1_RD1__ENET1_RX_DATA_1   0x3081
+				MX6SX_PAD_RGMII1_RD2__ENET1_RX_DATA_2   0x3081
+				MX6SX_PAD_RGMII1_RD3__ENET1_RX_DATA_3   0x3081
+				MX6SX_PAD_RGMII1_RX_CTL__ENET1_RX_EN    0x3081
+			>;
+		};
+
+		pinctrl_enet2_1: enet2grp-1 {
+			fsl,pins = <
+				MX6SX_PAD_RGMII2_TXC__ENET2_RGMII_TXC   0xa0b9
+				MX6SX_PAD_RGMII2_TD0__ENET2_TX_DATA_0   0xa0b1
+				MX6SX_PAD_RGMII2_TD1__ENET2_TX_DATA_1   0xa0b1
+				MX6SX_PAD_RGMII2_TD2__ENET2_TX_DATA_2   0xa0b1
+				MX6SX_PAD_RGMII2_TD3__ENET2_TX_DATA_3   0xa0b1
+				MX6SX_PAD_RGMII2_TX_CTL__ENET2_TX_EN    0xa0b1
+				MX6SX_PAD_RGMII2_RXC__ENET2_RX_CLK      0x3081
+				MX6SX_PAD_RGMII2_RD0__ENET2_RX_DATA_0   0x3081
+				MX6SX_PAD_RGMII2_RD1__ENET2_RX_DATA_1   0x3081
+				MX6SX_PAD_RGMII2_RD2__ENET2_RX_DATA_2   0x3081
+				MX6SX_PAD_RGMII2_RD3__ENET2_RX_DATA_3   0x3081
+				MX6SX_PAD_RGMII2_RX_CTL__ENET2_RX_EN    0x3081
+			>;
+		};
+
 		pinctrl_i2c2_1: i2c2grp-1 {
 			fsl,pins = <
 				MX6SX_PAD_GPIO1_IO03__I2C2_SDA          0x4001b8b1
-- 
2.7.4
