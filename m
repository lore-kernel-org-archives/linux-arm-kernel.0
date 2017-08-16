From: michal.simek@xilinx.com (Michal Simek)
Date: Wed, 16 Aug 2017 14:24:57 +0200
Subject: [PATCHv2 2/3] arm64: zynqmp: dt: Add PM firmware node
In-Reply-To: <cover.1502886277.git.michal.simek@xilinx.com>
References: <cover.1502886277.git.michal.simek@xilinx.com>
Message-ID: <b591c913ab9a1479c0ee4f7b546bb4808e7a51fa.1502886277.git.michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Soren Brinkmann <soren.brinkmann@xilinx.com>

Add node for the firmware interface.

Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

Changes in v2:
- Add zynqmp firmware node to firmware node
- Change commit message

 arch/arm64/boot/dts/xilinx/zynqmp.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
index 54dc28351c8c..41c0034fd905 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
+++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
@@ -49,6 +49,15 @@
 		};
 	};
 
+	firmware {
+		zynqmp-firmware {
+			compatible = "xlnx,zynqmp-pm";
+			method = "smc";
+			interrupt-parent = <&gic>;
+			interrupts = <0 35 4>;
+		};
+	};
+
 	pmu {
 		compatible = "arm,armv8-pmuv3";
 		interrupt-parent = <&gic>;
-- 
1.9.1
