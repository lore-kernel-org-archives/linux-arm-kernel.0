From: icenowy@aosc.io (Icenowy Zheng)
Date: Mon, 19 Mar 2018 16:11:08 +0800
Subject: [PATCH 2/2] arm64: allwinner: h6: temporarily drop the usage of CCU
 headers in DTSI
In-Reply-To: <20180319081108.23496-1-icenowy@aosc.io>
References: <20180319081108.23496-1-icenowy@aosc.io>
Message-ID: <20180319081108.23496-2-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As the CCU driver will be merged in different tree with the device tree,
temporarily drop the usage of CCU headers in the DTSI file, and replace
macros with the corresponding numbers.

After they are both merged into Linus' tree, it can be switched back to
use the CCU headers.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
index 4debc3962830..56563150d61a 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
@@ -4,8 +4,6 @@
  */
 
 #include <dt-bindings/interrupt-controller/arm-gic.h>
-#include <dt-bindings/clock/sun50i-h6-ccu.h>
-#include <dt-bindings/reset/sun50i-h6-ccu.h>
 
 / {
 	interrupt-parent = <&gic>;
@@ -117,7 +115,7 @@
 				     <GIC_SPI 53 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 54 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 59 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&ccu CLK_APB1>, <&osc24M>, <&osc32k>;
+			clocks = <&ccu 26>, <&osc24M>, <&osc32k>;
 			clock-names = "apb", "hosc", "losc";
 			gpio-controller;
 			#gpio-cells = <3>;
@@ -136,8 +134,8 @@
 			interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>;
 			reg-shift = <2>;
 			reg-io-width = <4>;
-			clocks = <&ccu CLK_BUS_UART0>;
-			resets = <&ccu RST_BUS_UART0>;
+			clocks = <&ccu 70>;
+			resets = <&ccu 21>;
 			status = "disabled";
 		};
 
@@ -147,8 +145,8 @@
 			interrupts = <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>;
 			reg-shift = <2>;
 			reg-io-width = <4>;
-			clocks = <&ccu CLK_BUS_UART1>;
-			resets = <&ccu RST_BUS_UART1>;
+			clocks = <&ccu 71>;
+			resets = <&ccu 22>;
 			status = "disabled";
 		};
 
@@ -158,8 +156,8 @@
 			interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>;
 			reg-shift = <2>;
 			reg-io-width = <4>;
-			clocks = <&ccu CLK_BUS_UART2>;
-			resets = <&ccu RST_BUS_UART2>;
+			clocks = <&ccu 72>;
+			resets = <&ccu 23>;
 			status = "disabled";
 		};
 
@@ -169,8 +167,8 @@
 			interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>;
 			reg-shift = <2>;
 			reg-io-width = <4>;
-			clocks = <&ccu CLK_BUS_UART3>;
-			resets = <&ccu RST_BUS_UART3>;
+			clocks = <&ccu 73>;
+			resets = <&ccu 24>;
 			status = "disabled";
 		};
 	};
-- 
2.15.1
