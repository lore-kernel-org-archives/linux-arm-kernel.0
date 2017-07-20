From: michal.simek@xilinx.com (Michal Simek)
Date: Thu, 20 Jul 2017 14:17:05 +0200
Subject: [PATCH 06/10] arm64: zynqmp: Adding prefetchable memory space to pcie
 node
In-Reply-To: <cover.1500552941.git.michal.simek@xilinx.com>
References: <cover.1500552941.git.michal.simek@xilinx.com>
Message-ID: <e349cb0bfd9aa8678485da6a92bb38ac9ae30c6f.1500552941.git.michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>

Adding prefetchable memory space to pcie device tree node.
Shifting configuration space to 64-bit address space.
Removing pcie device tree node from amba as it requires size-cells=<2>
in order to access 64-bit address space.

Signed-off-by: Bharat Kumar Gogada <bharatku@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 arch/arm64/boot/dts/xilinx/zynqmp.dtsi | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
index f3968737e613..e7d1815c114b 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
+++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
@@ -285,12 +285,8 @@
 			      <0x0 0xfd480000 0x0 0x1000>,
 			      <0x80 0x00000000 0x0 0x1000000>;
 			reg-names = "breg", "pcireg", "cfg";
-			ranges = <0x02000000 0x00000000 0xe0000000 0x00000000
-				  0xe0000000 0x00000000 0x10000000
-				  /* non-prefetchable memory */
-				  0x43000000 0x00000006 0x00000000 0x00000006
-				  0x00000000 0x00000002 0x00000000>;
-				  /* prefetchable memory */
+			ranges = <0x02000000 0x00000000 0xe0000000 0x00000000 0xe0000000 0x00000000 0x10000000	/* non-prefetchable memory */
+				  0x43000000 0x00000006 0x00000000 0x00000006 0x00000000 0x00000002 0x00000000>;/* prefetchable memory */
 			bus-range = <0x00 0xff>;
 			interrupt-map-mask = <0x0 0x0 0x0 0x7>;
 			interrupt-map = <0x0 0x0 0x0 0x1 &pcie_intc 0x1>,
-- 
1.9.1
