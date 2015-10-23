From: soren.brinkmann@xilinx.com (Soren Brinkmann)
Date: Fri, 23 Oct 2015 09:25:32 -0700
Subject: [PATCH 3/3] ARM64: zynqmp: DT: Add interrupt-controller property to
 GPIO
In-Reply-To: <1445617532-10228-1-git-send-email-soren.brinkmann@xilinx.com>
References: <1445617532-10228-1-git-send-email-soren.brinkmann@xilinx.com>
Message-ID: <1445617532-10228-3-git-send-email-soren.brinkmann@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

GPIO can be used as interrupt-controller. Add the missing properties to
the GPIO node.

Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
---
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
index 857eda5c7217..200fb588d0f5 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
+++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
@@ -133,6 +133,8 @@
 			clocks = <&misc_clk>;
 			interrupt-parent = <&gic>;
 			interrupts = <0 16 4>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
 			reg = <0x0 0xff0a0000 0x1000>;
 		};
 
-- 
2.6.2.3.ga463a5b
