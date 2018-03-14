From: gregory.clement@bootlin.com (Gregory CLEMENT)
Date: Wed, 14 Mar 2018 17:19:28 +0100
Subject: [PATCH 6/6] ARM64: dts: marvell: armada-cp110: Add registers clock
 for the PCIe nodes
In-Reply-To: <20180314161928.7239-1-gregory.clement@bootlin.com>
References: <20180314161928.7239-1-gregory.clement@bootlin.com>
Message-ID: <20180314161928.7239-7-gregory.clement@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This extra clock is needed to access the registers of the PCIe host
controller used on CP110 component of the Armada 7K/8K SoCs.

This follow the changes already made in the binding documentation (as
well as in the driver): "PCI: armada8k: Fix clock resource by adding
a register clock"

Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
---
 arch/arm64/boot/dts/marvell/armada-cp110.dtsi | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/marvell/armada-cp110.dtsi b/arch/arm64/boot/dts/marvell/armada-cp110.dtsi
index 9ffb86b9441e..48cad7919efa 100644
--- a/arch/arm64/boot/dts/marvell/armada-cp110.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-cp110.dtsi
@@ -433,7 +433,8 @@
 		interrupt-map = <0 0 0 0 &CP110_LABEL(icu) ICU_GRP_NSR 22 IRQ_TYPE_LEVEL_HIGH>;
 		interrupts = <ICU_GRP_NSR 22 IRQ_TYPE_LEVEL_HIGH>;
 		num-lanes = <1>;
-		clocks = <&CP110_LABEL(clk) 1 13>;
+		clock-names = "core", "reg";
+		clocks = <&CP110_LABEL(clk) 1 13>, <&CP110_LABEL(clk) 1 14>;
 		status = "disabled";
 	};
 
@@ -460,7 +461,8 @@
 		interrupts = <ICU_GRP_NSR 24 IRQ_TYPE_LEVEL_HIGH>;
 
 		num-lanes = <1>;
-		clocks = <&CP110_LABEL(clk) 1 11>;
+		clock-names = "core", "reg";
+		clocks = <&CP110_LABEL(clk) 1 11>, <&CP110_LABEL(clk) 1 14>;
 		status = "disabled";
 	};
 
@@ -487,7 +489,8 @@
 		interrupts = <ICU_GRP_NSR 23 IRQ_TYPE_LEVEL_HIGH>;
 
 		num-lanes = <1>;
-		clocks = <&CP110_LABEL(clk) 1 12>;
+		clock-names = "core", "reg";
+		clocks = <&CP110_LABEL(clk) 1 12>, <&CP110_LABEL(clk) 1 14>;
 		status = "disabled";
 	};
 };
-- 
2.16.1
