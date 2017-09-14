From: o.rempel@pengutronix.de (Oleksij Rempel)
Date: Thu, 14 Sep 2017 08:49:40 +0200
Subject: [PATCH v1] ARM: dts: socfpga: fix nand compatible
Message-ID: <20170914064940.5639-1-o.rempel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

the compatible was changed with patch:
|commit a56609c4c3f34de76d905e39160511b3c53310ac
|Author: Masahiro Yamada <yamada.masahiro@socionext.com>
|Date:   Thu Mar 30 15:45:53 2017 +0900
|
| mtd: nand: denali_dt: enable HW_ECC_FIXUP for Altera SOCFPGA variant
|
| There are various customizable parameters, so several variants for
| this IP.  A generic compatible like "denali,denali-nand-dt" is
| useless.  Moreover, there are multiple things wrong with this string.
|  (Refer to Rob's comment [1])
|
| The "denali,denali-nand-dt" was added by Altera for the SOCFPGA port.
| Replace it with a more specific string "altr,socfpga-denali-nand".
| There are no users (in upstream) of the old compatible string.
|
| The Denali IP on SOCFPGA incorporates the hardware ECC fixup engine.
| So, this capability should be associated with the compatible.
|
| [1] https://lkml.org/lkml/2016/12/1/450

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 arch/arm/boot/dts/socfpga.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/socfpga.dtsi
index 7e24dc8e82d4..d697f5062624 100644
--- a/arch/arm/boot/dts/socfpga.dtsi
+++ b/arch/arm/boot/dts/socfpga.dtsi
@@ -744,7 +744,7 @@
 		nand0: nand at ff900000 {
 			#address-cells = <0x1>;
 			#size-cells = <0x1>;
-			compatible = "denali,denali-nand-dt";
+			compatible = "altr,socfpga-denali-nand";
 			reg = <0xff900000 0x100000>,
 			      <0xffb80000 0x10000>;
 			reg-names = "nand_data", "denali_reg";
-- 
2.11.0
