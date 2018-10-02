From: chris.packham@alliedtelesis.co.nz (Chris Packham)
Date: Wed,  3 Oct 2018 10:12:33 +1300
Subject: [PATCH] ARM: dts: auto-detect nand ECC properites for db-88f6820-amc
Message-ID: <20181002211233.20774-1-chris.packham@alliedtelesis.co.nz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This board has a Micron MT29F8G08ABACAWP chip which requires a ECC
strength of 8/512. Rather than hard coding any particular strength the
the nand controller auto-detect the ECC strength based on the ONFI data.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
 arch/arm/boot/dts/armada-385-db-88f6820-amc.dts | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/boot/dts/armada-385-db-88f6820-amc.dts b/arch/arm/boot/dts/armada-385-db-88f6820-amc.dts
index dc9ccce1d4a1..7881df3b28a0 100644
--- a/arch/arm/boot/dts/armada-385-db-88f6820-amc.dts
+++ b/arch/arm/boot/dts/armada-385-db-88f6820-amc.dts
@@ -99,8 +99,6 @@
 		label = "pxa3xx_nand-0";
 		nand-rb = <0>;
 		nand-on-flash-bbt;
-		nand-ecc-strength = <4>;
-		nand-ecc-step-size = <512>;
 
 		partitions {
 			compatible = "fixed-partitions";
-- 
2.19.0
