From: festevam@gmail.com (Fabio Estevam)
Date: Mon,  7 Sep 2015 22:57:11 -0300
Subject: [PATCH v2 1/2] ARM: dts: imx7d: Add USB support
Message-ID: <1441677432-3376-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Add USB OTG and Host support.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
Changes since v1:
- Remove underscore from node name as suggested by Shawn

 arch/arm/boot/dts/imx7d.dtsi | 71 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 71 insertions(+)

diff --git a/arch/arm/boot/dts/imx7d.dtsi b/arch/arm/boot/dts/imx7d.dtsi
index 15c2193..90eb9f4 100644
--- a/arch/arm/boot/dts/imx7d.dtsi
+++ b/arch/arm/boot/dts/imx7d.dtsi
@@ -746,6 +746,77 @@
 				status = "disabled";
 			};
 
+			usbotg1: usb at 30b10000 {
+				compatible = "fsl,imx7d-usb", "fsl,imx27-usb";
+				reg = <0x30b10000 0x200>;
+				interrupts = <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clks IMX7D_USB_CTRL_CLK>;
+				fsl,usbphy = <&usbphynop1>;
+				fsl,usbmisc = <&usbmisc1 0>;
+				phy-clkgate-delay-us = <400>;
+				status = "disabled";
+			};
+
+			usbotg2: usb at 30b20000 {
+				compatible = "fsl,imx7d-usb", "fsl,imx27-usb";
+				reg = <0x30b20000 0x200>;
+				interrupts = <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clks IMX7D_USB_CTRL_CLK>;
+				fsl,usbphy = <&usbphynop2>;
+				fsl,usbmisc = <&usbmisc2 0>;
+				phy-clkgate-delay-us = <400>;
+				status = "disabled";
+			};
+
+			usbh: usb at 30b30000 {
+				compatible = "fsl,imx7d-usb", "fsl,imx27-usb";
+				reg = <0x30b30000 0x200>;
+				interrupts = <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clks IMX7D_USB_CTRL_CLK>;
+				fsl,usbphy = <&usbphynop3>;
+				fsl,usbmisc = <&usbmisc3 0>;
+				phy_type = "hsic";
+				dr_mode = "host";
+				phy-clkgate-delay-us = <400>;
+				status = "disabled";
+			};
+
+			usbmisc1: usbmisc at 30b10200 {
+				#index-cells = <1>;
+				compatible = "fsl,imx7d-usbmisc", "fsl,imx6q-usbmisc";
+				reg = <0x30b10200 0x200>;
+			};
+
+			usbmisc2: usbmisc at 30b20200 {
+				#index-cells = <1>;
+				compatible = "fsl,imx7d-usbmisc", "fsl,imx6q-usbmisc";
+				reg = <0x30b20200 0x200>;
+			};
+
+			usbmisc3: usbmisc at 30b30200 {
+				#index-cells = <1>;
+				compatible = "fsl,imx7d-usbmisc", "fsl,imx6q-usbmisc";
+				reg = <0x30b30200 0x200>;
+			};
+
+			usbphynop1: usbphynop1 {
+				compatible = "usb-nop-xceiv";
+				clocks = <&clks IMX7D_USB_PHY1_CLK>;
+				clock-names = "main_clk";
+			};
+
+			usbphynop2: usbphynop2 {
+				compatible = "usb-nop-xceiv";
+				clocks = <&clks IMX7D_USB_PHY2_CLK>;
+				clock-names = "main_clk";
+			};
+
+			usbphynop3: usbphynop3 {
+				compatible = "usb-nop-xceiv";
+				clocks = <&clks IMX7D_USB_HSIC_ROOT_CLK>;
+				clock-names = "main_clk";
+			};
+
 			usdhc1: usdhc at 30b40000 {
 				compatible = "fsl,imx7d-usdhc", "fsl,imx6sl-usdhc";
 				reg = <0x30b40000 0x10000>;
-- 
1.9.1
