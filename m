From: michal.simek@xilinx.com (Michal Simek)
Date: Fri,  4 Aug 2017 15:45:31 +0200
Subject: [PATCH 2/3] arm64: zynqmp: dt: Add PM firmware node
In-Reply-To: <cover.1501854302.git.michal.simek@xilinx.com>
References: <cover.1501854302.git.michal.simek@xilinx.com>
Message-ID: <e6142b056ab007012dd5f92d668911c89b130428.1501854302.git.michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Soren Brinkmann <soren.brinkmann@xilinx.com>

Add node for the power management firmware.

Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 arch/arm64/boot/dts/xilinx/zynqmp.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
index 54dc28351c8c..cc612c178d60 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
+++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
@@ -63,6 +63,13 @@
 		method = "smc";
 	};
 
+	pmufw: firmware {
+		compatible = "xlnx,zynqmp-pm";
+		method = "smc";
+		interrupt-parent = <&gic>;
+		interrupts = <0 35 4>;
+	};
+
 	timer {
 		compatible = "arm,armv8-timer";
 		interrupt-parent = <&gic>;
-- 
1.9.1
