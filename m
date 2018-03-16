From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 16 Mar 2018 15:50:58 +0100
Subject: [PATCH 28/69] arm64: dts: renesas: r8a7795: Fix register mappings on
 VSPs
In-Reply-To: <cover.1521206129.git.horms+renesas@verge.net.au>
References: <cover.1521206129.git.horms+renesas@verge.net.au>
Message-ID: <c5dcfe6552f418df8db03e92e645339cdf746e34.1521206129.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>

The VSPD includes a CLUT on RPF2. Ensure that the register space is
mapped correctly to support this.

Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a7795.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
index ce85704976f0..9dc2b43e59f5 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
@@ -2208,7 +2208,7 @@
 
 		vspd0: vsp at fea20000 {
 			compatible = "renesas,vsp2";
-			reg = <0 0xfea20000 0 0x4000>;
+			reg = <0 0xfea20000 0 0x8000>;
 			interrupts = <GIC_SPI 466 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 623>;
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
@@ -2228,7 +2228,7 @@
 
 		vspd1: vsp at fea28000 {
 			compatible = "renesas,vsp2";
-			reg = <0 0xfea28000 0 0x4000>;
+			reg = <0 0xfea28000 0 0x8000>;
 			interrupts = <GIC_SPI 467 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 622>;
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
@@ -2248,7 +2248,7 @@
 
 		vspd2: vsp at fea30000 {
 			compatible = "renesas,vsp2";
-			reg = <0 0xfea30000 0 0x4000>;
+			reg = <0 0xfea30000 0 0x8000>;
 			interrupts = <GIC_SPI 468 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 621>;
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
-- 
2.11.0
