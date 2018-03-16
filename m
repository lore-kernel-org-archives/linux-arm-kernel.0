From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 16 Mar 2018 15:52:20 +0100
Subject: [PATCH 01/52] ARM: dts: r8a7790: Reduce size of thermal registers
In-Reply-To: <cover.1521208546.git.horms+renesas@verge.net.au>
References: <cover.1521208546.git.horms+renesas@verge.net.au>
Message-ID: <61ad2b1ab4b1ce4e495854c4faa75ca95e5e8ecd.1521208546.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Reduce size of thermal registers in DT for r8a7790 (R-Car H2) SoC.

According to the "User's Manual: Hardware" v2.00 the registers at base
0xe61f0000 extend to an offset of 0x10, rather than 0x14 which is the case
on the r8a73a4 (R-Mobile APE6).

This should not have any runtime affect as mapping granularity is PAGE_SIZE.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7790.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index ed9a68538a55..13926fc7abfa 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -294,7 +294,7 @@
 		compatible =	"renesas,thermal-r8a7790",
 				"renesas,rcar-gen2-thermal",
 				"renesas,rcar-thermal";
-		reg = <0 0xe61f0000 0 0x14>, <0 0xe61f0100 0 0x38>;
+		reg = <0 0xe61f0000 0 0x10>, <0 0xe61f0100 0 0x38>;
 		interrupts = <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cpg CPG_MOD 522>;
 		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
-- 
2.11.0
