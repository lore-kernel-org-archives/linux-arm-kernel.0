From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 13 Mar 2014 12:37:23 +0100
Subject: [PATCH v3 2/2] ARM: sunxi: dt: Convert to the new i2c compatibles
In-Reply-To: <1394710643-3411-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1394710643-3411-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1394710643-3411-3-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Switch the device tree to the new compatibles introduced in the i2c drivers
to have a common pattern accross all Allwinner SoCs.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun4i-a10.dtsi  |  6 +++---
 arch/arm/boot/dts/sun5i-a10s.dtsi |  6 +++---
 arch/arm/boot/dts/sun5i-a13.dtsi  |  6 +++---
 arch/arm/boot/dts/sun7i-a20.dtsi  | 10 +++++-----
 4 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a10.dtsi
index 27dc6ee8d0d6..6d3e39b8bb29 100644
--- a/arch/arm/boot/dts/sun4i-a10.dtsi
+++ b/arch/arm/boot/dts/sun4i-a10.dtsi
@@ -641,7 +641,7 @@
 		};
 
 		i2c0: i2c at 01c2ac00 {
-			compatible = "allwinner,sun4i-i2c";
+			compatible = "allwinner,sun4i-a10-i2c";
 			reg = <0x01c2ac00 0x400>;
 			interrupts = <7>;
 			clocks = <&apb1_gates 0>;
@@ -650,7 +650,7 @@
 		};
 
 		i2c1: i2c at 01c2b000 {
-			compatible = "allwinner,sun4i-i2c";
+			compatible = "allwinner,sun4i-a10-i2c";
 			reg = <0x01c2b000 0x400>;
 			interrupts = <8>;
 			clocks = <&apb1_gates 1>;
@@ -659,7 +659,7 @@
 		};
 
 		i2c2: i2c at 01c2b400 {
-			compatible = "allwinner,sun4i-i2c";
+			compatible = "allwinner,sun4i-a10-i2c";
 			reg = <0x01c2b400 0x400>;
 			interrupts = <9>;
 			clocks = <&apb1_gates 2>;
diff --git a/arch/arm/boot/dts/sun5i-a10s.dtsi b/arch/arm/boot/dts/sun5i-a10s.dtsi
index f34e0d85c9be..4977f47aeab3 100644
--- a/arch/arm/boot/dts/sun5i-a10s.dtsi
+++ b/arch/arm/boot/dts/sun5i-a10s.dtsi
@@ -519,7 +519,7 @@
 		i2c0: i2c at 01c2ac00 {
 			#address-cells = <1>;
 			#size-cells = <0>;
-			compatible = "allwinner,sun4i-i2c";
+			compatible = "allwinner,sun4i-a10-i2c";
 			reg = <0x01c2ac00 0x400>;
 			interrupts = <7>;
 			clocks = <&apb1_gates 0>;
@@ -530,7 +530,7 @@
 		i2c1: i2c at 01c2b000 {
 			#address-cells = <1>;
 			#size-cells = <0>;
-			compatible = "allwinner,sun4i-i2c";
+			compatible = "allwinner,sun4i-a10-i2c";
 			reg = <0x01c2b000 0x400>;
 			interrupts = <8>;
 			clocks = <&apb1_gates 1>;
@@ -541,7 +541,7 @@
 		i2c2: i2c at 01c2b400 {
 			#address-cells = <1>;
 			#size-cells = <0>;
-			compatible = "allwinner,sun4i-i2c";
+			compatible = "allwinner,sun4i-a10-i2c";
 			reg = <0x01c2b400 0x400>;
 			interrupts = <9>;
 			clocks = <&apb1_gates 2>;
diff --git a/arch/arm/boot/dts/sun5i-a13.dtsi b/arch/arm/boot/dts/sun5i-a13.dtsi
index 0e9c239af689..7e0ef8374bbf 100644
--- a/arch/arm/boot/dts/sun5i-a13.dtsi
+++ b/arch/arm/boot/dts/sun5i-a13.dtsi
@@ -461,7 +461,7 @@
 		};
 
 		i2c0: i2c at 01c2ac00 {
-			compatible = "allwinner,sun4i-i2c";
+			compatible = "allwinner,sun4i-a10-i2c";
 			reg = <0x01c2ac00 0x400>;
 			interrupts = <7>;
 			clocks = <&apb1_gates 0>;
@@ -470,7 +470,7 @@
 		};
 
 		i2c1: i2c at 01c2b000 {
-			compatible = "allwinner,sun4i-i2c";
+			compatible = "allwinner,sun4i-a10-i2c";
 			reg = <0x01c2b000 0x400>;
 			interrupts = <8>;
 			clocks = <&apb1_gates 1>;
@@ -479,7 +479,7 @@
 		};
 
 		i2c2: i2c at 01c2b400 {
-			compatible = "allwinner,sun4i-i2c";
+			compatible = "allwinner,sun4i-a10-i2c";
 			reg = <0x01c2b400 0x400>;
 			interrupts = <9>;
 			clocks = <&apb1_gates 2>;
diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index 4cc2f5f2ecad..c1fd510fd2c4 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -762,7 +762,7 @@
 		};
 
 		i2c0: i2c at 01c2ac00 {
-			compatible = "allwinner,sun4i-i2c";
+			compatible = "allwinner,sun4i-a10-i2c";
 			reg = <0x01c2ac00 0x400>;
 			interrupts = <0 7 4>;
 			clocks = <&apb1_gates 0>;
@@ -771,7 +771,7 @@
 		};
 
 		i2c1: i2c at 01c2b000 {
-			compatible = "allwinner,sun4i-i2c";
+			compatible = "allwinner,sun4i-a10-i2c";
 			reg = <0x01c2b000 0x400>;
 			interrupts = <0 8 4>;
 			clocks = <&apb1_gates 1>;
@@ -780,7 +780,7 @@
 		};
 
 		i2c2: i2c at 01c2b400 {
-			compatible = "allwinner,sun4i-i2c";
+			compatible = "allwinner,sun4i-a10-i2c";
 			reg = <0x01c2b400 0x400>;
 			interrupts = <0 9 4>;
 			clocks = <&apb1_gates 2>;
@@ -789,7 +789,7 @@
 		};
 
 		i2c3: i2c at 01c2b800 {
-			compatible = "allwinner,sun4i-i2c";
+			compatible = "allwinner,sun4i-a10-i2c";
 			reg = <0x01c2b800 0x400>;
 			interrupts = <0 88 4>;
 			clocks = <&apb1_gates 3>;
@@ -798,7 +798,7 @@
 		};
 
 		i2c4: i2c at 01c2bc00 {
-			compatible = "allwinner,sun4i-i2c";
+			compatible = "allwinner,sun4i-a10-i2c";
 			reg = <0x01c2bc00 0x400>;
 			interrupts = <0 89 4>;
 			clocks = <&apb1_gates 15>;
-- 
1.9.0
