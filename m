From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 16 Mar 2018 17:38:00 +0100
Subject: [PATCH 03/47] ARM: dts: r8a7793: Reduce size of thermal registers
In-Reply-To: <cover.1521218085.git.horms+renesas@verge.net.au>
References: <cover.1521218085.git.horms+renesas@verge.net.au>
Message-ID: <1cfe2186c708c8f954097086e3da0cffd1e75f4e.1521218085.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Reduce size of thermal registers in DT for r8a7793 (R-Car M3-N) SoC.

According to the "User's Manual: Hardware" v2.00 the registers at base
0xe61f0000 extend to an offset of 0x10, rather than 0x14 which is the case
on the r8a73a4 (R-Mobile APE6).

This should not have any runtime affect as mapping granularity is PAGE_SIZE.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7793.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7793.dtsi b/arch/arm/boot/dts/r8a7793.dtsi
index 039b22517526..e95f4fb44dc4 100644
--- a/arch/arm/boot/dts/r8a7793.dtsi
+++ b/arch/arm/boot/dts/r8a7793.dtsi
@@ -231,7 +231,7 @@
 		compatible =	"renesas,thermal-r8a7793",
 				"renesas,rcar-gen2-thermal",
 				"renesas,rcar-thermal";
-		reg = <0 0xe61f0000 0 0x14>, <0 0xe61f0100 0 0x38>;
+		reg = <0 0xe61f0000 0 0x10>, <0 0xe61f0100 0 0x38>;
 		interrupts = <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cpg CPG_MOD 522>;
 		power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
-- 
2.11.0
