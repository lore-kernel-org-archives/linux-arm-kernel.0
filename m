From: gregory.clement@bootlin.com (Gregory CLEMENT)
Date: Wed, 14 Mar 2018 17:19:24 +0100
Subject: [PATCH 2/6] ARM64: dts: marvell: armada-cp110: Add registers clock
 for XOR engine nodes
In-Reply-To: <20180314161928.7239-1-gregory.clement@bootlin.com>
References: <20180314161928.7239-1-gregory.clement@bootlin.com>
Message-ID: <20180314161928.7239-3-gregory.clement@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This extra clock is needed to access the registers of the XOR engine
controller used on CP110 component of the Armada 7K/8K SoCs.

This follow the changes already made in the binding documentation (as
well as in the driver): "dmaengine: mv_xor_v2: Fix clock resource by
adding a register clock"

Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
---
 arch/arm64/boot/dts/marvell/armada-cp110.dtsi | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/marvell/armada-cp110.dtsi b/arch/arm64/boot/dts/marvell/armada-cp110.dtsi
index c35368d2a4cd..a51c553b5120 100644
--- a/arch/arm64/boot/dts/marvell/armada-cp110.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-cp110.dtsi
@@ -244,7 +244,9 @@
 			reg = <0x6a0000 0x1000>, <0x6b0000 0x1000>;
 			dma-coherent;
 			msi-parent = <&gic_v2m0>;
-			clocks = <&CP110_LABEL(clk) 1 8>;
+			clock-names = "core", "reg";
+			clocks = <&CP110_LABEL(clk) 1 8>,
+				 <&CP110_LABEL(clk) 1 14>;
 		};
 
 		CP110_LABEL(xor1): xor at 6c0000 {
@@ -252,7 +254,9 @@
 			reg = <0x6c0000 0x1000>, <0x6d0000 0x1000>;
 			dma-coherent;
 			msi-parent = <&gic_v2m0>;
-			clocks = <&CP110_LABEL(clk) 1 7>;
+			clock-names = "core", "reg";
+			clocks = <&CP110_LABEL(clk) 1 7>,
+				 <&CP110_LABEL(clk) 1 14>;
 		};
 
 		CP110_LABEL(spi0): spi at 700600 {
-- 
2.16.1
