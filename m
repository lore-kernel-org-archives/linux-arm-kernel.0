From: vladimir_zapolskiy@mentor.com (Vladimir Zapolskiy)
Date: Sat, 20 Aug 2016 01:06:24 +0300
Subject: [PATCH 3/7] ARM: dts: add gpio-ranges property to iMX6DL/S GPIO
 controllers
In-Reply-To: <1471644388-10220-1-git-send-email-vladimir_zapolskiy@mentor.com>
References: <1471644388-10220-1-git-send-email-vladimir_zapolskiy@mentor.com>
Message-ID: <1471644388-10220-4-git-send-email-vladimir_zapolskiy@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To establish a connection between GPIO controllers and pin multiplexor
controller add gpio-ranges properties to all GPIO controllers found
on iMX50 SoC. The change was done after human parsing of output from

% gawk -n '{ sub(/.*__/, ""); if ($1 ~ "^GPIO") print $1, $2/4}' imx6dl-pinfunc.h | sort -n

Signed-off-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
---
 arch/arm/boot/dts/imx6dl.dtsi | 53 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

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
-- 
2.8.1
