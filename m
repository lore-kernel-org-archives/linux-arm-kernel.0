From: dinguyen@kernel.org (Dinh Nguyen)
Date: Mon,  9 Jul 2018 17:41:03 -0500
Subject: [PATCH 2/2] ARM: dts: socfpga: update NAND clocking for c5/a5
In-Reply-To: <1531176063-30140-1-git-send-email-dinguyen@kernel.org>
References: <1531176063-30140-1-git-send-email-dinguyen@kernel.org>
Message-ID: <1531176063-30140-2-git-send-email-dinguyen@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The nand_x_clk is derived from the nand_clk. Also, update the NAND dts property
with the correct clocks property.

Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
---
 arch/arm/boot/dts/socfpga.dtsi | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/socfpga.dtsi
index b38f8c2..ae432b9 100644
--- a/arch/arm/boot/dts/socfpga.dtsi
+++ b/arch/arm/boot/dts/socfpga.dtsi
@@ -486,7 +486,7 @@
 					nand_clk: nand_clk {
 						#clock-cells = <0>;
 						compatible = "altr,socfpga-gate-clk";
-						clocks = <&f2s_periph_ref_clk>, <&main_nand_sdmmc_clk>, <&per_nand_mmc_clk>;
+						clocks = <&nand_x_clk>;
 						clk-gate = <0xa0 10>;
 						fixed-divider = <4>;
 					};
@@ -754,7 +754,8 @@
 			reg-names = "nand_data", "denali_reg";
 			interrupts = <0x0 0x90 0x4>;
 			dma-mask = <0xffffffff>;
-			clocks = <&nand_x_clk>;
+			clocks = <&nand_clk>, <&nand_x_clk>;
+			clock-names = "nand", "nand_x";
 			status = "disabled";
 		};
 
-- 
2.7.4
