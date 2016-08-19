From: vladimir_zapolskiy@mentor.com (Vladimir Zapolskiy)
Date: Sat, 20 Aug 2016 01:06:28 +0300
Subject: [PATCH 7/7] ARM: dts: add gpio-ranges property to iMX7D/S GPIO
 controllers
In-Reply-To: <1471644388-10220-1-git-send-email-vladimir_zapolskiy@mentor.com>
References: <1471644388-10220-1-git-send-email-vladimir_zapolskiy@mentor.com>
Message-ID: <1471644388-10220-8-git-send-email-vladimir_zapolskiy@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To establish a connection between GPIO controllers and pin multiplexor
controller add gpio-ranges properties to all GPIO controllers found
on iMX50 SoC. The change was done after human parsing of output from

% gawk -n '{ sub(/.*__/, ""); if ($1 ~ "^GPIO") print $1, $2/4}' imx7d-pinfunc.h | sort -n

Signed-off-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
---
 arch/arm/boot/dts/imx7s.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/imx7s.dtsi b/arch/arm/boot/dts/imx7s.dtsi
index 1e90bdbe3a6e..ed48ae44988e 100644
--- a/arch/arm/boot/dts/imx7s.dtsi
+++ b/arch/arm/boot/dts/imx7s.dtsi
@@ -325,6 +325,8 @@
 				#gpio-cells = <2>;
 				interrupt-controller;
 				#interrupt-cells = <2>;
+
+				gpio-ranges = <&iomuxc_lpsr 0 0 8>, <&iomuxc 8 5 8>;
 			};
 
 			gpio2: gpio at 30210000 {
@@ -336,6 +338,8 @@
 				#gpio-cells = <2>;
 				interrupt-controller;
 				#interrupt-cells = <2>;
+
+				gpio-ranges = <&iomuxc 0 13 32>;
 			};
 
 			gpio3: gpio at 30220000 {
@@ -347,6 +351,8 @@
 				#gpio-cells = <2>;
 				interrupt-controller;
 				#interrupt-cells = <2>;
+
+				gpio-ranges = <&iomuxc 0 45 29>;
 			};
 
 			gpio4: gpio at 30230000 {
@@ -358,6 +364,8 @@
 				#gpio-cells = <2>;
 				interrupt-controller;
 				#interrupt-cells = <2>;
+
+				gpio-ranges = <&iomuxc 0 74 24>;
 			};
 
 			gpio5: gpio at 30240000 {
@@ -369,6 +377,8 @@
 				#gpio-cells = <2>;
 				interrupt-controller;
 				#interrupt-cells = <2>;
+
+				gpio-ranges = <&iomuxc 0 98 18>;
 			};
 
 			gpio6: gpio at 30250000 {
@@ -380,6 +390,8 @@
 				#gpio-cells = <2>;
 				interrupt-controller;
 				#interrupt-cells = <2>;
+
+				gpio-ranges = <&iomuxc 0 116 23>;
 			};
 
 			gpio7: gpio at 30260000 {
@@ -391,6 +403,8 @@
 				#gpio-cells = <2>;
 				interrupt-controller;
 				#interrupt-cells = <2>;
+
+				gpio-ranges = <&iomuxc 0 139 16>;
 			};
 
 			wdog1: wdog at 30280000 {
-- 
2.8.1
