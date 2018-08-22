From: s.trumtrar@pengutronix.de (Steffen Trumtrar)
Date: Wed, 22 Aug 2018 10:41:10 +0200
Subject: [PATCH v2 2/2] ARM: dts: socfgpa: set bridges status to disabled
In-Reply-To: <20180822084110.14969-1-s.trumtrar@pengutronix.de>
References: <20180822084110.14969-1-s.trumtrar@pengutronix.de>
Message-ID: <20180822084110.14969-2-s.trumtrar@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The hps-to-fpga bridges can't be used, when the FPGA is not programmed.
Set the default state to disabled and leave enabling them to the board-specific
dts files.
Although this changes behavior, there are no in-tree users of the bridges, so
this won't break anything.

Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
---
 arch/arm/boot/dts/socfpga.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/socfpga.dtsi
index 11781f795de2..d923adf897a1 100644
--- a/arch/arm/boot/dts/socfpga.dtsi
+++ b/arch/arm/boot/dts/socfpga.dtsi
@@ -534,6 +534,7 @@
 			reg = <0xff400000 0x100000>;
 			resets = <&rst LWHPS2FPGA_RESET>;
 			clocks = <&l4_main_clk>;
+			status = "disabled";
 		};
 
 		fpga_bridge1: fpga_bridge at ff500000 {
@@ -541,6 +542,7 @@
 			reg = <0xff500000 0x10000>;
 			resets = <&rst HPS2FPGA_RESET>;
 			clocks = <&l4_main_clk>;
+			status = "disabled";
 		};
 
 		fpga_bridge2: fpga-bridge at ff600000 {
-- 
2.11.0
