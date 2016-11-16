From: tharvey@gateworks.com (Tim Harvey)
Date: Wed, 16 Nov 2016 08:26:40 -0800
Subject: [PATCH] ARM: dts: imx: add SPI to GW54xx
Message-ID: <1479313600-20588-1-git-send-email-tharvey@gateworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The GW54xx revision E adds SPI via an off-board connector.

Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
 arch/arm/boot/dts/imx6qdl-gw54xx.dtsi | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi b/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi
index b6982959..6eb4fc9 100644
--- a/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi
@@ -149,6 +149,14 @@
 				 <&clks IMX6QDL_CLK_PLL3_USB_OTG>;
 };
 
+&ecspi2 {
+	fsl,spi-num-chipselects = <1>;
+	cs-gpios = <&gpio2 26 GPIO_ACTIVE_HIGH>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_ecspi2>;
+	status = "okay";
+};
+
 &fec {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_enet>;
@@ -511,6 +519,15 @@
 			>;
 		};
 
+		pinctrl_ecspi2: escpi2grp {
+			fsl,pins = <
+				MX6QDL_PAD_EIM_CS0__ECSPI2_SCLK	0x100b1
+				MX6QDL_PAD_EIM_CS1__ECSPI2_MOSI	0x100b1
+				MX6QDL_PAD_EIM_OE__ECSPI2_MISO	0x100b1
+				MX6QDL_PAD_EIM_RW__GPIO2_IO26	0x100b1
+			>;
+		};
+
 		pinctrl_flexcan1: flexcan1grp {
 			fsl,pins = <
 				MX6QDL_PAD_KEY_ROW2__FLEXCAN1_RX	0x1b0b1
-- 
1.9.1
