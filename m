From: jagan@amarulasolutions.com (Jagan Teki)
Date: Fri, 18 May 2018 15:15:12 +0530
Subject: [PATCH v2 02/26] arm64: dts: allwinner: a64: Add DE2 CCU
In-Reply-To: <20180518094536.17201-1-jagan@amarulasolutions.com>
References: <20180518094536.17201-1-jagan@amarulasolutions.com>
Message-ID: <20180518094536.17201-3-jagan@amarulasolutions.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

DE2 CCU in Allwinner A64 has same like H5, so use the
similar dts details for A64 with fallback compatible.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v2:
- Add h5 compatible first since A64 came first.

 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
index 1b2ef28c42bd..26c2a9c44727 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -43,9 +43,11 @@
  */
 
 #include <dt-bindings/clock/sun50i-a64-ccu.h>
+#include <dt-bindings/clock/sun8i-de2.h>
 #include <dt-bindings/clock/sun8i-r-ccu.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/reset/sun50i-a64-ccu.h>
+#include <dt-bindings/reset/sun8i-de2.h>
 
 / {
 	interrupt-parent = <&gic>;
@@ -168,6 +170,19 @@
 		#size-cells = <1>;
 		ranges;
 
+		display_clocks: clock at 1000000 {
+			compatible = "allwinner,sun50i-h5-de2-clk",
+				     "allwinner,sun50i-a64-de2-clk";
+			reg = <0x01000000 0x100000>;
+			clocks = <&ccu CLK_DE>,
+				 <&ccu CLK_BUS_DE>;
+			clock-names = "mod",
+				      "bus";
+			resets = <&ccu RST_BUS_DE>;
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+		};
+
 		syscon: syscon at 1c00000 {
 			compatible = "allwinner,sun50i-a64-system-controller",
 				"syscon";
-- 
2.14.3
