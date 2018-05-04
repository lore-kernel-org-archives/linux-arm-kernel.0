From: chris.packham@alliedtelesis.co.nz (Chris Packham)
Date: Fri,  4 May 2018 15:06:38 +1200
Subject: [PATCH 2/2] ARM: dts: armada-xp-98dx: Add NAND pinctrl information
In-Reply-To: <20180504030638.31521-1-chris.packham@alliedtelesis.co.nz>
References: <20180504030638.31521-1-chris.packham@alliedtelesis.co.nz>
Message-ID: <20180504030638.31521-2-chris.packham@alliedtelesis.co.nz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add pin control information for the NAND interface on the Armada
98DX3236 and variants.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
 arch/arm/boot/dts/armada-xp-98dx3236.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/armada-xp-98dx3236.dtsi b/arch/arm/boot/dts/armada-xp-98dx3236.dtsi
index 9a589abd0379..099dc2520082 100644
--- a/arch/arm/boot/dts/armada-xp-98dx3236.dtsi
+++ b/arch/arm/boot/dts/armada-xp-98dx3236.dtsi
@@ -312,6 +312,19 @@
 &pinctrl {
 	compatible = "marvell,98dx3236-pinctrl";
 
+	nand_pins: nand-pins {
+		marvell,pins = "mpp20", "mpp21", "mpp22",
+			       "mpp23", "mpp24", "mpp25",
+			       "mpp26", "mpp27", "mpp28",
+			       "mpp29", "mpp30";
+		marvell,function = "dev";
+	};
+
+	nand_rb: nand-rb {
+		marvell,pins = "mpp19";
+		marvell,function = "nand";
+	};
+
 	spi0_pins: spi0-pins {
 		marvell,pins = "mpp0", "mpp1",
 			       "mpp2", "mpp3";
-- 
2.17.0
