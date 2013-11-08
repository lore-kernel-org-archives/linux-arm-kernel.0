From: soren.brinkmann@xilinx.com (Soren Brinkmann)
Date: Fri,  8 Nov 2013 13:21:11 -0800
Subject: [PATCH 1/7] arm: dt: zynq: Remove 'clock-ranges' from TTC nodes
In-Reply-To: <1383945677-29674-1-git-send-email-soren.brinkmann@xilinx.com>
References: <1383945677-29674-1-git-send-email-soren.brinkmann@xilinx.com>
Message-ID: <1383945677-29674-2-git-send-email-soren.brinkmann@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The bindings for the TTC changed in commit 'arm: zynq: Use standard
timer binding' (e932900a3279b5dbb6d8f43c7b369003620e137c). That change
removed possible subnodes from this driver rendering the 'clock-ranges'
property invalid for this node.

Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
Acked-by: Peter Crosthwaite <peter.crosthwaite@xilinx.com>
---
 arch/arm/boot/dts/zynq-7000.dtsi | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/boot/dts/zynq-7000.dtsi b/arch/arm/boot/dts/zynq-7000.dtsi
index e32b92b949d2..27ebc1ba9671 100644
--- a/arch/arm/boot/dts/zynq-7000.dtsi
+++ b/arch/arm/boot/dts/zynq-7000.dtsi
@@ -98,7 +98,6 @@
 			compatible = "cdns,ttc";
 			clocks = <&clkc 6>;
 			reg = <0xF8001000 0x1000>;
-			clock-ranges;
 		};
 
 		ttc1: ttc1 at f8002000 {
@@ -107,7 +106,6 @@
 			compatible = "cdns,ttc";
 			clocks = <&clkc 6>;
 			reg = <0xF8002000 0x1000>;
-			clock-ranges;
 		};
 		scutimer: scutimer at f8f00600 {
 			interrupt-parent = <&intc>;
-- 
1.8.4.2
