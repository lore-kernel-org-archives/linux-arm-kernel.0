From: vladimir_zapolskiy@mentor.com (Vladimir Zapolskiy)
Date: Fri, 9 Sep 2016 05:02:36 +0300
Subject: [PATCH v3] ARM: dts: add gpio-ranges property to iMX GPIO controllers
Message-ID: <1473386556-1934-1-git-send-email-vladimir_zapolskiy@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To establish a connection between GPIO controllers and pin multiplexor
controller add gpio-ranges properties to all GPIO controllers found
on iMX50, iMX6Q/D, iMX6DL/S, iMX6SL, iMX6SX, iMX6UL and iMX7D/S
SoCs. The change was done after human parsing of output from

% gawk -n '{ sub(/.*__/, ""); if ($1 ~ "^GPIO") print $1, $2/4}' imxXX-pinfunc.h | sort -n

Signed-off-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
---
Changes from v2 to v3:
* squashed patches against particular SoCs into one single change
* removed empty lines preceding to the added gpio-ranges property

Changes from v1 to v2:
* in copy-pasted commit messages corrected SoC names

 arch/arm/boot/dts/imx50.dtsi  | 10 ++++++++
 arch/arm/boot/dts/imx6dl.dtsi | 53 +++++++++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/imx6q.dtsi  | 37 ++++++++++++++++++++++++++++++
 arch/arm/boot/dts/imx6sl.dtsi | 47 ++++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/imx6sx.dtsi |  7 ++++++
 arch/arm/boot/dts/imx6ul.dtsi |  6 +++++
 arch/arm/boot/dts/imx7s.dtsi  |  7 ++++++
 7 files changed, 167 insertions(+)

diff --git a/arch/arm/boot/dts/imx50.dtsi b/arch/arm/boot/dts/imx50.dtsi
index e2457138311f..8fe8beeb68a4 100644
--- a/arch/arm/boot/dts/imx50.dtsi
+++ b/arch/arm/boot/dts/imx50.dtsi
@@ -227,6 +227,7 @@
 				#gpio-cells = <2>;
 				interrupt-controller;
 				#interrupt-cells = <2>;
+				gpio-ranges = <&iomuxc 0 151 28>;
 			};
 
 			gpio2: gpio at 53f88000 {
@@ -237,6 +238,10 @@
 				#gpio-cells = <2>;
 				interrupt-controller;
 				#interrupt-cells = <2>;
+				gpio-ranges = <&iomuxc  0 75 8>, <&iomuxc 8 100 8>,
+					      <&iomuxc 16 83 1>, <&iomuxc 17 85 1>,
+					      <&iomuxc 18 87 1>, <&iomuxc 19 84 1>,
+					      <&iomuxc 20 88 1>, <&iomuxc 21 86 1>;
 			};
 
 			gpio3: gpio at 53f8c000 {
@@ -247,6 +252,7 @@
 				#gpio-cells = <2>;
 				interrupt-controller;
 				#interrupt-cells = <2>;
+				gpio-ranges = <&iomuxc 0 108 32>;
 			};
 
 			gpio4: gpio at 53f90000 {
@@ -257,6 +263,8 @@
 				#gpio-cells = <2>;
 				interrupt-controller;
 				#interrupt-cells = <2>;
+				gpio-ranges = <&iomuxc  0   8  8>, <&iomuxc 8 45 12>,
+					      <&iomuxc 20 140 11>;
 			};
 
 			wdog1: wdog at 53f98000 {
@@ -346,6 +354,7 @@
 				#gpio-cells = <2>;
 				interrupt-controller;
 				#interrupt-cells = <2>;
+				gpio-ranges = <&iomuxc 0 57 18>, <&iomuxc 18 89 11>;
 			};
 
 			gpio6: gpio at 53fe0000 {
@@ -356,6 +365,7 @@
 				#gpio-cells = <2>;
 				interrupt-controller;
 				#interrupt-cells = <2>;
+				gpio-ranges = <&iomuxc 0 27 18>, <&iomuxc 18 16 11>;
 			};
 
 			i2c3: i2c at 53fec000 {
diff --git a/arch/arm/boot/dts/imx6dl.dtsi b/arch/arm/boot/dts/imx6dl.dtsi
index 9a4c22c2dade..1ade1951e620 100644
--- a/arch/arm/boot/dts/imx6dl.dtsi
+++ b/arch/arm/boot/dts/imx6dl.dtsi
@@ -111,6 +111,59 @@
 	};
 };
 
+&gpio1 {
+	gpio-ranges = <&iomuxc  0 131 2>, <&iomuxc  2 137 8>, <&iomuxc 10 189 2>,
+		      <&iomuxc 12 194 1>, <&iomuxc 13 193 1>, <&iomuxc 14 192 1>,
+		      <&iomuxc 15 191 1>, <&iomuxc 16 185 2>, <&iomuxc 18 184 1>,
+		      <&iomuxc 19 187 1>, <&iomuxc 20 183 1>, <&iomuxc 21 188 1>,
+		      <&iomuxc 22 123 3>, <&iomuxc 25 121 1>, <&iomuxc 26 127 1>,
+		      <&iomuxc 27 126 1>, <&iomuxc 28 128 1>, <&iomuxc 29 130 1>,
+		      <&iomuxc 30 129 1>, <&iomuxc 31 122 1>;
+};
+
+&gpio2 {
+	gpio-ranges = <&iomuxc  0 161 8>, <&iomuxc  8 208 8>, <&iomuxc 16  74 1>,
+		      <&iomuxc 17  73 1>, <&iomuxc 18  72 1>, <&iomuxc 19  71 1>,
+		      <&iomuxc 20  70 1>, <&iomuxc 21  69 1>, <&iomuxc 22  68 1>,
+		      <&iomuxc 23  79 2>, <&iomuxc 25 118 2>, <&iomuxc 27 117 1>,
+		      <&iomuxc 28 113 4>;
+};
+
+&gpio3 {
+	gpio-ranges = <&iomuxc  0 97  2>, <&iomuxc 2 105 8>, <&iomuxc 10 99 6>,
+		      <&iomuxc 16 81 16>;
+};
+
+&gpio4 {
+	gpio-ranges = <&iomuxc  5 136 1>, <&iomuxc  6 145 1>, <&iomuxc  7 150 1>,
+		      <&iomuxc  8 146 1>, <&iomuxc  9 151 1>, <&iomuxc 10 147 1>,
+		      <&iomuxc 11 151 1>, <&iomuxc 12 148 1>, <&iomuxc 13 153 1>,
+		      <&iomuxc 14 149 1>, <&iomuxc 15 154 1>, <&iomuxc 16  39 7>,
+		      <&iomuxc 23  56 1>, <&iomuxc 24  61 7>, <&iomuxc 31  46 1>;
+};
+
+&gpio5 {
+	gpio-ranges = <&iomuxc  0 120 1>, <&iomuxc  2 77 1>, <&iomuxc  4 76 1>,
+		      <&iomuxc  5  47 9>, <&iomuxc 14 57 4>, <&iomuxc 18 37 1>,
+		      <&iomuxc 19  36 1>, <&iomuxc 20 35 1>, <&iomuxc 21 38 1>,
+		      <&iomuxc 22  29 6>, <&iomuxc 28 19 4>;
+};
+
+&gpio6 {
+	gpio-ranges = <&iomuxc  0  23 6>, <&iomuxc  6  75 1>, <&iomuxc  7 156 1>,
+		      <&iomuxc  8 155 1>, <&iomuxc  9 170 1>, <&iomuxc 10 169 1>,
+		      <&iomuxc 11 157 1>, <&iomuxc 14 158 3>, <&iomuxc 17 204 1>,
+		      <&iomuxc 18 203 1>, <&iomuxc 19 182 1>, <&iomuxc 20 177 4>,
+		      <&iomuxc 24 175 1>, <&iomuxc 25 171 1>, <&iomuxc 26 181 1>,
+		      <&iomuxc 27 172 3>, <&iomuxc 30 176 1>, <&iomuxc 31  78 1>;
+};
+
+&gpio7 {
+	gpio-ranges = <&iomuxc 0 202 1>, <&iomuxc  1 201 1>, <&iomuxc  2 196 1>,
+		      <&iomuxc 3 195 1>, <&iomuxc  4 197 4>, <&iomuxc  8 205 1>,
+		      <&iomuxc 9 207 1>, <&iomuxc 10 206 1>, <&iomuxc 11 133 3>;
+};
+
 &gpt {
 	compatible = "fsl,imx6dl-gpt";
 };
diff --git a/arch/arm/boot/dts/imx6q.dtsi b/arch/arm/boot/dts/imx6q.dtsi
index c30c8368cae0..e9a5d0b8c7b0 100644
--- a/arch/arm/boot/dts/imx6q.dtsi
+++ b/arch/arm/boot/dts/imx6q.dtsi
@@ -209,6 +209,43 @@
 	};
 };
 
+&gpio1 {
+	gpio-ranges = <&iomuxc  0 136  2>, <&iomuxc  2 141 1>, <&iomuxc  3 139 1>,
+		      <&iomuxc  4 142  2>, <&iomuxc  6 140 1>, <&iomuxc  7 144 2>,
+		      <&iomuxc  9 138  1>, <&iomuxc 10 213 3>, <&iomuxc 13  20 1>,
+		      <&iomuxc 14  19  1>, <&iomuxc 15  21 1>, <&iomuxc 16 208 1>,
+		      <&iomuxc 17 207  1>, <&iomuxc 18 210 3>, <&iomuxc 21 209 1>,
+		      <&iomuxc 22 116 10>;
+};
+
+&gpio2 {
+	gpio-ranges = <&iomuxc  0 191 16>, <&iomuxc 16 55 14>, <&iomuxc 30 35 1>,
+		      <&iomuxc 31  44  1>;
+};
+
+&gpio3 {
+	gpio-ranges = <&iomuxc 0 69 16>, <&iomuxc 16 36 8>, <&iomuxc 24 45 8>;
+};
+
+&gpio4 {
+	gpio-ranges = <&iomuxc 5 149 1>, <&iomuxc 6 126 10>, <&iomuxc 16 87 16>;
+};
+
+&gpio5 {
+	gpio-ranges = <&iomuxc 0  85  1>, <&iomuxc  2  34  1>, <&iomuxc 4 53 1>,
+		      <&iomuxc 5 103 13>, <&iomuxc 18 150 14>;
+};
+
+&gpio6 {
+	gpio-ranges = <&iomuxc  0 164 6>, <&iomuxc  6  54 1>, <&iomuxc  7 181  5>,
+		      <&iomuxc 14 186 3>, <&iomuxc 17 170 2>, <&iomuxc 19  22 12>,
+		      <&iomuxc 31  86 1>;
+};
+
+&gpio7 {
+	gpio-ranges = <&iomuxc 0 172 9>, <&iomuxc 9 189 2>, <&iomuxc 11 146 3>;
+};
+
 &hdmi {
 	compatible = "fsl,imx6q-hdmi";
 
diff --git a/arch/arm/boot/dts/imx6sl.dtsi b/arch/arm/boot/dts/imx6sl.dtsi
index 542515089b1e..02378db3f5fc 100644
--- a/arch/arm/boot/dts/imx6sl.dtsi
+++ b/arch/arm/boot/dts/imx6sl.dtsi
@@ -375,6 +375,12 @@
 				#gpio-cells = <2>;
 				interrupt-controller;
 				#interrupt-cells = <2>;
+				gpio-ranges = <&iomuxc  0 22 1>, <&iomuxc  1 20 2>,
+					      <&iomuxc  3 23 1>, <&iomuxc  4 25 1>,
+					      <&iomuxc  5 24 1>, <&iomuxc  6 19 1>,
+					      <&iomuxc  7 36 2>, <&iomuxc  9 44 8>,
+					      <&iomuxc 17 38 6>, <&iomuxc 23 68 4>,
+					      <&iomuxc 27 64 4>, <&iomuxc 31 52 1>;
 			};
 
 			gpio2: gpio at 020a0000 {
@@ -386,6 +392,13 @@
 				#gpio-cells = <2>;
 				interrupt-controller;
 				#interrupt-cells = <2>;
+				gpio-ranges = <&iomuxc  0  53 3>, <&iomuxc  3  72 2>,
+					      <&iomuxc  5  34 2>, <&iomuxc  7  57 4>,
+					      <&iomuxc 11  56 1>, <&iomuxc 12  61 3>,
+					      <&iomuxc 15 107 1>, <&iomuxc 16 132 2>,
+					      <&iomuxc 18 135 1>, <&iomuxc 19 134 1>,
+					      <&iomuxc 20 108 2>, <&iomuxc 22 120 1>,
+					      <&iomuxc 23 125 7>, <&iomuxc 30 110 2>;
 			};
 
 			gpio3: gpio at 020a4000 {
@@ -397,6 +410,14 @@
 				#gpio-cells = <2>;
 				interrupt-controller;
 				#interrupt-cells = <2>;
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
@@ -408,6 +429,21 @@
 				#gpio-cells = <2>;
 				interrupt-controller;
 				#interrupt-cells = <2>;
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
@@ -419,6 +455,17 @@
 				#gpio-cells = <2>;
 				interrupt-controller;
 				#interrupt-cells = <2>;
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
diff --git a/arch/arm/boot/dts/imx6sx.dtsi b/arch/arm/boot/dts/imx6sx.dtsi
index 2863c52be6f5..1b62fa378161 100644
--- a/arch/arm/boot/dts/imx6sx.dtsi
+++ b/arch/arm/boot/dts/imx6sx.dtsi
@@ -438,6 +438,7 @@
 				#gpio-cells = <2>;
 				interrupt-controller;
 				#interrupt-cells = <2>;
+				gpio-ranges = <&iomuxc 0 5 26>;
 			};
 
 			gpio2: gpio at 020a0000 {
@@ -449,6 +450,7 @@
 				#gpio-cells = <2>;
 				interrupt-controller;
 				#interrupt-cells = <2>;
+				gpio-ranges = <&iomuxc 0 31 20>;
 			};
 
 			gpio3: gpio at 020a4000 {
@@ -460,6 +462,7 @@
 				#gpio-cells = <2>;
 				interrupt-controller;
 				#interrupt-cells = <2>;
+				gpio-ranges = <&iomuxc 0 51 29>;
 			};
 
 			gpio4: gpio at 020a8000 {
@@ -471,6 +474,7 @@
 				#gpio-cells = <2>;
 				interrupt-controller;
 				#interrupt-cells = <2>;
+				gpio-ranges = <&iomuxc 0 80 32>;
 			};
 
 			gpio5: gpio at 020ac000 {
@@ -482,6 +486,7 @@
 				#gpio-cells = <2>;
 				interrupt-controller;
 				#interrupt-cells = <2>;
+				gpio-ranges = <&iomuxc 0 112 24>;
 			};
 
 			gpio6: gpio at 020b0000 {
@@ -493,6 +498,7 @@
 				#gpio-cells = <2>;
 				interrupt-controller;
 				#interrupt-cells = <2>;
+				gpio-ranges = <&iomuxc 0 136 12>, <&iomuxc 12 158 11>;
 			};
 
 			gpio7: gpio at 020b4000 {
@@ -504,6 +510,7 @@
 				#gpio-cells = <2>;
 				interrupt-controller;
 				#interrupt-cells = <2>;
+				gpio-ranges = <&iomuxc 0 148 10>, <&iomuxc 10 169 2>;
 			};
 
 			kpp: kpp at 020b8000 {
diff --git a/arch/arm/boot/dts/imx6ul.dtsi b/arch/arm/boot/dts/imx6ul.dtsi
index 33b95d78831a..84c8be1e129f 100644
--- a/arch/arm/boot/dts/imx6ul.dtsi
+++ b/arch/arm/boot/dts/imx6ul.dtsi
@@ -411,6 +411,8 @@
 				#gpio-cells = <2>;
 				interrupt-controller;
 				#interrupt-cells = <2>;
+				gpio-ranges = <&iomuxc  0 23 10>, <&iomuxc 10 17 6>,
+					      <&iomuxc 16 33 16>;
 			};
 
 			gpio2: gpio at 020a0000 {
@@ -422,6 +424,7 @@
 				#gpio-cells = <2>;
 				interrupt-controller;
 				#interrupt-cells = <2>;
+				gpio-ranges = <&iomuxc 0 49 16>, <&iomuxc 16 111 6>;
 			};
 
 			gpio3: gpio at 020a4000 {
@@ -433,6 +436,7 @@
 				#gpio-cells = <2>;
 				interrupt-controller;
 				#interrupt-cells = <2>;
+				gpio-ranges = <&iomuxc 0 65 29>;
 			};
 
 			gpio4: gpio at 020a8000 {
@@ -444,6 +448,7 @@
 				#gpio-cells = <2>;
 				interrupt-controller;
 				#interrupt-cells = <2>;
+				gpio-ranges = <&iomuxc 0 94 17>, <&iomuxc 17 117 12>;
 			};
 
 			gpio5: gpio at 020ac000 {
@@ -455,6 +460,7 @@
 				#gpio-cells = <2>;
 				interrupt-controller;
 				#interrupt-cells = <2>;
+				gpio-ranges = <&iomuxc 0 7 10>, <&iomuxc 10 5 2>;
 			};
 
 			fec2: ethernet at 020b4000 {
diff --git a/arch/arm/boot/dts/imx7s.dtsi b/arch/arm/boot/dts/imx7s.dtsi
index 1e90bdbe3a6e..fb4f9440d6df 100644
--- a/arch/arm/boot/dts/imx7s.dtsi
+++ b/arch/arm/boot/dts/imx7s.dtsi
@@ -325,6 +325,7 @@
 				#gpio-cells = <2>;
 				interrupt-controller;
 				#interrupt-cells = <2>;
+				gpio-ranges = <&iomuxc_lpsr 0 0 8>, <&iomuxc 8 5 8>;
 			};
 
 			gpio2: gpio at 30210000 {
@@ -336,6 +337,7 @@
 				#gpio-cells = <2>;
 				interrupt-controller;
 				#interrupt-cells = <2>;
+				gpio-ranges = <&iomuxc 0 13 32>;
 			};
 
 			gpio3: gpio at 30220000 {
@@ -347,6 +349,7 @@
 				#gpio-cells = <2>;
 				interrupt-controller;
 				#interrupt-cells = <2>;
+				gpio-ranges = <&iomuxc 0 45 29>;
 			};
 
 			gpio4: gpio at 30230000 {
@@ -358,6 +361,7 @@
 				#gpio-cells = <2>;
 				interrupt-controller;
 				#interrupt-cells = <2>;
+				gpio-ranges = <&iomuxc 0 74 24>;
 			};
 
 			gpio5: gpio at 30240000 {
@@ -369,6 +373,7 @@
 				#gpio-cells = <2>;
 				interrupt-controller;
 				#interrupt-cells = <2>;
+				gpio-ranges = <&iomuxc 0 98 18>;
 			};
 
 			gpio6: gpio at 30250000 {
@@ -380,6 +385,7 @@
 				#gpio-cells = <2>;
 				interrupt-controller;
 				#interrupt-cells = <2>;
+				gpio-ranges = <&iomuxc 0 116 23>;
 			};
 
 			gpio7: gpio at 30260000 {
@@ -391,6 +397,7 @@
 				#gpio-cells = <2>;
 				interrupt-controller;
 				#interrupt-cells = <2>;
+				gpio-ranges = <&iomuxc 0 139 16>;
 			};
 
 			wdog1: wdog at 30280000 {
-- 
2.8.1
