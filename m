From: michal.simek@xilinx.com (Michal Simek)
Date: Thu, 20 Jul 2017 14:17:04 +0200
Subject: [PATCH 05/10] arm64: zynqmp: Add CCI-400 node
In-Reply-To: <cover.1500552941.git.michal.simek@xilinx.com>
References: <cover.1500552941.git.michal.simek@xilinx.com>
Message-ID: <19ec9d940db70d38a90b8ca41566dd7de0ad14c4.1500552941.git.michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add CCI-400 node to DTSI.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 arch/arm64/boot/dts/xilinx/zynqmp.dtsi | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
index 3657fdbdb552..f3968737e613 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
+++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
@@ -170,6 +170,25 @@
 			rx-fifo-depth = <0x40>;
 		};
 
+		cci: cci at fd6e0000 {
+			compatible = "arm,cci-400";
+			reg = <0x0 0xfd6e0000 0x0 0x9000>;
+			ranges = <0x0 0x0 0xfd6e0000 0x10000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			pmu at 9000 {
+				compatible = "arm,cci-400-pmu,r1";
+				reg = <0x9000 0x5000>;
+				interrupt-parent = <&gic>;
+				interrupts = <0 123 4>,
+					     <0 123 4>,
+					     <0 123 4>,
+					     <0 123 4>,
+					     <0 123 4>;
+			};
+		};
+
 		gem0: ethernet at ff0b0000 {
 			compatible = "cdns,gem";
 			status = "disabled";
-- 
1.9.1
