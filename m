From: Anson.Huang@nxp.com (Anson Huang)
Date: Fri, 20 Jul 2018 18:06:57 +0800
Subject: [PATCH] ARM: dts: imx6sll: add gpio-ranges property
Message-ID: <1532081217-17538-1-git-send-email-Anson.Huang@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add "gpio-ranges" property to establish connections between GPIOs
and PINs on i.MX6SLL pinctrl driver, for details, please refer to
Documentation/devicetree/bindings/gpio/gpio.txt of "gpio-ranges"
property.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm/boot/dts/imx6sll.dtsi | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm/boot/dts/imx6sll.dtsi b/arch/arm/boot/dts/imx6sll.dtsi
index 000e613..a3cf282 100644
--- a/arch/arm/boot/dts/imx6sll.dtsi
+++ b/arch/arm/boot/dts/imx6sll.dtsi
@@ -379,6 +379,7 @@
 				#gpio-cells = <2>;
 				interrupt-controller;
 				#interrupt-cells = <2>;
+				gpio-ranges = <&iomuxc 0 94 7>, <&iomuxc 7 25 25>;
 			};
 
 			gpio2: gpio at 20a0000 {
@@ -390,6 +391,7 @@
 				#gpio-cells = <2>;
 				interrupt-controller;
 				#interrupt-cells = <2>;
+				gpio-ranges = <&iomuxc 0 50 32>;
 			};
 
 			gpio3: gpio at 20a4000 {
@@ -401,6 +403,9 @@
 				#gpio-cells = <2>;
 				interrupt-controller;
 				#interrupt-cells = <2>;
+				gpio-ranges = <&iomuxc 0 82 12>, <&iomuxc 12 103 4>,
+					      <&iomuxc 16 101 2>, <&iomuxc 18 5 1>,
+					      <&iomuxc 21 6 11>;
 			};
 
 			gpio4: gpio at 20a8000 {
@@ -412,6 +417,15 @@
 				#gpio-cells = <2>;
 				interrupt-controller;
 				#interrupt-cells = <2>;
+				gpio-ranges = <&iomuxc 0 17 8>, <&iomuxc 8 107 8>,
+					      <&iomuxc 16 151 1>, <&iomuxc 17 149 1>,
+					      <&iomuxc 18 146 1>, <&iomuxc 19 144 1>,
+					      <&iomuxc 20 142 1>, <&iomuxc 21 143 1>,
+					      <&iomuxc 22 150 1>, <&iomuxc 23 148 1>,
+					      <&iomuxc 24 147 1>, <&iomuxc 25 145 1>,
+					      <&iomuxc 26 152 1>, <&iomuxc 27 125 1>,
+					      <&iomuxc 28 131 1>, <&iomuxc 29 134 1>,
+					      <&iomuxc 30 129 1>, <&iomuxc 31 133 1>;
 			};
 
 			gpio5: gpio at 20ac000 {
@@ -423,6 +437,17 @@
 				#gpio-cells = <2>;
 				interrupt-controller;
 				#interrupt-cells = <2>;
+				gpio-ranges = <&iomuxc 0 135 1>, <&iomuxc 1 128 1>,
+					      <&iomuxc 2 132 1>, <&iomuxc 3 130 1>,
+					      <&iomuxc 4 127 1>, <&iomuxc 5 126 1>,
+					      <&iomuxc 6 120 1>, <&iomuxc 7 123 1>,
+					      <&iomuxc 8 118 1>, <&iomuxc 9 122 1>,
+					      <&iomuxc 10 124 1>, <&iomuxc 11 117 1>,
+					      <&iomuxc 12 121 1>, <&iomuxc 13 119 1>,
+					      <&iomuxc 14 116 1>, <&iomuxc 15 115 1>,
+					      <&iomuxc 16 140 2>, <&iomuxc 18 136 1>,
+					      <&iomuxc 19 138 1>, <&iomuxc 20 139 1>,
+					      <&iomuxc 21 137 1>;
 			};
 
 			gpio6: gpio at 20b0000 {
-- 
2.7.4
