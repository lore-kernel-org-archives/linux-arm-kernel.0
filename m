From: gregory.clement@bootlin.com (Gregory CLEMENT)
Date: Thu,  1 Mar 2018 14:18:19 +0100
Subject: [PATCH] ARM64: dts: marvell: armada-cp110: Add apb_pclk clock for the
 uart nodes
Message-ID: <20180301131819.10790-1-gregory.clement@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This extra clock is needed to access the registers of the UARTs used on
CP110 component of the Armada 7K/8K SoCs.

Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
---
 arch/arm64/boot/dts/marvell/armada-cp110.dtsi | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/marvell/armada-cp110.dtsi b/arch/arm64/boot/dts/marvell/armada-cp110.dtsi
index d3f422f8f086..355bb295e4d9 100644
--- a/arch/arm64/boot/dts/marvell/armada-cp110.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-cp110.dtsi
@@ -303,7 +303,9 @@
 			reg-shift = <2>;
 			interrupts = <ICU_GRP_NSR 122 IRQ_TYPE_LEVEL_HIGH>;
 			reg-io-width = <1>;
-			clocks = <&CP110_LABEL(clk) 1 21>;
+			clock-names = "baudclk", "apb_pclk";
+			clocks = <&CP110_LABEL(clk) 1 21>,
+				 <&CP110_LABEL(clk) 1 17>;
 			status = "disabled";
 		};
 
@@ -313,7 +315,9 @@
 			reg-shift = <2>;
 			interrupts = <ICU_GRP_NSR 123 IRQ_TYPE_LEVEL_HIGH>;
 			reg-io-width = <1>;
-			clocks = <&CP110_LABEL(clk) 1 21>;
+			clock-names = "baudclk", "apb_pclk";
+			clocks = <&CP110_LABEL(clk) 1 21>,
+				 <&CP110_LABEL(clk) 1 17>;
 			status = "disabled";
 		};
 
@@ -323,7 +327,9 @@
 			reg-shift = <2>;
 			interrupts = <ICU_GRP_NSR 124 IRQ_TYPE_LEVEL_HIGH>;
 			reg-io-width = <1>;
-			clocks = <&CP110_LABEL(clk) 1 21>;
+			clock-names = "baudclk", "apb_pclk";
+			clocks = <&CP110_LABEL(clk) 1 21>,
+				 <&CP110_LABEL(clk) 1 17>;
 			status = "disabled";
 		};
 
@@ -333,7 +339,9 @@
 			reg-shift = <2>;
 			interrupts = <ICU_GRP_NSR 125 IRQ_TYPE_LEVEL_HIGH>;
 			reg-io-width = <1>;
-			clocks = <&CP110_LABEL(clk) 1 21>;
+			clock-names = "baudclk", "apb_pclk";
+			clocks = <&CP110_LABEL(clk) 1 21>,
+				 <&CP110_LABEL(clk) 1 17>;
 			status = "disabled";
 		};
 
-- 
2.16.1
