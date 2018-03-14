From: gregory.clement@bootlin.com (Gregory CLEMENT)
Date: Wed, 14 Mar 2018 17:19:27 +0100
Subject: [PATCH 5/6] ARM64: dts: marvell: armada-cp110: Add registers clock
 for the NAND node
In-Reply-To: <20180314161928.7239-1-gregory.clement@bootlin.com>
References: <20180314161928.7239-1-gregory.clement@bootlin.com>
Message-ID: <20180314161928.7239-6-gregory.clement@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This extra clock is needed to access the registers of the NAND controller
used on CP110 component of the Armada 7K/8K SoCs.

This follow the changes already made in the binding documentation (as
well as in the driver): "mtd: nand: marvell: Fix clock resource by adding
a register clock"

Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
---
 arch/arm64/boot/dts/marvell/armada-cp110.dtsi | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/marvell/armada-cp110.dtsi b/arch/arm64/boot/dts/marvell/armada-cp110.dtsi
index b6947fcb8ce6..9ffb86b9441e 100644
--- a/arch/arm64/boot/dts/marvell/armada-cp110.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-cp110.dtsi
@@ -365,7 +365,9 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 			interrupts = <ICU_GRP_NSR 115 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&CP110_LABEL(clk) 1 2>;
+			clock-names = "core", "reg";
+			clocks = <&CP110_LABEL(clk) 1 2>,
+				 <&CP110_LABEL(clk) 1 17>;
 			marvell,system-controller = <&CP110_LABEL(syscon0)>;
 			status = "disabled";
 		};
-- 
2.16.1
