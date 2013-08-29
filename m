From: soren.brinkmann@xilinx.com (Soren Brinkmann)
Date: Thu, 29 Aug 2013 10:53:10 -0700
Subject: [PATCH RFC 3/3] arm: dt: zynq: Mark TTC input clock as unstable
In-Reply-To: <1377798790-28927-1-git-send-email-soren.brinkmann@xilinx.com>
References: <1377798790-28927-1-git-send-email-soren.brinkmann@xilinx.com>
Message-ID: <1377798790-28927-4-git-send-email-soren.brinkmann@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Zynq the TTC's input clock is directly derived from the CPU clock.
I.e. the input clock is not constant but scales with the CPU frequency.

Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
---
 arch/arm/boot/dts/zynq-7000.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/zynq-7000.dtsi b/arch/arm/boot/dts/zynq-7000.dtsi
index 6f54a64..c4d4e59 100644
--- a/arch/arm/boot/dts/zynq-7000.dtsi
+++ b/arch/arm/boot/dts/zynq-7000.dtsi
@@ -97,6 +97,7 @@
 			interrupts = < 0 10 4 0 11 4 0 12 4 >;
 			compatible = "cdns,ttc";
 			clocks = <&clkc 6>;
+			input-clock-unstable;
 			reg = <0xF8001000 0x1000>;
 			clock-ranges;
 		};
@@ -107,6 +108,7 @@
 			compatible = "cdns,ttc";
 			clocks = <&clkc 6>;
 			reg = <0xF8002000 0x1000>;
+			input-clock-unstable;
 			clock-ranges;
 		};
 		scutimer: scutimer at f8f00600 {
-- 
1.8.4
