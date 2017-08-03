From: michal.simek@xilinx.com (Michal Simek)
Date: Thu,  3 Aug 2017 13:36:47 +0200
Subject: [PATCH 1/5] arm64: zynqmp: Add fpd/lpd dmas
In-Reply-To: <cover.1501760202.git.michal.simek@xilinx.com>
References: <cover.1501760202.git.michal.simek@xilinx.com>
Message-ID: <7ce85ef98662e158c7bf62c249e2dd1ab4bd5ba5.1501760202.git.michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Wire fpd and lpd dma channels to zynqmp.dtsi.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 arch/arm64/boot/dts/xilinx/zynqmp.dtsi | 165 +++++++++++++++++++++++++++++++++
 1 file changed, 165 insertions(+)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
index 787463796348..7665fbddff28 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
+++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
@@ -189,6 +189,171 @@
 			};
 		};
 
+		/* GDMA */
+		fpd_dma_chan1: dma at fd500000 {
+			status = "disabled";
+			compatible = "xlnx,zynqmp-dma-1.0";
+			reg = <0x0 0xfd500000 0x0 0x1000>;
+			interrupt-parent = <&gic>;
+			interrupts = <0 124 4>;
+			clock-names = "clk_main", "clk_apb";
+			xlnx,bus-width = <128>;
+		};
+
+		fpd_dma_chan2: dma at fd510000 {
+			status = "disabled";
+			compatible = "xlnx,zynqmp-dma-1.0";
+			reg = <0x0 0xfd510000 0x0 0x1000>;
+			interrupt-parent = <&gic>;
+			interrupts = <0 125 4>;
+			clock-names = "clk_main", "clk_apb";
+			xlnx,bus-width = <128>;
+		};
+
+		fpd_dma_chan3: dma at fd520000 {
+			status = "disabled";
+			compatible = "xlnx,zynqmp-dma-1.0";
+			reg = <0x0 0xfd520000 0x0 0x1000>;
+			interrupt-parent = <&gic>;
+			interrupts = <0 126 4>;
+			clock-names = "clk_main", "clk_apb";
+			xlnx,bus-width = <128>;
+		};
+
+		fpd_dma_chan4: dma at fd530000 {
+			status = "disabled";
+			compatible = "xlnx,zynqmp-dma-1.0";
+			reg = <0x0 0xfd530000 0x0 0x1000>;
+			interrupt-parent = <&gic>;
+			interrupts = <0 127 4>;
+			clock-names = "clk_main", "clk_apb";
+			xlnx,bus-width = <128>;
+		};
+
+		fpd_dma_chan5: dma at fd540000 {
+			status = "disabled";
+			compatible = "xlnx,zynqmp-dma-1.0";
+			reg = <0x0 0xfd540000 0x0 0x1000>;
+			interrupt-parent = <&gic>;
+			interrupts = <0 128 4>;
+			clock-names = "clk_main", "clk_apb";
+			xlnx,bus-width = <128>;
+		};
+
+		fpd_dma_chan6: dma at fd550000 {
+			status = "disabled";
+			compatible = "xlnx,zynqmp-dma-1.0";
+			reg = <0x0 0xfd550000 0x0 0x1000>;
+			interrupt-parent = <&gic>;
+			interrupts = <0 129 4>;
+			clock-names = "clk_main", "clk_apb";
+			xlnx,bus-width = <128>;
+		};
+
+		fpd_dma_chan7: dma at fd560000 {
+			status = "disabled";
+			compatible = "xlnx,zynqmp-dma-1.0";
+			reg = <0x0 0xfd560000 0x0 0x1000>;
+			interrupt-parent = <&gic>;
+			interrupts = <0 130 4>;
+			clock-names = "clk_main", "clk_apb";
+			xlnx,bus-width = <128>;
+		};
+
+		fpd_dma_chan8: dma at fd570000 {
+			status = "disabled";
+			compatible = "xlnx,zynqmp-dma-1.0";
+			reg = <0x0 0xfd570000 0x0 0x1000>;
+			interrupt-parent = <&gic>;
+			interrupts = <0 131 4>;
+			clock-names = "clk_main", "clk_apb";
+			xlnx,bus-width = <128>;
+		};
+
+		/* LPDDMA default allows only secured access. inorder to enable
+		 * These dma channels, Users should ensure that these dma
+		 * Channels are allowed for non secure access.
+		 */
+		lpd_dma_chan1: dma at ffa80000 {
+			status = "disabled";
+			compatible = "xlnx,zynqmp-dma-1.0";
+			reg = <0x0 0xffa80000 0x0 0x1000>;
+			interrupt-parent = <&gic>;
+			interrupts = <0 77 4>;
+			clock-names = "clk_main", "clk_apb";
+			xlnx,bus-width = <64>;
+		};
+
+		lpd_dma_chan2: dma at ffa90000 {
+			status = "disabled";
+			compatible = "xlnx,zynqmp-dma-1.0";
+			reg = <0x0 0xffa90000 0x0 0x1000>;
+			interrupt-parent = <&gic>;
+			interrupts = <0 78 4>;
+			clock-names = "clk_main", "clk_apb";
+			xlnx,bus-width = <64>;
+		};
+
+		lpd_dma_chan3: dma at ffaa0000 {
+			status = "disabled";
+			compatible = "xlnx,zynqmp-dma-1.0";
+			reg = <0x0 0xffaa0000 0x0 0x1000>;
+			interrupt-parent = <&gic>;
+			interrupts = <0 79 4>;
+			clock-names = "clk_main", "clk_apb";
+			xlnx,bus-width = <64>;
+		};
+
+		lpd_dma_chan4: dma at ffab0000 {
+			status = "disabled";
+			compatible = "xlnx,zynqmp-dma-1.0";
+			reg = <0x0 0xffab0000 0x0 0x1000>;
+			interrupt-parent = <&gic>;
+			interrupts = <0 80 4>;
+			clock-names = "clk_main", "clk_apb";
+			xlnx,bus-width = <64>;
+		};
+
+		lpd_dma_chan5: dma at ffac0000 {
+			status = "disabled";
+			compatible = "xlnx,zynqmp-dma-1.0";
+			reg = <0x0 0xffac0000 0x0 0x1000>;
+			interrupt-parent = <&gic>;
+			interrupts = <0 81 4>;
+			clock-names = "clk_main", "clk_apb";
+			xlnx,bus-width = <64>;
+		};
+
+		lpd_dma_chan6: dma at ffad0000 {
+			status = "disabled";
+			compatible = "xlnx,zynqmp-dma-1.0";
+			reg = <0x0 0xffad0000 0x0 0x1000>;
+			interrupt-parent = <&gic>;
+			interrupts = <0 82 4>;
+			clock-names = "clk_main", "clk_apb";
+			xlnx,bus-width = <64>;
+		};
+
+		lpd_dma_chan7: dma at ffae0000 {
+			status = "disabled";
+			compatible = "xlnx,zynqmp-dma-1.0";
+			reg = <0x0 0xffae0000 0x0 0x1000>;
+			interrupt-parent = <&gic>;
+			interrupts = <0 83 4>;
+			clock-names = "clk_main", "clk_apb";
+			xlnx,bus-width = <64>;
+		};
+
+		lpd_dma_chan8: dma at ffaf0000 {
+			status = "disabled";
+			compatible = "xlnx,zynqmp-dma-1.0";
+			reg = <0x0 0xffaf0000 0x0 0x1000>;
+			interrupt-parent = <&gic>;
+			interrupts = <0 84 4>;
+			clock-names = "clk_main", "clk_apb";
+			xlnx,bus-width = <64>;
+		};
+
 		gem0: ethernet at ff0b0000 {
 			compatible = "cdns,gem";
 			status = "disabled";
-- 
1.9.1
