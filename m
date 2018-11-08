From: dinguyen@kernel.org (Dinh Nguyen)
Date: Thu,  8 Nov 2018 10:22:26 -0600
Subject: [PATCH] arm: dts: socfpga: remove dma-mask property
Message-ID: <20181108162226.5648-1-dinguyen@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The dma-mask property has been removed from the NAND driver. Remove the
property from the DTS files.

Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
---
 arch/arm/boot/dts/socfpga.dtsi         | 1 -
 arch/arm/boot/dts/socfpga_arria10.dtsi | 1 -
 2 files changed, 2 deletions(-)

diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/socfpga.dtsi
index 77dbb3cda496..c25dede54398 100644
--- a/arch/arm/boot/dts/socfpga.dtsi
+++ b/arch/arm/boot/dts/socfpga.dtsi
@@ -753,7 +753,6 @@
 			      <0xffb80000 0x10000>;
 			reg-names = "nand_data", "denali_reg";
 			interrupts = <0x0 0x90 0x4>;
-			dma-mask = <0xffffffff>;
 			clocks = <&nand_clk>, <&nand_x_clk>, <&nand_ecc_clk>;
 			clock-names = "nand", "nand_x", "ecc";
 			status = "disabled";
diff --git a/arch/arm/boot/dts/socfpga_arria10.dtsi b/arch/arm/boot/dts/socfpga_arria10.dtsi
index 0b1ab88b4039..e41fa23481c3 100644
--- a/arch/arm/boot/dts/socfpga_arria10.dtsi
+++ b/arch/arm/boot/dts/socfpga_arria10.dtsi
@@ -653,7 +653,6 @@
 			      <0xffb80000 0x10000>;
 			reg-names = "nand_data", "denali_reg";
 			interrupts = <0 99 4>;
-			dma-mask = <0xffffffff>;
 			clocks = <&nand_clk>, <&nand_x_clk>, <&nand_ecc_clk>;
 			clock-names = "nand", "nand_x", "ecc";
 			status = "disabled";
-- 
2.17.1
