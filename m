From: soren.brinkmann@xilinx.com (Soren Brinkmann)
Date: Tue, 26 Nov 2013 17:04:48 -0800
Subject: [PATCH v2 1/9] arm: dt: zynq: Remove 'clock-ranges' from TTC nodes
In-Reply-To: <1385514296-26702-1-git-send-email-soren.brinkmann@xilinx.com>
References: <1385514296-26702-1-git-send-email-soren.brinkmann@xilinx.com>
Message-ID: <1385514296-26702-2-git-send-email-soren.brinkmann@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The bindings for the TTC changed in commit 'arm: zynq: Use standard
timer binding' (e932900a3279b5dbb6d8f43c7b369003620e137c). That change
removed possible subnodes from this driver rendering the 'clock-ranges'
property invalid for this node.

Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
Acked-by: Peter Crosthwaite <peter.crosthwaite@xilinx.com>
Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 arch/arm/boot/dts/zynq-7000.dtsi | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/boot/dts/zynq-7000.dtsi b/arch/arm/boot/dts/zynq-7000.dtsi
index e7f73b2e4550..605a2d0a39fc 100644
--- a/arch/arm/boot/dts/zynq-7000.dtsi
+++ b/arch/arm/boot/dts/zynq-7000.dtsi
@@ -106,7 +106,6 @@
 			compatible = "cdns,ttc";
 			clocks = <&clkc 6>;
 			reg = <0xF8001000 0x1000>;
-			clock-ranges;
 		};
 
 		ttc1: ttc1 at f8002000 {
@@ -115,7 +114,6 @@
 			compatible = "cdns,ttc";
 			clocks = <&clkc 6>;
 			reg = <0xF8002000 0x1000>;
-			clock-ranges;
 		};
 		scutimer: scutimer at f8f00600 {
 			interrupt-parent = <&intc>;
-- 
1.8.4.4
