From: miquel.raynal@bootlin.com (Miquel Raynal)
Date: Sat, 21 Apr 2018 15:55:23 +0200
Subject: [PATCH 03/17] arm64: dts: marvell: add syscon compatible to CP110 ICU
 node
In-Reply-To: <20180421135537.24716-1-miquel.raynal@bootlin.com>
References: <20180421135537.24716-1-miquel.raynal@bootlin.com>
Message-ID: <20180421135537.24716-4-miquel.raynal@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Prepare the migration to new bindings where the ICU node has several
subnodes: one per interrupt group (NSR, SEI, REI, etc). The code for
each node will share the same set of registers. Turning the ICU node
into a syscon is a clean solution to handle that.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 arch/arm64/boot/dts/marvell/armada-cp110.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/marvell/armada-cp110.dtsi b/arch/arm64/boot/dts/marvell/armada-cp110.dtsi
index 9fa41c54f69c..9323acdb712f 100644
--- a/arch/arm64/boot/dts/marvell/armada-cp110.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-cp110.dtsi
@@ -145,7 +145,7 @@
 		};
 
 		CP110_LABEL(icu): interrupt-controller at 1e0000 {
-			compatible = "marvell,cp110-icu";
+			compatible = "marvell,cp110-icu", "syscon";
 			reg = <0x1e0000 0x440>;
 			#interrupt-cells = <3>;
 			interrupt-controller;
-- 
2.14.1
