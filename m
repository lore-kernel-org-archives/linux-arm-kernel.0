From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 20 Oct 2017 12:28:57 +0200
Subject: [PATCH 30/42] ARM: dts: r8a7743: Add missing clock for secondary CA15
 CPU core
In-Reply-To: <cover.1508493785.git.horms+renesas@verge.net.au>
References: <cover.1508493785.git.horms+renesas@verge.net.au>
Message-ID: <a60ddf507dda0ede43b72d348283d8725a5a83c7.1508493785.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Currently only the primary CPU in the CA15 cluster has a clocks
property, while the secondary CPU core is driven by the same clock.
Add the missing clocks property to fix this.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Chris Paterson <chris.paterson2@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7743.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/r8a7743.dtsi b/arch/arm/boot/dts/r8a7743.dtsi
index f29f15d4d659..4db4f61be25a 100644
--- a/arch/arm/boot/dts/r8a7743.dtsi
+++ b/arch/arm/boot/dts/r8a7743.dtsi
@@ -63,6 +63,7 @@
 			compatible = "arm,cortex-a15";
 			reg = <1>;
 			clock-frequency = <1500000000>;
+			clocks = <&cpg CPG_CORE R8A7743_CLK_Z>;
 			power-domains = <&sysc R8A7743_PD_CA15_CPU1>;
 			next-level-cache = <&L2_CA15>;
 		};
-- 
2.11.0
