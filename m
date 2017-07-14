From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 14 Jul 2017 14:42:52 +0800
Subject: [PATCH 01/11] ARM: dts: sun8i: a83t: Switch to CCU device tree
 binding macros
In-Reply-To: <20170714064302.20383-1-wens@csie.org>
References: <20170714064302.20383-1-wens@csie.org>
Message-ID: <20170714064302.20383-2-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that the CCU device tree binding headers have been merged, we can
use the properly named macros in the device tree, instead of raw
numbers.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---

This patch is included as it is a pre-requisite to the other device
tree changes in this series. It is however independent, and should
be applied as a fix for 4.13-rc, not for -next, and preferably sooner
than later.

---
 arch/arm/boot/dts/sun8i-a83t.dtsi | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/arch/arm/boot/dts/sun8i-a83t.dtsi b/arch/arm/boot/dts/sun8i-a83t.dtsi
index 21439d0aa55d..beed05e10a3b 100644
--- a/arch/arm/boot/dts/sun8i-a83t.dtsi
+++ b/arch/arm/boot/dts/sun8i-a83t.dtsi
@@ -44,7 +44,9 @@
 
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 
+#include <dt-bindings/clock/sun8i-a83t-ccu.h>
 #include <dt-bindings/clock/sun8i-r-ccu.h>
+#include <dt-bindings/reset/sun8i-a83t-ccu.h>
 
 / {
 	interrupt-parent = <&gic>;
@@ -175,8 +177,8 @@
 			compatible = "allwinner,sun8i-a83t-dma";
 			reg = <0x01c02000 0x1000>;
 			interrupts = <GIC_SPI 50 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&ccu 21>;
-			resets = <&ccu 7>;
+			clocks = <&ccu CLK_BUS_DMA>;
+			resets = <&ccu RST_BUS_DMA>;
 			#dma-cells = <1>;
 		};
 
@@ -195,7 +197,7 @@
 				     <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>;
 			reg = <0x01c20800 0x400>;
-			clocks = <&ccu 45>, <&osc24M>, <&osc16Md512>;
+			clocks = <&ccu CLK_BUS_PIO>, <&osc24M>, <&osc16Md512>;
 			clock-names = "apb", "hosc", "losc";
 			gpio-controller;
 			interrupt-controller;
@@ -247,8 +249,8 @@
 				     "allwinner,sun8i-h3-spdif";
 			reg = <0x01c21000 0x400>;
 			interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&ccu 44>, <&ccu 76>;
-			resets = <&ccu 32>;
+			clocks = <&ccu CLK_BUS_SPDIF>, <&ccu CLK_SPDIF>;
+			resets = <&ccu RST_BUS_SPDIF>;
 			clock-names = "apb", "spdif";
 			dmas = <&dma 2>;
 			dma-names = "tx";
@@ -263,8 +265,8 @@
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
2.13.2
