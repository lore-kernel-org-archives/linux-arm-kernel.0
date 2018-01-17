From: michal.simek@xilinx.com (Michal Simek)
Date: Wed, 17 Jan 2018 16:29:45 +0100
Subject: [PATCH 1/6] arm64: zynqmp: Use zynqmp specific compatible string for
 macb
In-Reply-To: <cover.1516202975.git.michal.simek@xilinx.com>
References: <cover.1516202975.git.michal.simek@xilinx.com>
Message-ID: <cbeb93b54ae16677901f1cb5f3063b65aeea5793.1516202975.git.michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch
"devicetree: Add compatible string for Zynq Ultrascale+ MPSoC"
(commit <988d6f07fc0a29e392035ba56e3bcfaf7b397d95>)
introduced specific compatible string for ZynqMP which should be used
first.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 arch/arm64/boot/dts/xilinx/zynqmp.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
index 7665fbddff28..0da98007753b 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
+++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
@@ -355,7 +355,7 @@
 		};
 
 		gem0: ethernet at ff0b0000 {
-			compatible = "cdns,gem";
+			compatible = "cdns,zynqmp-gem", "cdns,gem";
 			status = "disabled";
 			interrupt-parent = <&gic>;
 			interrupts = <0 57 4>, <0 57 4>;
@@ -366,7 +366,7 @@
 		};
 
 		gem1: ethernet at ff0c0000 {
-			compatible = "cdns,gem";
+			compatible = "cdns,zynqmp-gem", "cdns,gem";
 			status = "disabled";
 			interrupt-parent = <&gic>;
 			interrupts = <0 59 4>, <0 59 4>;
@@ -377,7 +377,7 @@
 		};
 
 		gem2: ethernet at ff0d0000 {
-			compatible = "cdns,gem";
+			compatible = "cdns,zynqmp-gem", "cdns,gem";
 			status = "disabled";
 			interrupt-parent = <&gic>;
 			interrupts = <0 61 4>, <0 61 4>;
@@ -388,7 +388,7 @@
 		};
 
 		gem3: ethernet at ff0e0000 {
-			compatible = "cdns,gem";
+			compatible = "cdns,zynqmp-gem", "cdns,gem";
 			status = "disabled";
 			interrupt-parent = <&gic>;
 			interrupts = <0 63 4>, <0 63 4>;
-- 
1.9.1
