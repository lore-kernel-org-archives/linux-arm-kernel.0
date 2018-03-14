From: gregory.clement@bootlin.com (Gregory CLEMENT)
Date: Wed, 14 Mar 2018 17:19:23 +0100
Subject: [PATCH 1/6] ARM64: dts: marvell: armada-cp110: Add registers clock
 for USB host nodes
In-Reply-To: <20180314161928.7239-1-gregory.clement@bootlin.com>
References: <20180314161928.7239-1-gregory.clement@bootlin.com>
Message-ID: <20180314161928.7239-2-gregory.clement@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This extra clock is needed to access the registers of the USB host
controller used on Armada 7K/8K SoCs.

This follow the changes already made in the binding documentation (as
well as in the driver): "usb: host: xhci-plat: Fix clock resource by
adding a register clock"

Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
---
 arch/arm64/boot/dts/marvell/armada-cp110.dtsi | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/marvell/armada-cp110.dtsi b/arch/arm64/boot/dts/marvell/armada-cp110.dtsi
index 355bb295e4d9..c35368d2a4cd 100644
--- a/arch/arm64/boot/dts/marvell/armada-cp110.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-cp110.dtsi
@@ -211,7 +211,9 @@
 			reg = <0x500000 0x4000>;
 			dma-coherent;
 			interrupts = <ICU_GRP_NSR 106 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&CP110_LABEL(clk) 1 22>;
+			clock-names = "core", "reg";
+			clocks = <&CP110_LABEL(clk) 1 22>,
+				 <&CP110_LABEL(clk) 1 16>;
 			status = "disabled";
 		};
 
@@ -221,7 +223,9 @@
 			reg = <0x510000 0x4000>;
 			dma-coherent;
 			interrupts = <ICU_GRP_NSR 105 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&CP110_LABEL(clk) 1 23>;
+			clock-names = "core", "reg";
+			clocks = <&CP110_LABEL(clk) 1 23>,
+				 <&CP110_LABEL(clk) 1 16>;
 			status = "disabled";
 		};
 
-- 
2.16.1
