From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 25 Aug 2014 10:10:06 +0900
Subject: [PATCH 6/7] ARM: shmobile: r8a7791 dtsi: Remove superfluous
 interrupt-parent
In-Reply-To: <cover.1408928822.git.horms+renesas@verge.net.au>
References: <cover.1408928822.git.horms+renesas@verge.net.au>
Message-ID: <5fb1453c2ff02ce5e5298351ff774e19f8d9dbb3.1408928822.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

There's already an "interrupt-parent = <&gic>;" at the top, which is
inherited by all child nodes, so the "interrupt-parent" property in
the sound node can be removed.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Magnus Damm <damm+renesas@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7791.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
index d62c237..9ee1d41 100644
--- a/arch/arm/boot/dts/r8a7791.dtsi
+++ b/arch/arm/boot/dts/r8a7791.dtsi
@@ -1124,7 +1124,6 @@
 	rcar_sound: rcar_sound at 0xec500000 {
 		#sound-dai-cells = <1>;
 		compatible =  "renesas,rcar_sound-r8a7791", "renesas,rcar_sound-gen2", "renesas,rcar_sound";
-		interrupt-parent = <&gic>;
 		reg =	<0 0xec500000 0 0x1000>, /* SCU */
 			<0 0xec5a0000 0 0x100>,  /* ADG */
 			<0 0xec540000 0 0x1000>, /* SSIU */
-- 
2.0.1
