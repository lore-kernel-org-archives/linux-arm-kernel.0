From: dinguyen@opensource.altera.com (dinguyen at opensource.altera.com)
Date: Fri, 10 Apr 2015 15:56:26 -0500
Subject: [PATCH] ARM: socfpga: dts: Add a ciu clock node for sdmmc
Message-ID: <1428699386-2622-1-git-send-email-dinguyen@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dinh Nguyen <dinguyen@opensource.altera.com>

The CIU(Card Interface Unit) clock is used by the dw_mmc IP to clock an SD
card. The ciu_clk is the sdmmc_clk passed through a fixed divider of 4. This patch
adds the ciu_clk node and makes the sdmmc_clk it's parent.

Signed-off-by: Dinh Nguyen <dinguyen@opensource.altera.com>
---
 arch/arm/boot/dts/socfpga.dtsi | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/socfpga.dtsi
index d9176e6..25418ee 100644
--- a/arch/arm/boot/dts/socfpga.dtsi
+++ b/arch/arm/boot/dts/socfpga.dtsi
@@ -451,6 +451,14 @@
 						clk-phase = <0 135>;
 					};
 
+					ciu_clk: ciu_clk {
+						#clock-cells = <0>;
+						compatible = "altr,socfpga-gate-clk";
+						clocks = <&sdmmc_clk>;
+						clk-gate = <0xa0 8>;
+						fixed-divider = <4>;
+					};
+
 					nand_x_clk: nand_x_clk {
 						#clock-cells = <0>;
 						compatible = "altr,socfpga-gate-clk";
@@ -635,7 +643,7 @@
 			fifo-depth = <0x400>;
 			#address-cells = <1>;
 			#size-cells = <0>;
-			clocks = <&l4_mp_clk>, <&sdmmc_clk>;
+			clocks = <&l4_mp_clk>, <&ciu_clk>;
 			clock-names = "biu", "ciu";
 		};
 
-- 
2.2.1
