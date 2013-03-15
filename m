From: jon-hunter@ti.com (Jon Hunter)
Date: Fri, 15 Mar 2013 08:57:39 -0500
Subject: [PATCH V2 6/8] ARM: dts: OMAP3+: Correct gpio #interrupts-cells
 property
In-Reply-To: <1363355861-11773-1-git-send-email-jon-hunter@ti.com>
References: <1363355861-11773-1-git-send-email-jon-hunter@ti.com>
Message-ID: <1363355861-11773-7-git-send-email-jon-hunter@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The OMAP gpio binding documention [1] states that the #interrupts-cells
property for gpio controllers should be 2. Currently, for OMAP3+ devices
the #interrupt-cells is set to 1. By setting this property to 2, it
allows clients to pass a 2nd parameter indicating the sensitivity (level
or edge) and polarity (high or low) of the interrupt. The OMAP gpio
controllers support these options and so update the #interrupt-cells
property for OMAP3+ devices to 2.

[1] Documentation/devicetree/bindings/gpio/gpio-omap.txt

Signed-off-by: Jon Hunter <jon-hunter@ti.com>
---
 arch/arm/boot/dts/omap3.dtsi |   12 ++++++------
 arch/arm/boot/dts/omap4.dtsi |   12 ++++++------
 arch/arm/boot/dts/omap5.dtsi |   16 ++++++++--------
 3 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dtsi
index 1dc72ea..badedc8 100644
--- a/arch/arm/boot/dts/omap3.dtsi
+++ b/arch/arm/boot/dts/omap3.dtsi
@@ -117,7 +117,7 @@
 			gpio-controller;
 			#gpio-cells = <2>;
 			interrupt-controller;
-			#interrupt-cells = <1>;
+			#interrupt-cells = <2>;
 		};
 
 		gpio2: gpio at 49050000 {
@@ -126,7 +126,7 @@
 			gpio-controller;
 			#gpio-cells = <2>;
 			interrupt-controller;
-			#interrupt-cells = <1>;
+			#interrupt-cells = <2>;
 		};
 
 		gpio3: gpio at 49052000 {
@@ -135,7 +135,7 @@
 			gpio-controller;
 			#gpio-cells = <2>;
 			interrupt-controller;
-			#interrupt-cells = <1>;
+			#interrupt-cells = <2>;
 		};
 
 		gpio4: gpio at 49054000 {
@@ -144,7 +144,7 @@
 			gpio-controller;
 			#gpio-cells = <2>;
 			interrupt-controller;
-			#interrupt-cells = <1>;
+			#interrupt-cells = <2>;
 		};
 
 		gpio5: gpio at 49056000 {
@@ -153,7 +153,7 @@
 			gpio-controller;
 			#gpio-cells = <2>;
 			interrupt-controller;
-			#interrupt-cells = <1>;
+			#interrupt-cells = <2>;
 		};
 
 		gpio6: gpio at 49058000 {
@@ -162,7 +162,7 @@
 			gpio-controller;
 			#gpio-cells = <2>;
 			interrupt-controller;
-			#interrupt-cells = <1>;
+			#interrupt-cells = <2>;
 		};
 
 		uart1: serial at 4806a000 {
diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
index bcd64f5..bed47c5 100644
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -138,7 +138,7 @@
 			gpio-controller;
 			#gpio-cells = <2>;
 			interrupt-controller;
-			#interrupt-cells = <1>;
+			#interrupt-cells = <2>;
 		};
 
 		gpio2: gpio at 48055000 {
@@ -149,7 +149,7 @@
 			gpio-controller;
 			#gpio-cells = <2>;
 			interrupt-controller;
-			#interrupt-cells = <1>;
+			#interrupt-cells = <2>;
 		};
 
 		gpio3: gpio at 48057000 {
@@ -160,7 +160,7 @@
 			gpio-controller;
 			#gpio-cells = <2>;
 			interrupt-controller;
-			#interrupt-cells = <1>;
+			#interrupt-cells = <2>;
 		};
 
 		gpio4: gpio at 48059000 {
@@ -171,7 +171,7 @@
 			gpio-controller;
 			#gpio-cells = <2>;
 			interrupt-controller;
-			#interrupt-cells = <1>;
+			#interrupt-cells = <2>;
 		};
 
 		gpio5: gpio at 4805b000 {
@@ -182,7 +182,7 @@
 			gpio-controller;
 			#gpio-cells = <2>;
 			interrupt-controller;
-			#interrupt-cells = <1>;
+			#interrupt-cells = <2>;
 		};
 
 		gpio6: gpio at 4805d000 {
@@ -193,7 +193,7 @@
 			gpio-controller;
 			#gpio-cells = <2>;
 			interrupt-controller;
-			#interrupt-cells = <1>;
+			#interrupt-cells = <2>;
 		};
 
 		gpmc: gpmc at 50000000 {
diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
index 61cbd1c..b4d2eb9 100644
--- a/arch/arm/boot/dts/omap5.dtsi
+++ b/arch/arm/boot/dts/omap5.dtsi
@@ -128,7 +128,7 @@
 			gpio-controller;
 			#gpio-cells = <2>;
 			interrupt-controller;
-			#interrupt-cells = <1>;
+			#interrupt-cells = <2>;
 		};
 
 		gpio2: gpio at 48055000 {
@@ -139,7 +139,7 @@
 			gpio-controller;
 			#gpio-cells = <2>;
 			interrupt-controller;
-			#interrupt-cells = <1>;
+			#interrupt-cells = <2>;
 		};
 
 		gpio3: gpio at 48057000 {
@@ -150,7 +150,7 @@
 			gpio-controller;
 			#gpio-cells = <2>;
 			interrupt-controller;
-			#interrupt-cells = <1>;
+			#interrupt-cells = <2>;
 		};
 
 		gpio4: gpio at 48059000 {
@@ -161,7 +161,7 @@
 			gpio-controller;
 			#gpio-cells = <2>;
 			interrupt-controller;
-			#interrupt-cells = <1>;
+			#interrupt-cells = <2>;
 		};
 
 		gpio5: gpio at 4805b000 {
@@ -172,7 +172,7 @@
 			gpio-controller;
 			#gpio-cells = <2>;
 			interrupt-controller;
-			#interrupt-cells = <1>;
+			#interrupt-cells = <2>;
 		};
 
 		gpio6: gpio at 4805d000 {
@@ -183,7 +183,7 @@
 			gpio-controller;
 			#gpio-cells = <2>;
 			interrupt-controller;
-			#interrupt-cells = <1>;
+			#interrupt-cells = <2>;
 		};
 
 		gpio7: gpio at 48051000 {
@@ -194,7 +194,7 @@
 			gpio-controller;
 			#gpio-cells = <2>;
 			interrupt-controller;
-			#interrupt-cells = <1>;
+			#interrupt-cells = <2>;
 		};
 
 		gpio8: gpio at 48053000 {
@@ -205,7 +205,7 @@
 			gpio-controller;
 			#gpio-cells = <2>;
 			interrupt-controller;
-			#interrupt-cells = <1>;
+			#interrupt-cells = <2>;
 		};
 
 		gpmc: gpmc at 50000000 {
-- 
1.7.10.4
