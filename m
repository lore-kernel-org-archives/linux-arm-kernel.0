From: vladimir_zapolskiy@mentor.com (Vladimir Zapolskiy)
Date: Sat, 20 Aug 2016 23:04:48 +0300
Subject: [PATCH v2 4/7] ARM: dts: add gpio-ranges property to iMX6SL GPIO
 controllers
In-Reply-To: <1471723491-15330-1-git-send-email-vladimir_zapolskiy@mentor.com>
References: <1471723491-15330-1-git-send-email-vladimir_zapolskiy@mentor.com>
Message-ID: <1471723491-15330-5-git-send-email-vladimir_zapolskiy@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To establish a connection between GPIO controllers and pin multiplexor
controller add gpio-ranges properties to all GPIO controllers found
on iMX6SL SoC. The change was done after human parsing of output from

% gawk -n '{ sub(/.*__/, ""); if ($1 ~ "^GPIO") print $1, $2/4}' imx6sl-pinfunc.h | sort -n

Signed-off-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
---
Changes from v1 to v2:
* in commit message body fixed SoC name to iMX6SL

 arch/arm/boot/dts/imx6sl.dtsi | 52 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/arch/arm/boot/dts/imx6sl.dtsi b/arch/arm/boot/dts/imx6sl.dtsi
index 542515089b1e..0066f8625b8d 100644
--- a/arch/arm/boot/dts/imx6sl.dtsi
+++ b/arch/arm/boot/dts/imx6sl.dtsi
@@ -375,6 +375,13 @@
 				#gpio-cells = <2>;
 				interrupt-controller;
 				#interrupt-cells = <2>;
+
+				gpio-ranges = <&iomuxc  0 22 1>, <&iomuxc  1 20 2>,
+					      <&iomuxc  3 23 1>, <&iomuxc  4 25 1>,
+					      <&iomuxc  5 24 1>, <&iomuxc  6 19 1>,
+					      <&iomuxc  7 36 2>, <&iomuxc  9 44 8>,
+					      <&iomuxc 17 38 6>, <&iomuxc 23 68 4>,
+					      <&iomuxc 27 64 4>, <&iomuxc 31 52 1>;
 			};
 
 			gpio2: gpio at 020a0000 {
@@ -386,6 +393,14 @@
 				#gpio-cells = <2>;
 				interrupt-controller;
 				#interrupt-cells = <2>;
+
+				gpio-ranges = <&iomuxc  0  53 3>, <&iomuxc  3  72 2>,
+					      <&iomuxc  5  34 2>, <&iomuxc  7  57 4>,
+					      <&iomuxc 11  56 1>, <&iomuxc 12  61 3>,
+					      <&iomuxc 15 107 1>, <&iomuxc 16 132 2>,
+					      <&iomuxc 18 135 1>, <&iomuxc 19 134 1>,
+					      <&iomuxc 20 108 2>, <&iomuxc 22 120 1>,
+					      <&iomuxc 23 125 7>, <&iomuxc 30 110 2>;
 			};
 
 			gpio3: gpio at 020a4000 {
@@ -397,6 +412,15 @@
 				#gpio-cells = <2>;
 				interrupt-controller;
 				#interrupt-cells = <2>;
+
+				gpio-ranges = <&iomuxc  0 112 8>, <&iomuxc  8 121 4>,
+					      <&iomuxc 12  97 4>, <&iomuxc 16 166 3>,
+					      <&iomuxc 19  85 2>, <&iomuxc 21 137 2>,
+					      <&iomuxc 23 136 1>, <&iomuxc 24  91 1>,
+					      <&iomuxc 25  99 1>, <&iomuxc 26  92 1>,
+					      <&iomuxc 27 100 1>, <&iomuxc 28  93 1>,
+					      <&iomuxc 29 101 1>, <&iomuxc 30  94 1>,
+					      <&iomuxc 31 102 1>;
 			};
 
 			gpio4: gpio at 020a8000 {
@@ -408,6 +432,22 @@
 				#gpio-cells = <2>;
 				interrupt-controller;
 				#interrupt-cells = <2>;
+
+				gpio-ranges = <&iomuxc  0  95 1>, <&iomuxc  1 103 1>,
+					      <&iomuxc  2  96 1>, <&iomuxc  3 104 1>,
+					      <&iomuxc  4  97 1>, <&iomuxc  5 105 1>,
+					      <&iomuxc  6  98 1>, <&iomuxc  7 106 1>,
+					      <&iomuxc  8  28 1>, <&iomuxc  9  27 1>,
+					      <&iomuxc 10  26 1>, <&iomuxc 11  29 1>,
+					      <&iomuxc 12  32 1>, <&iomuxc 13  31 1>,
+					      <&iomuxc 14  30 1>, <&iomuxc 15  33 1>,
+					      <&iomuxc 16  84 1>, <&iomuxc 17  79 2>,
+					      <&iomuxc 19  78 1>, <&iomuxc 20  76 1>,
+					      <&iomuxc 21  81 2>, <&iomuxc 23  75 1>,
+					      <&iomuxc 24  83 1>, <&iomuxc 25  74 1>,
+					      <&iomuxc 26  77 1>, <&iomuxc 27 159 1>,
+					      <&iomuxc 28 154 1>, <&iomuxc 29 157 1>,
+					      <&iomuxc 30 152 1>, <&iomuxc 31 156 1>;
 			};
 
 			gpio5: gpio at 020ac000 {
@@ -419,6 +459,18 @@
 				#gpio-cells = <2>;
 				interrupt-controller;
 				#interrupt-cells = <2>;
+
+				gpio-ranges = <&iomuxc  0 158 1>, <&iomuxc  1 151 1>,
+					      <&iomuxc  2 155 1>, <&iomuxc  3 153 1>,
+					      <&iomuxc  4 150 1>, <&iomuxc  5 149 1>,
+					      <&iomuxc  6 144 1>, <&iomuxc  7 147 1>,
+					      <&iomuxc  8 142 1>, <&iomuxc  9 146 1>,
+					      <&iomuxc 10 148 1>, <&iomuxc 11 141 1>,
+					      <&iomuxc 12 145 1>, <&iomuxc 13 143 1>,
+					      <&iomuxc 14 140 1>, <&iomuxc 15 139 1>,
+					      <&iomuxc 16 164 2>, <&iomuxc 18 160 1>,
+					      <&iomuxc 19 162 1>, <&iomuxc 20 163 1>,
+					      <&iomuxc 21 161 1>;
 			};
 
 			kpp: kpp at 020b8000 {
-- 
2.8.1
