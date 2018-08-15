From: s.trumtrar@pengutronix.de (Steffen Trumtrar)
Date: Wed, 15 Aug 2018 14:59:10 +0200
Subject: [PATCH] ARM: dts: socfpga: Add fpga2hps and fpga2sdram bridges
Message-ID: <20180815125910.24097-1-s.trumtrar@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the remaining two bridges on the Cyclone-V SoCFPGA SoCs.

Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
---
 arch/arm/boot/dts/socfpga.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/socfpga.dtsi
index b38f8c240558..e0fb76107f34 100644
--- a/arch/arm/boot/dts/socfpga.dtsi
+++ b/arch/arm/boot/dts/socfpga.dtsi
@@ -543,6 +543,18 @@
 			clocks = <&l4_main_clk>;
 		};
 
+		fpga_bridge2: fpga-bridge at ff600000 {
+			compatible = "altr,socfpga-fpga2hps-bridge";
+			reg = <0xff600000 0x100000>;
+			resets = <&rst FPGA2HPS_RESET>;
+			clocks = <&l4_main_clk>;
+		};
+
+		fpga_bridge3: fpga-bridge at ffc25080 {
+			compatible = "altr,socfpga-fpga2sdram-bridge";
+			reg = <0xffc25080 0x4>;
+		};
+
 		fpgamgr0: fpgamgr at ff706000 {
 			compatible = "altr,socfpga-fpga-mgr";
 			reg = <0xff706000 0x1000
-- 
2.11.0
