From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 18 Oct 2017 09:27:22 +0200
Subject: [PATCH 1/7] ARM: dts: r8a7743: Use R-Car Gen2 Ether fallback compat
 string
In-Reply-To: <20171018072728.14681-1-horms+renesas@verge.net.au>
References: <20171018072728.14681-1-horms+renesas@verge.net.au>
Message-ID: <20171018072728.14681-2-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use newly added R-Car Gen2 Ether fallback compat string
in the DT of the r8a7743 SoC.

This should have no run-time effect as the driver matches against
the per-SoC compat string before considering the fallback compat string.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7743.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7743.dtsi b/arch/arm/boot/dts/r8a7743.dtsi
index 7bbba4a36f31..0bfb6248f255 100644
--- a/arch/arm/boot/dts/r8a7743.dtsi
+++ b/arch/arm/boot/dts/r8a7743.dtsi
@@ -827,7 +827,8 @@
 		};
 
 		ether: ethernet at ee700000 {
-			compatible = "renesas,ether-r8a7743";
+			compatible = "renesas,ether-r8a7743",
+			             "renesas,rcar-gen2-ether";
 			reg = <0 0xee700000 0 0x400>;
 			interrupts = <GIC_SPI 162 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 813>;
-- 
2.11.0
