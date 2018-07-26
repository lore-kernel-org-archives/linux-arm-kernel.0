From: chris.packham@alliedtelesis.co.nz (Chris Packham)
Date: Thu, 26 Jul 2018 16:02:55 +1200
Subject: [PATCH 2/4] ARM: dts: mvebu: db-dxbc2: use new style nand binding
In-Reply-To: <20180726040257.22285-1-chris.packham@alliedtelesis.co.nz>
References: <20180726040257.22285-1-chris.packham@alliedtelesis.co.nz>
Message-ID: <20180726040257.22285-3-chris.packham@alliedtelesis.co.nz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update the nand flash binding to the new style.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
 arch/arm/boot/dts/armada-xp-db-dxbc2.dts | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/armada-xp-db-dxbc2.dts b/arch/arm/boot/dts/armada-xp-db-dxbc2.dts
index 944e0a9c9dac..8a3aa616bbd0 100644
--- a/arch/arm/boot/dts/armada-xp-db-dxbc2.dts
+++ b/arch/arm/boot/dts/armada-xp-db-dxbc2.dts
@@ -70,12 +70,16 @@
 
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
 
 &sdio {
-- 
2.18.0
