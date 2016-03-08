From: grmoore@opensource.altera.com (Graham Moore)
Date: Tue, 8 Mar 2016 11:02:50 -0600
Subject: [PATCH] ARM: socfpga: dts: Add missing clock and interrupt fields for
 Arria10 DMA
Message-ID: <1457456571-25541-1-git-send-email-grmoore@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The PL330 DMA driver will not load on Arria10 without devicetree entries
for clocks and clock_names.  This patch adds those entries.  It also adds
the ninth interrupt, which is required for error detection.

Signed-off-by: Graham Moore <grmoore@opensource.altera.com>
---
 arch/arm/boot/dts/socfpga_arria10.dtsi | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/socfpga_arria10.dtsi b/arch/arm/boot/dts/socfpga_arria10.dtsi
index cce9e50..45a4728 100644
--- a/arch/arm/boot/dts/socfpga_arria10.dtsi
+++ b/arch/arm/boot/dts/socfpga_arria10.dtsi
@@ -78,10 +78,13 @@
 					     <0 87 IRQ_TYPE_LEVEL_HIGH>,
 					     <0 88 IRQ_TYPE_LEVEL_HIGH>,
 					     <0 89 IRQ_TYPE_LEVEL_HIGH>,
-					     <0 90 IRQ_TYPE_LEVEL_HIGH>;
+					     <0 90 IRQ_TYPE_LEVEL_HIGH>,
+					     <0 91 IRQ_TYPE_LEVEL_HIGH>;
 				#dma-cells = <1>;
 				#dma-channels = <8>;
 				#dma-requests = <32>;
+				clocks = <&l4_main_clk>;
+				clock-names = "apb_pclk";
 			};
 		};
 
-- 
2.5.0
