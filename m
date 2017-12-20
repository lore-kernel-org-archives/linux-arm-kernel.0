From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 20 Dec 2017 13:14:45 +0100
Subject: [PATCH 3/3] ARM: dts: r8a7793: Reduce size of thermal registers
In-Reply-To: <20171220121445.31896-1-horms+renesas@verge.net.au>
References: <20171220121445.31896-1-horms+renesas@verge.net.au>
Message-ID: <20171220121445.31896-4-horms+renesas@verge.net.au>
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
