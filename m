From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue, 30 Jan 2018 15:19:46 +0100
Subject: [PATCH v2] ARM64: dts: marvell: armada-cp110: Add registers clock for
 I2C nodes
Message-ID: <20180130141946.18890-1-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This extra clock is needed to access the registers of the I2C controller
used on the Armada 7K/8K SoCs.

This follows the changes already made in the binding documentation (as
well as in the driver) in:
commit 1534156e999735fe0befad958e1447600c0c20e7 ("i2c: mv64xxx: Fix clock
resource by adding an optional bus clock")

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
Changelog:

v1 -> v2
Add comment about the commit modifying the driver in the commit log


 arch/arm64/boot/dts/marvell/armada-cp110.dtsi | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/marvell/armada-cp110.dtsi b/arch/arm64/boot/dts/marvell/armada-cp110.dtsi
index 0ab921861a2f..c57bf6661622 100644
--- a/arch/arm64/boot/dts/marvell/armada-cp110.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-cp110.dtsi
@@ -280,7 +280,9 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 			interrupts = <ICU_GRP_NSR 120 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&CP110_LABEL(clk) 1 21>;
+			clock-names = "core", "reg";
+			clocks = <&CP110_LABEL(clk) 1 21>,
+				 <&CP110_LABEL(clk) 1 17>;
 			status = "disabled";
 		};
 
@@ -290,7 +292,9 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 			interrupts = <ICU_GRP_NSR 121 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&CP110_LABEL(clk) 1 21>;
+			clock-names = "core", "reg";
+			clocks = <&CP110_LABEL(clk) 1 21>,
+				 <&CP110_LABEL(clk) 1 17>;
 			status = "disabled";
 		};
 
-- 
2.15.1
