From: chunyan.zhang@spreadtrum.com (Chunyan Zhang)
Date: Tue, 11 Jul 2017 18:56:27 +0800
Subject: [PATCH V2 10/10] arm64: dts: add clocks for SC9860
In-Reply-To: <20170711105627.20526-1-chunyan.zhang@spreadtrum.com>
References: <20170711105627.20526-1-chunyan.zhang@spreadtrum.com>
Message-ID: <20170711105627.20526-11-chunyan.zhang@spreadtrum.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now we have clock driver, so add clock devicetree data for SC9860.

Signed-off-by: Chunyan Zhang <chunyan.zhang@spreadtrum.com>
---
 arch/arm64/boot/dts/sprd/sc9860.dtsi | 22 ++++++++++++++++++++++
 arch/arm64/boot/dts/sprd/whale2.dtsi |  3 +--
 2 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/sprd/sc9860.dtsi b/arch/arm64/boot/dts/sprd/sc9860.dtsi
index 7b7d8ce..8d3f549 100644
--- a/arch/arm64/boot/dts/sprd/sc9860.dtsi
+++ b/arch/arm64/boot/dts/sprd/sc9860.dtsi
@@ -7,6 +7,7 @@
  */
 
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/clock/sprd,sc9860-clk.h>
 #include "whale2.dtsi"
 
 / {
@@ -183,6 +184,27 @@
 	};
 
 	soc {
+		clk: clk {
+			compatible = "sprd,sc9860-clk";
+			#clock-cells = <1>;
+			reg = <0 0x20000000 0 0x400>,
+			      <0 0x20210000 0 0x3000>,
+			      <0 0x402b0000 0 0x4000>,
+			      <0 0x402d0000 0 0x400>,
+			      <0 0x402e0000 0 0x4000>,
+			      <0 0x40400000 0 0x400>,
+			      <0 0x40880000 0 0x400>,
+			      <0 0x415e0000 0 0x400>,
+			      <0 0x60200000 0 0x400>,
+			      <0 0x61000000 0 0x400>,
+			      <0 0x61100000 0 0x3000>,
+			      <0 0x62000000 0 0x4000>,
+			      <0 0x62100000 0 0x4000>,
+			      <0 0x63000000 0 0x400>,
+			      <0 0x63100000 0 0x3000>,
+			      <0 0x70b00000 0 0x3000>;
+		};
+
 		funnel at 10001000 { /* SoC Funnel */
 			compatible = "arm,coresight-funnel", "arm,primecell";
 			reg = <0 0x10001000 0 0x1000>;
diff --git a/arch/arm64/boot/dts/sprd/whale2.dtsi b/arch/arm64/boot/dts/sprd/whale2.dtsi
index 7c217c5..a4f376e 100644
--- a/arch/arm64/boot/dts/sprd/whale2.dtsi
+++ b/arch/arm64/boot/dts/sprd/whale2.dtsi
@@ -59,13 +59,12 @@
 				status = "disabled";
 			};
 		};
-
 	};
 
 	ext_26m: ext-26m {
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
 		clock-frequency = <26000000>;
-		clock-output-names = "ext_26m";
+		clock-output-names = "ext-26m";
 	};
 };
-- 
2.7.4
