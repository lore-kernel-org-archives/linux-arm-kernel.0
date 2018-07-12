From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 13 Jul 2018 00:04:51 +0800
Subject: [PATCH v3 4/5] arm64: dts: allwinner: h6: Use macros for R_CCU clock
 and reset indices
In-Reply-To: <20180712160452.5516-1-wens@csie.org>
References: <20180712160452.5516-1-wens@csie.org>
Message-ID: <20180712160452.5516-5-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that the device tree binding headers for the R_CCU have been merged,
we can use the macros, instead of raw numbers.

Switch to R_CCU macros for clock and reset indices.

Reviewed-by: Icenowy Zheng <icenowy@aosc.io>
Tested-by: Icenowy Zheng <icenowy@aosc.io>
Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
index c72da8cd9ef5..37c2e11fca2e 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
@@ -5,7 +5,9 @@
 
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/clock/sun50i-h6-ccu.h>
+#include <dt-bindings/clock/sun50i-h6-r-ccu.h>
 #include <dt-bindings/reset/sun50i-h6-ccu.h>
+#include <dt-bindings/reset/sun50i-h6-r-ccu.h>
 
 / {
 	interrupt-parent = <&gic>;
@@ -198,7 +200,7 @@
 			reg = <0x07022000 0x400>;
 			interrupts = <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 111 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&r_ccu 2>, <&osc24M>, <&osc32k>;
+			clocks = <&r_ccu CLK_R_APB1>, <&osc24M>, <&osc32k>;
 			clock-names = "apb", "hosc", "losc";
 			gpio-controller;
 			#gpio-cells = <3>;
@@ -215,8 +217,8 @@
 			compatible = "allwinner,sun6i-a31-i2c";
 			reg = <0x07081400 0x400>;
 			interrupts = <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&r_ccu 8>;
-			resets = <&r_ccu 4>;
+			clocks = <&r_ccu CLK_R_APB2_I2C>;
+			resets = <&r_ccu RST_R_APB2_I2C>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&r_i2c_pins>;
 			status = "disabled";
-- 
2.18.0
