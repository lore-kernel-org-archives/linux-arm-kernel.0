From: michal.simek@xilinx.com (Michal Simek)
Date: Thu, 20 Jul 2017 14:08:58 +0200
Subject: [PATCH 2/2] arm64: zynqmp: Move nodes which have no reg property out
 of bus
In-Reply-To: <26db4d8bc7cbcf95d2a60366e36c839ab3b5d6d9.1500552534.git.michal.simek@xilinx.com>
References: <26db4d8bc7cbcf95d2a60366e36c839ab3b5d6d9.1500552534.git.michal.simek@xilinx.com>
Message-ID: <49c8ac13d264346e11a697c63d486ccf31a037ea.1500552534.git.michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Nodes without reg properties shouldn't be placed in amba node.
Move them out.

Warnings:
arch/arm64/boot/dts/xilinx/zynqmp-ep108.dtb: Warning (simple_bus_reg):
Node /amba/misc_clk missing or empty reg/ranges property
arch/arm64/boot/dts/xilinx/zynqmp-ep108.dtb: Warning (simple_bus_reg):
Node /amba/i2c_clk missing or empty reg/ranges property
arch/arm64/boot/dts/xilinx/zynqmp-ep108.dtb: Warning (simple_bus_reg):
Node /amba/sata_clk missing or empty reg/ranges property
arch/arm64/boot/dts/xilinx/zynqmp-ep108.dtb: Warning (simple_bus_reg):

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 arch/arm64/boot/dts/xilinx/zynqmp-ep108-clk.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-ep108-clk.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp-ep108-clk.dtsi
index cdc6a437dcc7..c03bde79d7d8 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-ep108-clk.dtsi
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-ep108-clk.dtsi
@@ -11,7 +11,7 @@
  * the License, or (at your option) any later version.
  */
 
-&amba {
+/ {
 	misc_clk: misc_clk {
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
-- 
1.9.1
