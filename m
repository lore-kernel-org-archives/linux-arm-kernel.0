From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 13 Dec 2013 11:30:37 +0900
Subject: [PATCH 3/3] ARM: shmobile: r8a7790: Fix GPIO resources in DTS
In-Reply-To: <cover.1386899269.git.horms+renesas@verge.net.au>
References: <cover.1386899269.git.horms+renesas@verge.net.au>
Message-ID: <23de2278ebc3a2f971ce45ca5e5e35c9d5a74040.1386899269.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

The r8a7790 GPIO resources are currently incorrect. Fix that
by making them match the English r8a7790 v0.6 data sheet.

Tested with GPIO LED using Lager DT reference.

This problem has been present since GPIOs were added to the r8a7790 SoC by
f98e10c88aa95bf7 ("ARM: shmobile: r8a7790: Add GPIO controller devices to
device tree") in v3.12-rc1.

Signed-off-by: Magnus Damm <damm@opensource.se>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7790.dtsi | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index ee845fa..46e1d7e 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -87,9 +87,9 @@
 		interrupts = <1 9 0xf04>;
 	};
 
-	gpio0: gpio at ffc40000 {
+	gpio0: gpio at e6050000 {
 		compatible = "renesas,gpio-r8a7790", "renesas,gpio-rcar";
-		reg = <0 0xffc40000 0 0x2c>;
+		reg = <0 0xe6050000 0 0x50>;
 		interrupt-parent = <&gic>;
 		interrupts = <0 4 0x4>;
 		#gpio-cells = <2>;
@@ -99,9 +99,9 @@
 		interrupt-controller;
 	};
 
-	gpio1: gpio at ffc41000 {
+	gpio1: gpio at e6051000 {
 		compatible = "renesas,gpio-r8a7790", "renesas,gpio-rcar";
-		reg = <0 0xffc41000 0 0x2c>;
+		reg = <0 0xe6051000 0 0x50>;
 		interrupt-parent = <&gic>;
 		interrupts = <0 5 0x4>;
 		#gpio-cells = <2>;
@@ -111,9 +111,9 @@
 		interrupt-controller;
 	};
 
-	gpio2: gpio at ffc42000 {
+	gpio2: gpio at e6052000 {
 		compatible = "renesas,gpio-r8a7790", "renesas,gpio-rcar";
-		reg = <0 0xffc42000 0 0x2c>;
+		reg = <0 0xe6052000 0 0x50>;
 		interrupt-parent = <&gic>;
 		interrupts = <0 6 0x4>;
 		#gpio-cells = <2>;
@@ -123,9 +123,9 @@
 		interrupt-controller;
 	};
 
-	gpio3: gpio at ffc43000 {
+	gpio3: gpio at e6053000 {
 		compatible = "renesas,gpio-r8a7790", "renesas,gpio-rcar";
-		reg = <0 0xffc43000 0 0x2c>;
+		reg = <0 0xe6053000 0 0x50>;
 		interrupt-parent = <&gic>;
 		interrupts = <0 7 0x4>;
 		#gpio-cells = <2>;
@@ -135,9 +135,9 @@
 		interrupt-controller;
 	};
 
-	gpio4: gpio at ffc44000 {
+	gpio4: gpio at e6054000 {
 		compatible = "renesas,gpio-r8a7790", "renesas,gpio-rcar";
-		reg = <0 0xffc44000 0 0x2c>;
+		reg = <0 0xe6054000 0 0x50>;
 		interrupt-parent = <&gic>;
 		interrupts = <0 8 0x4>;
 		#gpio-cells = <2>;
@@ -147,9 +147,9 @@
 		interrupt-controller;
 	};
 
-	gpio5: gpio at ffc45000 {
+	gpio5: gpio at e6055000 {
 		compatible = "renesas,gpio-r8a7790", "renesas,gpio-rcar";
-		reg = <0 0xffc45000 0 0x2c>;
+		reg = <0 0xe6055000 0 0x50>;
 		interrupt-parent = <&gic>;
 		interrupts = <0 9 0x4>;
 		#gpio-cells = <2>;
-- 
1.8.4
