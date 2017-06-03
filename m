From: wens@csie.org (Chen-Yu Tsai)
Date: Sat,  3 Jun 2017 22:44:27 +0800
Subject: [PATCH 3/3] ARM: sun8i: a83t: Add device node for R_PIO
In-Reply-To: <20170603144427.22855-1-wens@csie.org>
References: <20170603144427.22855-1-wens@csie.org>
Message-ID: <20170603144427.22855-4-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The A83T has 1 pingroup with 13 pins belonging to the R_PIO
or special pin controller.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun8i-a83t.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a83t.dtsi b/arch/arm/boot/dts/sun8i-a83t.dtsi
index 49aeb56970ba..bf63e3b77572 100644
--- a/arch/arm/boot/dts/sun8i-a83t.dtsi
+++ b/arch/arm/boot/dts/sun8i-a83t.dtsi
@@ -44,6 +44,8 @@
 
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 
+#include <dt-bindings/clock/sun8i-r-ccu.h>
+
 / {
 	interrupt-parent = <&gic>;
 	#address-cells = <1>;
@@ -280,5 +282,18 @@
 			#clock-cells = <1>;
 			#reset-cells = <1>;
 		};
+
+		r_pio: pinctrl at 1f02c00 {
+			compatible = "allwinner,sun8i-a83t-r-pinctrl";
+			reg = <0x01f02c00 0x400>;
+			interrupts = <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&r_ccu CLK_APB0_PIO>, <&osc24M>,
+				 <&osc16Md512>;
+			clock-names = "apb", "hosc", "losc";
+			gpio-controller;
+			#gpio-cells = <3>;
+			interrupt-controller;
+			#interrupt-cells = <3>;
+		};
 	};
 };
-- 
2.11.0
