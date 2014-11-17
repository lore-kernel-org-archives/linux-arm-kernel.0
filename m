From: hdegoede@redhat.com (Hans de Goede)
Date: Mon, 17 Nov 2014 16:40:16 +0100
Subject: [PATCH] ARM: dts: sunxi: Update simplfb nodes so that u-boot can find
 them
Message-ID: <1416238816-29627-1-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Review of the u-boot sunxi simplefb patches has led to the decision that
u-boot should not use a specific path to find the nodes as this goes contrary
to how devicetree usually works.

Instead a platform specific compatible + properties should be used for this.

The simplefb bindings have already been updated to reflect this, this patch
brings the sunxi devicetree files in line with the new binding, and the
actual u-boot implementation as it is going upstream.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sun4i-a10.dtsi  | 5 +++--
 arch/arm/boot/dts/sun5i-a10s.dtsi | 5 +++--
 arch/arm/boot/dts/sun6i-a31.dtsi  | 5 +++--
 arch/arm/boot/dts/sun7i-a20.dtsi  | 5 +++--
 4 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a10.dtsi
index 92d8aa6..bbc366f 100644
--- a/arch/arm/boot/dts/sun4i-a10.dtsi
+++ b/arch/arm/boot/dts/sun4i-a10.dtsi
@@ -32,8 +32,9 @@
 		#size-cells = <1>;
 		ranges;
 
-		framebuffer0-hdmi {
-			compatible = "simple-framebuffer";
+		framebuffer at 0 {
+			compatible = "sunxi,framebuffer", "simple-framebuffer";
+			sunxi,pipeline = "de_be0-lcd0-hdmi";
 			clocks = <&pll5 1>, <&ahb_gates 36>, <&ahb_gates 43>,
 				 <&ahb_gates 44>;
 			status = "disabled";
diff --git a/arch/arm/boot/dts/sun5i-a10s.dtsi b/arch/arm/boot/dts/sun5i-a10s.dtsi
index c678e56..20509d7 100644
--- a/arch/arm/boot/dts/sun5i-a10s.dtsi
+++ b/arch/arm/boot/dts/sun5i-a10s.dtsi
@@ -29,8 +29,9 @@
 		#size-cells = <1>;
 		ranges;
 
-		framebuffer0-hdmi {
-			compatible = "simple-framebuffer";
+		framebuffer at 0 {
+			compatible = "sunxi,framebuffer", "simple-framebuffer";
+			sunxi,pipeline = "de_be0-lcd0-hdmi";
 			clocks = <&pll5 1>, <&ahb_gates 36>, <&ahb_gates 43>,
 				 <&ahb_gates 44>;
 			status = "disabled";
diff --git a/arch/arm/boot/dts/sun6i-a31.dtsi b/arch/arm/boot/dts/sun6i-a31.dtsi
index ccc03f3..3b1c735 100644
--- a/arch/arm/boot/dts/sun6i-a31.dtsi
+++ b/arch/arm/boot/dts/sun6i-a31.dtsi
@@ -67,8 +67,9 @@
 		#size-cells = <1>;
 		ranges;
 
-		framebuffer0-hdmi {
-			compatible = "simple-framebuffer";
+		framebuffer at 0 {
+			compatible = "sunxi,framebuffer", "simple-framebuffer";
+			sunxi,pipeline = "de_be0-lcd0-hdmi";
 			clocks = <&pll6>;
 			status = "disabled";
 		};
diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index 89766cb..0c9c216 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -69,8 +69,9 @@
 		#size-cells = <1>;
 		ranges;
 
-		framebuffer0-hdmi {
-			compatible = "simple-framebuffer";
+		framebuffer at 0 {
+			compatible = "sunxi,framebuffer", "simple-framebuffer";
+			sunxi,pipeline = "de_be0-lcd0-hdmi";
 			clocks = <&pll5 1>, <&ahb_gates 36>, <&ahb_gates 43>,
 				 <&ahb_gates 44>;
 			status = "disabled";
-- 
2.1.0
