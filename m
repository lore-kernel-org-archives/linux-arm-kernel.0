From: chris.packham@alliedtelesis.co.nz (Chris Packham)
Date: Wed, 24 Aug 2016 11:21:15 +1200
Subject: [PATCH] ARM: dts: armada-38x: Add NAND pinctrl information
Message-ID: <20160823232115.23973-1-chris.packham@alliedtelesis.co.nz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add pin control information for the NAND flash interface. This interface
is multiplexed with the device bus interface to the function is "dev"
not "nand" as one might expect.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
 arch/arm/boot/dts/armada-38x.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/armada-38x.dtsi b/arch/arm/boot/dts/armada-38x.dtsi
index 3312be6c82cc..30381d421d43 100644
--- a/arch/arm/boot/dts/armada-38x.dtsi
+++ b/arch/arm/boot/dts/armada-38x.dtsi
@@ -287,6 +287,15 @@
 					marvell,function = "spi1";
 				};
 
+				nand_pins: nand-pins {
+					marvell,pins = "mpp22", "mpp34", "mpp23",
+						       "mpp33", "mpp38", "mpp28",
+						       "mpp40", "mpp42", "mpp35",
+						       "mpp36", "mpp25", "mpp30",
+						       "mpp32";
+					marvell,function = "dev";
+				};
+
 				uart0_pins: uart-pins-0 {
 					marvell,pins = "mpp0", "mpp1";
 					marvell,function = "ua0";
-- 
2.9.2.518.ged577c6.dirty
