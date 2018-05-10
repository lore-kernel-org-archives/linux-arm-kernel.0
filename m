From: marex@denx.de (Marek Vasut)
Date: Thu, 10 May 2018 14:52:23 +0200
Subject: [PATCH] ARM: dts: socfpga: Fix NAND controller node compatible
Message-ID: <20180510125223.16056-1-marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The compatible string for the Denali NAND controller is incorrect,
fix it by replacing it with one matching the DT bindings and the
driver.

Signed-off-by: Marek Vasut <marex@denx.de>
Fixes: d837a80d19 ("ARM: dts: socfpga: add nand controller nodes")
Cc: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Cc: Dinh Nguyen <dinguyen@kernel.org>
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
2.16.2
