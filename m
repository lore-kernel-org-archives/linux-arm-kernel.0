From: graham.moore@linux.intel.com (Graham Moore)
Date: Tue, 20 Feb 2018 09:38:47 -0600
Subject: [PATCH] arm64: dts: stratix10: Add PL330 DMAC to Stratix10 dts
Message-ID: <1519141127-22038-1-git-send-email-graham.moore@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Stratix10 SoCFPGA uses the PL330 DMAC.  This patch adds the PL330
DMAC to the Stratix10 device tree.

Signed-off-by: Graham Moore <graham.moore@linux.intel.com>
---
 arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi b/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
index aa4080d..0666c0f 100644
--- a/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
+++ b/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
@@ -711,6 +711,25 @@
 			reg = <0xffe00000 0x100000>;
 		};
 
+		pdma: pdma at ffda0000 {
+			compatible = "arm,pl330", "arm,primecell";
+			reg = <0xffda0000 0x1000>;
+			interrupts = <0 81 4>,
+				     <0 82 4>,
+				     <0 83 4>,
+				     <0 84 4>,
+				     <0 85 4>,
+				     <0 86 4>,
+				     <0 87 4>,
+				     <0 88 4>,
+				     <0 89 4>;
+			#dma-cells = <1>;
+			#dma-channels = <8>;
+			#dma-requests = <32>;
+			clocks = <&l4_main_clk>;
+			clock-names = "apb_pclk";
+		};
+
 		rst: rstmgr at ffd11000 {
 			#reset-cells = <1>;
 			compatible = "altr,rst-mgr";
-- 
2.7.4
