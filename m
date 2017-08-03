From: michal.simek@xilinx.com (Michal Simek)
Date: Thu,  3 Aug 2017 13:36:49 +0200
Subject: [PATCH 3/5] arm64: zynqmp: Added clocks to DT for ep108
In-Reply-To: <cover.1501760202.git.michal.simek@xilinx.com>
References: <cover.1501760202.git.michal.simek@xilinx.com>
Message-ID: <49b8208079976bb46e67c0013540cc327afa3594.1501760202.git.michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: VNSL Durga <vnsl.durga.challa@xilinx.com>

Added clks for ep108 platform.

Signed-off-by: VNSL Durga <vnsldurg@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 arch/arm64/boot/dts/xilinx/zynqmp-ep108-clk.dtsi | 44 ++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-ep108-clk.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp-ep108-clk.dtsi
index c03bde79d7d8..31d25327cfb9 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-ep108-clk.dtsi
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-ep108-clk.dtsi
@@ -29,12 +29,56 @@
 		#clock-cells = <0>;
 		clock-frequency = <75000000>;
 	};
+
+	clk100: clk100 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <100000000>;
+	};
+
+	clk600: clk600 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <600000000>;
+	};
 };
 
 &can0 {
 	clocks = <&misc_clk &misc_clk>;
 };
 
+&fpd_dma_chan1 {
+	clocks = <&clk600>, <&clk100>;
+};
+
+&fpd_dma_chan2 {
+	clocks = <&clk600>, <&clk100>;
+};
+
+&fpd_dma_chan3 {
+	clocks = <&clk600>, <&clk100>;
+};
+
+&fpd_dma_chan4 {
+	clocks = <&clk600>, <&clk100>;
+};
+
+&fpd_dma_chan5 {
+	clocks = <&clk600>, <&clk100>;
+};
+
+&fpd_dma_chan6 {
+	clocks = <&clk600>, <&clk100>;
+};
+
+&fpd_dma_chan7 {
+	clocks = <&clk600>, <&clk100>;
+};
+
+&fpd_dma_chan8 {
+	clocks = <&clk600>, <&clk100>;
+};
+
 &gem0 {
 	clocks = <&misc_clk>, <&misc_clk>, <&misc_clk>;
 };
-- 
1.9.1
