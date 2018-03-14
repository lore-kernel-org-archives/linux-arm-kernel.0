From: gregory.clement@bootlin.com (Gregory CLEMENT)
Date: Wed, 14 Mar 2018 17:19:25 +0100
Subject: [PATCH 3/6] ARM64: dts: marvell: armada-cp110: Add registers clock
 for the trng node
In-Reply-To: <20180314161928.7239-1-gregory.clement@bootlin.com>
References: <20180314161928.7239-1-gregory.clement@bootlin.com>
Message-ID: <20180314161928.7239-4-gregory.clement@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This extra clock is needed to access the registers of the harware RNG
used on CP110 component of the Armada 7K/8K SoCs.

This follow the changes already made in the binding documentation (as
well as in the driver): "hwrng: omap - Fix clock resource by adding a
register clock"

Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
---
 arch/arm64/boot/dts/marvell/armada-cp110.dtsi | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/marvell/armada-cp110.dtsi b/arch/arm64/boot/dts/marvell/armada-cp110.dtsi
index a51c553b5120..c491adc90b8c 100644
--- a/arch/arm64/boot/dts/marvell/armada-cp110.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-cp110.dtsi
@@ -375,7 +375,9 @@
 			"inside-secure,safexcel-eip76";
 			reg = <0x760000 0x7d>;
 			interrupts = <ICU_GRP_NSR 95 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&CP110_LABEL(clk) 1 25>;
+			clock-names = "core", "reg";
+			clocks = <&CP110_LABEL(clk) 1 25>,
+				 <&CP110_LABEL(clk) 1 17>;
 			status = "okay";
 		};
 
-- 
2.16.1
