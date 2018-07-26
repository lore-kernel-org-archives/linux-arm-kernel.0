From: chris.packham@alliedtelesis.co.nz (Chris Packham)
Date: Thu, 26 Jul 2018 16:02:56 +1200
Subject: [PATCH 3/4] ARM: dts: mvebu: db-xc3-24g4: use new style nand binding
In-Reply-To: <20180726040257.22285-1-chris.packham@alliedtelesis.co.nz>
References: <20180726040257.22285-1-chris.packham@alliedtelesis.co.nz>
Message-ID: <20180726040257.22285-4-chris.packham@alliedtelesis.co.nz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update the nand flash binding to the new style.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
 arch/arm/boot/dts/armada-xp-db-xc3-24g4xg.dts | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/armada-xp-db-xc3-24g4xg.dts b/arch/arm/boot/dts/armada-xp-db-xc3-24g4xg.dts
index d58ea48cb151..df048050615f 100644
--- a/arch/arm/boot/dts/armada-xp-db-xc3-24g4xg.dts
+++ b/arch/arm/boot/dts/armada-xp-db-xc3-24g4xg.dts
@@ -69,12 +69,16 @@
 
 &nand_controller {
 	status = "okay";
-	label = "pxa3xx_nand-0";
-	num-cs = <1>;
-	marvell,nand-keep-config;
-	nand-on-flash-bbt;
-	nand-ecc-strength = <4>;
-	nand-ecc-step-size = <512>;
+
+	nand at 0 {
+		reg = <0>;
+		label = "pxa3xx_nand-0";
+		nand-rb = <0>;
+		marvell,nand-keep-config;
+		nand-on-flash-bbt;
+		nand-ecc-strength = <4>;
+		nand-ecc-step-size = <512>;
+	};
 };
 
 &spi0 {
-- 
2.18.0
