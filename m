From: festevam@gmail.com (Fabio Estevam)
Date: Sat,  2 Dec 2017 18:26:04 -0200
Subject: [PATCH 1/2] ARM: dts: imx51-babbage: Pass the USB PHY regulator
Message-ID: <1512246365-3657-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@nxp.com>

The USB PHYs are supplied via MC13892 VUSB regulator rail,
so properly describe this in the device tree.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 arch/arm/boot/dts/imx51-babbage.dts | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/imx51-babbage.dts b/arch/arm/boot/dts/imx51-babbage.dts
index c4aa53c..c432de7 100644
--- a/arch/arm/boot/dts/imx51-babbage.dts
+++ b/arch/arm/boot/dts/imx51-babbage.dts
@@ -165,6 +165,7 @@
 			clocks = <&clks IMX5_CLK_DUMMY>;
 			clock-names = "main_clk";
 			reset-gpios = <&gpio2 5 GPIO_ACTIVE_LOW>;
+			vcc-supply = <&vusb_reg>;
 			#phy-cells = <0>;
 		};
 	};
@@ -241,6 +242,10 @@
 				regulator-max-microvolt = <3150000>;
 			};
 
+			vusb_reg: vusb {
+				regulator-boot-on;
+			};
+
 			vusb2_reg: vusb2 {
 				regulator-min-microvolt = <2400000>;
 				regulator-max-microvolt = <2775000>;
@@ -414,6 +419,10 @@
 	status = "okay";
 };
 
+&usbphy0 {
+	vcc-supply = <&vusb_reg>;
+};
+
 &usbotg {
 	dr_mode = "otg";
 	disable-over-current;
-- 
2.7.4
