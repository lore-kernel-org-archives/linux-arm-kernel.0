From: tyler@opensourcefoundries.com (tyler at opensourcefoundries.com)
Date: Tue,  5 Dec 2017 14:27:05 -0800
Subject: [PATCH v1 4/6] ARM: dts: imx7s: add node and supplies for vdd1p2
In-Reply-To: <20171205222707.11302-1-tyler@opensourcefoundries.com>
References: <20171205222707.11302-1-tyler@opensourcefoundries.com>
Message-ID: <20171205222707.11302-5-tyler@opensourcefoundries.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Tyler Baker <tyler@opensourcefoundries.com>

Add the regulator nodes and supplies for vdd1p2. This regulator is
used to power the GPC and USB HSIC PHY.

Signed-off-by: Tyler Baker <tyler@opensourcefoundries.com>
---
 arch/arm/boot/dts/imx7s.dtsi | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx7s.dtsi b/arch/arm/boot/dts/imx7s.dtsi
index 7b85659..151ab34 100644
--- a/arch/arm/boot/dts/imx7s.dtsi
+++ b/arch/arm/boot/dts/imx7s.dtsi
@@ -522,6 +522,20 @@
 					anatop-max-voltage = <1200000>;
 					anatop-enable-bit = <0>;
 				};
+
+				reg_1p2: regulator-vdd1p2 at 220 {
+					compatible = "fsl,anatop-regulator";
+					regulator-name = "vdd1p2";
+					regulator-min-microvolt = <1100000>;
+					regulator-max-microvolt = <1300000>;
+					anatop-reg-offset = <0x220>;
+					anatop-vol-bit-shift = <8>;
+					anatop-vol-bit-width = <5>;
+					anatop-min-bit-val = <8>;
+					anatop-min-voltage = <1100000>;
+					anatop-max-voltage = <1300000>;
+					anatop-enable-bit = <0>;
+				};
 			};
 
 			snvs: snvs at 30370000 {
@@ -578,7 +592,7 @@
 				#interrupt-cells = <3>;
 				interrupt-parent = <&intc>;
 				#power-domain-cells = <1>;
-
+				vcc-supply = <&reg_1p2>;
 				pgc {
 					#address-cells = <1>;
 					#size-cells = <0>;
@@ -961,6 +975,7 @@
 				compatible = "usb-nop-xceiv";
 				clocks = <&clks IMX7D_USB_HSIC_ROOT_CLK>;
 				clock-names = "main_clk";
+				vcc-supply = <&reg_1p2>;
 			};
 
 			usdhc1: usdhc at 30b40000 {
-- 
2.9.3
