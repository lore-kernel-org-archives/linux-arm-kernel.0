From: dinguyen@opensource.altera.com (dinguyen at opensource.altera.com)
Date: Tue, 5 Jan 2016 15:22:05 -0600
Subject: [PATCH] ARM: dts: socfpga: add the clk-phase property for sd/mmc clock
Message-ID: <1452028925-8947-1-git-send-email-dinguyen@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dinh Nguyen <dinguyen@opensource.altera.com>

The CIU clock for the SD/MMC should be the sdmmc_clk and not the
sdmmc_free_clk. Also, add the correct phase shift the sdmmc_clk.

Signed-off-by: Dinh Nguyen <dinguyen@opensource.altera.com>
---
 arch/arm/boot/dts/socfpga_arria10.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/socfpga_arria10.dtsi b/arch/arm/boot/dts/socfpga_arria10.dtsi
index cce9e50..89a3558 100644
--- a/arch/arm/boot/dts/socfpga_arria10.dtsi
+++ b/arch/arm/boot/dts/socfpga_arria10.dtsi
@@ -362,6 +362,7 @@
 						compatible = "altr,socfpga-a10-gate-clk";
 						clocks = <&sdmmc_free_clk>;
 						clk-gate = <0xC8 5>;
+						clk-phase = <0 135>;
 					};
 
 					qspi_clk: qspi_clk {
@@ -589,7 +590,7 @@
 			reg = <0xff808000 0x1000>;
 			interrupts = <0 98 IRQ_TYPE_LEVEL_HIGH>;
 			fifo-depth = <0x400>;
-			clocks = <&l4_mp_clk>, <&sdmmc_free_clk>;
+			clocks = <&l4_mp_clk>, <&sdmmc_clk>;
 			clock-names = "biu", "ciu";
 			status = "disabled";
 		};
-- 
2.6.2
