From: michal.simek@xilinx.com (Michal Simek)
Date: Thu, 20 Jul 2017 14:17:03 +0200
Subject: [PATCH 04/10] arm64: zynqmp: Add dcc console for zynqmp
In-Reply-To: <cover.1500552941.git.michal.simek@xilinx.com>
References: <cover.1500552941.git.michal.simek@xilinx.com>
Message-ID: <af9ffc2a1a4894ae26077b8ea46382e6585c9931.1500552941.git.michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add debug console to dtsi to be able to enable it in
board dts file.
Keep in your mind that every core has separate dcc port in case you want
to run SMP kernel.
DCC is very helpful communication channel for debugging.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 arch/arm64/boot/dts/xilinx/zynqmp.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
index 50636e098724..3657fdbdb552 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
+++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
@@ -95,6 +95,11 @@
 		};
 	};
 
+	dcc: dcc {
+		compatible = "arm,dcc";
+		status = "disabled";
+	};
+
 	pmu {
 		compatible = "arm,armv8-pmuv3";
 		interrupt-parent = <&gic>;
-- 
1.9.1
