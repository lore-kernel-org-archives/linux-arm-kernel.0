From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 20 Oct 2017 12:29:03 +0200
Subject: [PATCH 36/42] ARM: dts: r8a7792: Add missing clock for secondary CA15
 CPU core
In-Reply-To: <cover.1508493785.git.horms+renesas@verge.net.au>
References: <cover.1508493785.git.horms+renesas@verge.net.au>
Message-ID: <8684a24caa3d59d9ba03f1e6f9653b49ac78ec04.1508493785.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Currently only the primary CPU in the CA15 cluster has a clocks
property, while the secondary CPU core is driven by the same clock.
Add the missing clocks property to fix this.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7792.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/r8a7792.dtsi b/arch/arm/boot/dts/r8a7792.dtsi
index 56570d1ce5f6..131f65b0426e 100644
--- a/arch/arm/boot/dts/r8a7792.dtsi
+++ b/arch/arm/boot/dts/r8a7792.dtsi
@@ -56,6 +56,7 @@
 			compatible = "arm,cortex-a15";
 			reg = <1>;
 			clock-frequency = <1000000000>;
+			clocks = <&cpg CPG_CORE R8A7792_CLK_Z>;
 			power-domains = <&sysc R8A7792_PD_CA15_CPU1>;
 			next-level-cache = <&L2_CA15>;
 		};
-- 
2.11.0
