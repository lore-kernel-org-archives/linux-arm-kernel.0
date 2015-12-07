From: ilya@compulab.co.il (Ilya Ledvich)
Date: Mon,  7 Dec 2015 09:14:38 +0200
Subject: [PATCH 7/8] ARM: dts: imx7d: cl-som-imx7: add fec2 support
In-Reply-To: <1449472479-2521-1-git-send-email-ilya@compulab.co.il>
References: <1449472479-2521-1-git-send-email-ilya@compulab.co.il>
Message-ID: <1449472479-2521-8-git-send-email-ilya@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for the 2-nd Freescale Ethernet Controller (FEC2).

Signed-off-by: Ilya Ledvich <ilya@compulab.co.il>
Acked-by: Igor Grinberg <grinberg@compulab.co.il>
---
 arch/arm/boot/dts/imx7d-cl-som-imx7.dts | 34 +++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/arch/arm/boot/dts/imx7d-cl-som-imx7.dts b/arch/arm/boot/dts/imx7d-cl-som-imx7.dts
index 30bbdcd..77b6587 100644
--- a/arch/arm/boot/dts/imx7d-cl-som-imx7.dts
+++ b/arch/arm/boot/dts/imx7d-cl-som-imx7.dts
@@ -62,9 +62,26 @@
 		ethphy0: ethernet-phy at 0 {
 			reg = <0>;
 		};
+
+		ethphy1: ethernet-phy at 1 {
+			reg = <1>;
+		};
 	};
 };
 
+&fec2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_enet2>;
+	assigned-clocks = <&clks IMX7D_ENET2_TIME_ROOT_SRC>,
+			  <&clks IMX7D_ENET2_TIME_ROOT_CLK>;
+	assigned-clock-parents = <&clks IMX7D_PLL_ENET_MAIN_100M_CLK>;
+	assigned-clock-rates = <0>, <100000000>;
+	phy-mode = "rgmii";
+	phy-handle = <&ethphy1>;
+	fsl,magic-packet;
+	status = "okay";
+};
+
 &i2c2 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_i2c2>;
@@ -221,6 +238,23 @@
 			>;
 		};
 
+		pinctrl_enet2: enet2grp {
+			fsl,pins = <
+				MX7D_PAD_EPDC_GDSP__ENET2_RGMII_TXC		0x1
+				MX7D_PAD_EPDC_SDCE2__ENET2_RGMII_TD0		0x1
+				MX7D_PAD_EPDC_SDCE3__ENET2_RGMII_TD1		0x1
+				MX7D_PAD_EPDC_GDCLK__ENET2_RGMII_TD2		0x1
+				MX7D_PAD_EPDC_GDOE__ENET2_RGMII_TD3		0x1
+				MX7D_PAD_EPDC_GDRL__ENET2_RGMII_TX_CTL		0x1
+				MX7D_PAD_EPDC_SDCE1__ENET2_RGMII_RXC		0x1
+				MX7D_PAD_EPDC_SDCLK__ENET2_RGMII_RD0		0x1
+				MX7D_PAD_EPDC_SDLE__ENET2_RGMII_RD1		0x1
+				MX7D_PAD_EPDC_SDOE__ENET2_RGMII_RD2		0x1
+				MX7D_PAD_EPDC_SDSHR__ENET2_RGMII_RD3		0x1
+				MX7D_PAD_EPDC_SDCE0__ENET2_RGMII_RX_CTL		0x1
+			>;
+		};
+
 		pinctrl_i2c2: i2c2grp {
 			fsl,pins = <
 				MX7D_PAD_I2C2_SDA__I2C2_SDA		0x4000007f
-- 
1.9.1
