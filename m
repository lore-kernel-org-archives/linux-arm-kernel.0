From: wens@csie.org (Chen-Yu Tsai)
Date: Wed,  3 May 2017 11:09:29 +0800
Subject: [PATCH v2 8/8] ARM: sun8i: a83t: Switch to CCU device tree binding
 macros
In-Reply-To: <20170503030929.28763-1-wens@csie.org>
References: <20170503030929.28763-1-wens@csie.org>
Message-ID: <20170503030929.28763-9-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that the CCU device tree binding headers have been merged, we can
use the properly named macros in the device tree, instead of raw
numbers.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun8i-a83t.dtsi | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/sun8i-a83t.dtsi b/arch/arm/boot/dts/sun8i-a83t.dtsi
index e12dd7170b8f..050d3e347740 100644
--- a/arch/arm/boot/dts/sun8i-a83t.dtsi
+++ b/arch/arm/boot/dts/sun8i-a83t.dtsi
@@ -44,6 +44,9 @@
 
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 
+#include <dt-bindings/clock/sun8i-a83t-ccu.h>
+#include <dt-bindings/reset/sun8i-a83t-ccu.h>
+
 / {
 	interrupt-parent = <&gic>;
 	#address-cells = <1>;
@@ -178,7 +181,7 @@
 				     <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>;
 			reg = <0x01c20800 0x400>;
-			clocks = <&ccu 45>, <&osc24M>, <&osc16Md512>;
+			clocks = <&ccu CLK_BUS_PIO>, <&osc24M>, <&osc16Md512>;
 			clock-names = "apb", "hosc", "losc";
 			gpio-controller;
 			interrupt-controller;
@@ -225,8 +228,8 @@
 			interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>;
 			reg-shift = <2>;
 			reg-io-width = <4>;
-			clocks = <&ccu 53>;
-			resets = <&ccu 40>;
+			clocks = <&ccu CLK_BUS_UART0>;
+			resets = <&ccu RST_BUS_UART0>;
 			status = "disabled";
 		};
 
-- 
2.11.0
