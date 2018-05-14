From: dinguyen@kernel.org (Dinh Nguyen)
Date: Mon, 14 May 2018 10:30:22 -0500
Subject: [PATCH] ARM: dts: socfpga: Fix NAND controller node compatible for
 Arria10
Message-ID: <20180514153022.1311-1-dinguyen@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The NAND compatible "denali,denal-nand-dt" property has never been used and
is obsolete. Remove it.

Cc: stable at vger.kernel.org
Fixes: f549af06e9b6("ARM: dts: socfpga: Add NAND device tree for Arria10")
Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
---
 arch/arm/boot/dts/socfpga_arria10.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/socfpga_arria10.dtsi b/arch/arm/boot/dts/socfpga_arria10.dtsi
index bead79e4b2aa..d8b1aa309f76 100644
--- a/arch/arm/boot/dts/socfpga_arria10.dtsi
+++ b/arch/arm/boot/dts/socfpga_arria10.dtsi
@@ -633,7 +633,7 @@
 		nand: nand at ffb90000 {
 			#address-cells = <1>;
 			#size-cells = <1>;
-			compatible = "denali,denali-nand-dt", "altr,socfpga-denali-nand";
+			compatible = "altr,socfpga-denali-nand";
 			reg = <0xffb90000 0x72000>,
 			      <0xffb80000 0x10000>;
 			reg-names = "nand_data", "denali_reg";
-- 
2.17.0.391.g1f1cddd
