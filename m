From: vladimir_zapolskiy@mentor.com (Vladimir Zapolskiy)
Date: Sat, 20 Aug 2016 01:06:27 +0300
Subject: [PATCH 6/7] ARM: dts: add gpio-ranges property to iMX6UL GPIO
 controllers
In-Reply-To: <1471644388-10220-1-git-send-email-vladimir_zapolskiy@mentor.com>
References: <1471644388-10220-1-git-send-email-vladimir_zapolskiy@mentor.com>
Message-ID: <1471644388-10220-7-git-send-email-vladimir_zapolskiy@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To establish a connection between GPIO controllers and pin multiplexor
controller add gpio-ranges properties to all GPIO controllers found
on iMX50 SoC. The change was done after human parsing of output from

% gawk -n '{ sub(/.*__/, ""); if ($1 ~ "^GPIO") print $1, $2/4}' imx6ul-pinfunc.h | sort -n

Signed-off-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
---
 arch/arm/boot/dts/imx6ul.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/imx6ul.dtsi b/arch/arm/boot/dts/imx6ul.dtsi
index 33b95d78831a..1fd7f4be9d79 100644
--- a/arch/arm/boot/dts/imx6ul.dtsi
+++ b/arch/arm/boot/dts/imx6ul.dtsi
@@ -411,6 +411,9 @@
 				#gpio-cells = <2>;
 				interrupt-controller;
 				#interrupt-cells = <2>;
+
+				gpio-ranges = <&iomuxc  0 23 10>, <&iomuxc 10 17 6>,
+					      <&iomuxc 16 33 16>;
 			};
 
 			gpio2: gpio at 020a0000 {
@@ -422,6 +425,8 @@
 				#gpio-cells = <2>;
 				interrupt-controller;
 				#interrupt-cells = <2>;
+
+				gpio-ranges = <&iomuxc 0 49 16>, <&iomuxc 16 111 6>;
 			};
 
 			gpio3: gpio at 020a4000 {
@@ -433,6 +438,8 @@
 				#gpio-cells = <2>;
 				interrupt-controller;
 				#interrupt-cells = <2>;
+
+				gpio-ranges = <&iomuxc 0 65 29>;
 			};
 
 			gpio4: gpio at 020a8000 {
@@ -444,6 +451,8 @@
 				#gpio-cells = <2>;
 				interrupt-controller;
 				#interrupt-cells = <2>;
+
+				gpio-ranges = <&iomuxc 0 94 17>, <&iomuxc 17 117 12>;
 			};
 
 			gpio5: gpio at 020ac000 {
@@ -455,6 +464,8 @@
 				#gpio-cells = <2>;
 				interrupt-controller;
 				#interrupt-cells = <2>;
+
+				gpio-ranges = <&iomuxc 0 7 10>, <&iomuxc 10 5 2>;
 			};
 
 			fec2: ethernet at 020b4000 {
-- 
2.8.1
