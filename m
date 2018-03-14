From: gregory.clement@bootlin.com (Gregory CLEMENT)
Date: Wed, 14 Mar 2018 17:19:26 +0100
Subject: [PATCH 4/6] ARM64: dts: marvell: armada-cp110: Add registers clock
 for the crypto node
In-Reply-To: <20180314161928.7239-1-gregory.clement@bootlin.com>
References: <20180314161928.7239-1-gregory.clement@bootlin.com>
Message-ID: <20180314161928.7239-5-gregory.clement@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This extra clock is needed to access the registers of the safexcel EIP97
used on CP110 component of the Armada 7K/8K SoCs.

This follow the changes already made in the binding documentation (as
well as in the driver): "crypto: inside-secure - fix clock resource by
adding a register clock"

Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
---
 arch/arm64/boot/dts/marvell/armada-cp110.dtsi | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/marvell/armada-cp110.dtsi b/arch/arm64/boot/dts/marvell/armada-cp110.dtsi
index c491adc90b8c..b6947fcb8ce6 100644
--- a/arch/arm64/boot/dts/marvell/armada-cp110.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-cp110.dtsi
@@ -402,7 +402,9 @@
 				<ICU_GRP_NSR 92 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "mem", "ring0", "ring1",
 				"ring2", "ring3", "eip";
-			clocks = <&CP110_LABEL(clk) 1 26>;
+			clock-names = "core", "reg";
+			clocks = <&CP110_LABEL(clk) 1 26>,
+				 <&CP110_LABEL(clk) 1 17>;
 			dma-coherent;
 		};
 	};
-- 
2.16.1
