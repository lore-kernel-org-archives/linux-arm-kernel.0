From: vladimir_zapolskiy@mentor.com (Vladimir Zapolskiy)
Date: Sat, 20 Aug 2016 23:04:49 +0300
Subject: [PATCH v2 5/7] ARM: dts: add gpio-ranges property to iMX6SX GPIO
 controllers
In-Reply-To: <1471723491-15330-1-git-send-email-vladimir_zapolskiy@mentor.com>
References: <1471723491-15330-1-git-send-email-vladimir_zapolskiy@mentor.com>
Message-ID: <1471723491-15330-6-git-send-email-vladimir_zapolskiy@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To establish a connection between GPIO controllers and pin multiplexor
controller add gpio-ranges properties to all GPIO controllers found
on iMX6SX SoC. The change was done after human parsing of output from

% gawk -n '{ sub(/.*__/, ""); if ($1 ~ "^GPIO") print $1, $2/4}' imx6sx-pinfunc.h | sort -n

Signed-off-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
---
Changes from v1 to v2:
* in commit message body fixed SoC name to iMX6SX

 arch/arm/boot/dts/imx6sx.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/imx6sx.dtsi b/arch/arm/boot/dts/imx6sx.dtsi
index 2863c52be6f5..5ad851a75587 100644
--- a/arch/arm/boot/dts/imx6sx.dtsi
+++ b/arch/arm/boot/dts/imx6sx.dtsi
@@ -438,6 +438,8 @@
 				#gpio-cells = <2>;
 				interrupt-controller;
 				#interrupt-cells = <2>;
+
+				gpio-ranges = <&iomuxc 0 5 26>;
 			};
 
 			gpio2: gpio at 020a0000 {
@@ -449,6 +451,8 @@
 				#gpio-cells = <2>;
 				interrupt-controller;
 				#interrupt-cells = <2>;
+
+				gpio-ranges = <&iomuxc 0 31 20>;
 			};
 
 			gpio3: gpio at 020a4000 {
@@ -460,6 +464,8 @@
 				#gpio-cells = <2>;
 				interrupt-controller;
 				#interrupt-cells = <2>;
+
+				gpio-ranges = <&iomuxc 0 51 29>;
 			};
 
 			gpio4: gpio at 020a8000 {
@@ -471,6 +477,8 @@
 				#gpio-cells = <2>;
 				interrupt-controller;
 				#interrupt-cells = <2>;
+
+				gpio-ranges = <&iomuxc 0 80 32>;
 			};
 
 			gpio5: gpio at 020ac000 {
@@ -482,6 +490,8 @@
 				#gpio-cells = <2>;
 				interrupt-controller;
 				#interrupt-cells = <2>;
+
+				gpio-ranges = <&iomuxc 0 112 24>;
 			};
 
 			gpio6: gpio at 020b0000 {
@@ -493,6 +503,8 @@
 				#gpio-cells = <2>;
 				interrupt-controller;
 				#interrupt-cells = <2>;
+
+				gpio-ranges = <&iomuxc 0 136 12>, <&iomuxc 12 158 11>;
 			};
 
 			gpio7: gpio at 020b4000 {
@@ -504,6 +516,8 @@
 				#gpio-cells = <2>;
 				interrupt-controller;
 				#interrupt-cells = <2>;
+
+				gpio-ranges = <&iomuxc 0 148 10>, <&iomuxc 10 169 2>;
 			};
 
 			kpp: kpp at 020b8000 {
-- 
2.8.1
