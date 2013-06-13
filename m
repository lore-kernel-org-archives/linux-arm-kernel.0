From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 13 Jun 2013 14:59:53 -0600
Subject: [PATCH 1/7] ARM: mxc: fix gpio-ranges for VF610
Message-ID: <1371157199-7272-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

The gpio-ranges properties in vf610.dtsi were written according to an
older version of the GPIO bindings. Unfortunately, these were changed
incompatibly in commit 86853c8 "gpio: add gpio offset in gpio range
cells property". This patch adds the missing required extra cell in each
gpio-ranges property.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
This should be immediately applied to the tree which added vf610.dtsi.
---
 arch/arm/boot/dts/vf610.dtsi | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/vf610.dtsi b/arch/arm/boot/dts/vf610.dtsi
index 659d845..e1eb7da 100644
--- a/arch/arm/boot/dts/vf610.dtsi
+++ b/arch/arm/boot/dts/vf610.dtsi
@@ -162,7 +162,7 @@
 			iomuxc: iomuxc at 40048000 {
 				compatible = "fsl,vf610-iomuxc";
 				reg = <0x40048000 0x1000>;
-				#gpio-range-cells = <2>;
+				#gpio-range-cells = <3>;
 
 				/* functions and groups pins */
 
@@ -343,7 +343,7 @@
 				#gpio-cells = <2>;
 				interrupt-controller;
 				#interrupt-cells = <2>;
-				gpio-ranges = <&iomuxc 0 32>;
+				gpio-ranges = <&iomuxc 0 0 32>;
 			};
 
 			gpio2: gpio at 4004a000 {
@@ -354,7 +354,7 @@
 				#gpio-cells = <2>;
 				interrupt-controller;
 				#interrupt-cells = <2>;
-				gpio-ranges = <&iomuxc 32 32>;
+				gpio-ranges = <&iomuxc 0 32 32>;
 			};
 
 			gpio3: gpio at 4004b000 {
@@ -365,7 +365,7 @@
 				#gpio-cells = <2>;
 				interrupt-controller;
 				#interrupt-cells = <2>;
-				gpio-ranges = <&iomuxc 64 32>;
+				gpio-ranges = <&iomuxc 0 64 32>;
 			};
 
 			gpio4: gpio at 4004c000 {
@@ -376,7 +376,7 @@
 				#gpio-cells = <2>;
 				interrupt-controller;
 				#interrupt-cells = <2>;
-				gpio-ranges = <&iomuxc 96 32>;
+				gpio-ranges = <&iomuxc 0 96 32>;
 			};
 
 			gpio5: gpio at 4004d000 {
@@ -387,7 +387,7 @@
 				#gpio-cells = <2>;
 				interrupt-controller;
 				#interrupt-cells = <2>;
-				gpio-ranges = <&iomuxc 128 7>;
+				gpio-ranges = <&iomuxc 0 128 7>;
 			};
 
 			anatop at 40050000 {
-- 
1.8.1.5
