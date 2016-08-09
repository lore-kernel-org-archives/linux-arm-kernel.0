From: michal.simek@xilinx.com (Michal Simek)
Date: Tue,  9 Aug 2016 15:38:16 +0200
Subject: [PATCH 1/2] ARM64: zynqmp: Add missing interrupt-parent to PMU node
Message-ID: <73e2ff39077d4593e92a1b484fbb586afcddb4bf.1470749892.git.michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ZynqMP is not using global interrupt-parent setting that's why
it has to be listed in every node separately. PMU node missed it and
this patch is adding it.

Reported-by: John Linn <John.Linn@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 arch/arm64/boot/dts/xilinx/zynqmp.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
index fbdd6ab98988..8ed4f42e781b 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
+++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
@@ -51,6 +51,7 @@
 
 	pmu {
 		compatible = "arm,armv8-pmuv3";
+		interrupt-parent = <&gic>;
 		interrupts = <0 143 4>,
 			     <0 144 4>,
 			     <0 145 4>,
-- 
1.9.1
