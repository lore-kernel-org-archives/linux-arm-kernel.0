From: vladimir_zapolskiy@mentor.com (Vladimir Zapolskiy)
Date: Sat, 20 Aug 2016 23:04:45 +0300
Subject: [PATCH v2 1/7] ARM: dts: add gpio-ranges property to iMX50 GPIO
 controllers
In-Reply-To: <1471723491-15330-1-git-send-email-vladimir_zapolskiy@mentor.com>
References: <1471723491-15330-1-git-send-email-vladimir_zapolskiy@mentor.com>
Message-ID: <1471723491-15330-2-git-send-email-vladimir_zapolskiy@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To establish a connection between GPIO controllers and pin multiplexor
controller add gpio-ranges properties to all GPIO controllers found
on iMX50 SoC. The change was done after human parsing of output from

% gawk -n '{ sub(/.*__/, ""); if ($1 ~ "^GPIO") print $1, $2/4}' imx50-pinfunc.h | sort -n

Signed-off-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
---
Changes from v1 to v2:
* none

 arch/arm/boot/dts/imx50.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/imx50.dtsi b/arch/arm/boot/dts/imx50.dtsi
index e2457138311f..898532f7a4e9 100644
--- a/arch/arm/boot/dts/imx50.dtsi
+++ b/arch/arm/boot/dts/imx50.dtsi
@@ -227,6 +227,8 @@
 				#gpio-cells = <2>;
 				interrupt-controller;
 				#interrupt-cells = <2>;
+
+				gpio-ranges = <&iomuxc 0 151 28>;
 			};
 
 			gpio2: gpio at 53f88000 {
@@ -237,6 +239,11 @@
 				#gpio-cells = <2>;
 				interrupt-controller;
 				#interrupt-cells = <2>;
+
+				gpio-ranges = <&iomuxc  0 75 8>, <&iomuxc 8 100 8>,
+					      <&iomuxc 16 83 1>, <&iomuxc 17 85 1>,
+					      <&iomuxc 18 87 1>, <&iomuxc 19 84 1>,
+					      <&iomuxc 20 88 1>, <&iomuxc 21 86 1>;
 			};
 
 			gpio3: gpio at 53f8c000 {
@@ -247,6 +254,8 @@
 				#gpio-cells = <2>;
 				interrupt-controller;
 				#interrupt-cells = <2>;
+
+				gpio-ranges = <&iomuxc 0 108 32>;
 			};
 
 			gpio4: gpio at 53f90000 {
@@ -257,6 +266,9 @@
 				#gpio-cells = <2>;
 				interrupt-controller;
 				#interrupt-cells = <2>;
+
+				gpio-ranges = <&iomuxc  0   8  8>, <&iomuxc 8 45 12>,
+					      <&iomuxc 20 140 11>;
 			};
 
 			wdog1: wdog at 53f98000 {
@@ -346,6 +358,8 @@
 				#gpio-cells = <2>;
 				interrupt-controller;
 				#interrupt-cells = <2>;
+
+				gpio-ranges = <&iomuxc 0 57 18>, <&iomuxc 18 89 11>;
 			};
 
 			gpio6: gpio at 53fe0000 {
@@ -356,6 +370,8 @@
 				#gpio-cells = <2>;
 				interrupt-controller;
 				#interrupt-cells = <2>;
+
+				gpio-ranges = <&iomuxc 0 27 18>, <&iomuxc 18 16 11>;
 			};
 
 			i2c3: i2c at 53fec000 {
-- 
2.8.1
