From: vladimir_zapolskiy@mentor.com (Vladimir Zapolskiy)
Date: Sat, 20 Aug 2016 01:06:23 +0300
Subject: [PATCH 2/7] ARM: dts: add gpio-ranges property to iMX6Q/D GPIO
 controllers
In-Reply-To: <1471644388-10220-1-git-send-email-vladimir_zapolskiy@mentor.com>
References: <1471644388-10220-1-git-send-email-vladimir_zapolskiy@mentor.com>
Message-ID: <1471644388-10220-3-git-send-email-vladimir_zapolskiy@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To establish a connection between GPIO controllers and pin multiplexor
controller add gpio-ranges properties to all GPIO controllers found
on iMX50 SoC. The change was done after human parsing of output from

% gawk -n '{ sub(/.*__/, ""); if ($1 ~ "^GPIO") print $1, $2/4}' imx6q-pinfunc.h | sort -n

Signed-off-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
---
 arch/arm/boot/dts/imx6q.dtsi | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

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
 
-- 
2.8.1
