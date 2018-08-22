From: s.trumtrar@pengutronix.de (Steffen Trumtrar)
Date: Wed, 22 Aug 2018 10:41:09 +0200
Subject: [PATCH v2 1/2] ARM: dts: socfpga: Add fpga2hps and fpga2sdram bridges
Message-ID: <20180822084110.14969-1-s.trumtrar@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the remaining two bridges on the Cyclone-V SoCFPGA SoCs.

Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
---
Changes in v2:
  - set status to disabled, so there are no accidental users of the bridges

 arch/arm/boot/dts/socfpga.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/socfpga.dtsi
index b38f8c240558..11781f795de2 100644
--- a/arch/arm/boot/dts/socfpga.dtsi
+++ b/arch/arm/boot/dts/socfpga.dtsi
@@ -543,6 +543,20 @@
 			clocks = <&l4_main_clk>;
 		};
 
+		fpga_bridge2: fpga-bridge at ff600000 {
+			compatible = "altr,socfpga-fpga2hps-bridge";
+			reg = <0xff600000 0x100000>;
+			resets = <&rst FPGA2HPS_RESET>;
+			clocks = <&l4_main_clk>;
+			status = "disabled";
+		};
+
+		fpga_bridge3: fpga-bridge at ffc25080 {
+			compatible = "altr,socfpga-fpga2sdram-bridge";
+			reg = <0xffc25080 0x4>;
+			status = "disabled";
+		};
+
 		fpgamgr0: fpgamgr at ff706000 {
 			compatible = "altr,socfpga-fpga-mgr";
 			reg = <0xff706000 0x1000
-- 
2.11.0
