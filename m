From: wens@csie.org (Chen-Yu Tsai)
Date: Mon,  5 Jun 2017 12:32:23 +0800
Subject: [PATCH 1/2] ARM: sunxi: h3-h5: Convert R_CCU raw numbers to macros
In-Reply-To: <20170605043224.20687-1-wens@csie.org>
References: <20170605043224.20687-1-wens@csie.org>
Message-ID: <20170605043224.20687-2-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that the R_CCU device tree binding headers have been merged, we
can convert the raw number references in the device trees to use the
defined macros.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sunxi-h3-h5.dtsi | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/sunxi-h3-h5.dtsi b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
index d4f600dbb7eb..e2f4e029d483 100644
--- a/arch/arm/boot/dts/sunxi-h3-h5.dtsi
+++ b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
@@ -41,8 +41,10 @@
  */
 
 #include <dt-bindings/clock/sun8i-h3-ccu.h>
+#include <dt-bindings/clock/sun8i-r-ccu.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/reset/sun8i-h3-ccu.h>
+#include <dt-bindings/reset/sun8i-r-ccu.h>
 
 / {
 	interrupt-parent = <&gic>;
@@ -574,9 +576,9 @@
 
 		ir: ir at 01f02000 {
 			compatible = "allwinner,sun5i-a13-ir";
-			clocks = <&r_ccu 4>, <&r_ccu 11>;
+			clocks = <&r_ccu CLK_APB0_IR>, <&r_ccu CLK_IR>;
 			clock-names = "apb", "ir";
-			resets = <&r_ccu 0>;
+			resets = <&r_ccu RST_IR>;
 			interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
 			reg = <0x01f02000 0x40>;
 			status = "disabled";
@@ -586,7 +588,7 @@
 			compatible = "allwinner,sun8i-h3-r-pinctrl";
 			reg = <0x01f02c00 0x400>;
 			interrupts = <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&r_ccu 3>, <&osc24M>, <&osc32k>;
+			clocks = <&r_ccu CLK_APB0_PIO>, <&osc24M>, <&osc32k>;
 			clock-names = "apb", "hosc", "losc";
 			gpio-controller;
 			#gpio-cells = <3>;
-- 
2.11.0
