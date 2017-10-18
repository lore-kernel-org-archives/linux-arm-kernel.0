From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 18 Oct 2017 09:27:24 +0200
Subject: [PATCH 3/7] ARM: dts: r8a7778: Use R-Car Gen1 Ether fallback compat
 string
In-Reply-To: <20171018072728.14681-1-horms+renesas@verge.net.au>
References: <20171018072728.14681-1-horms+renesas@verge.net.au>
Message-ID: <20171018072728.14681-4-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use newly added R-Car Gen1 Ether fallback compat string
in the DT of the r8a7778 SoC.

This should have no run-time effect as the driver matches against
the per-SoC compat string before considering the fallback compat string.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7778.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7778.dtsi b/arch/arm/boot/dts/r8a7778.dtsi
index a39472aab867..d6e3c0400ec3 100644
--- a/arch/arm/boot/dts/r8a7778.dtsi
+++ b/arch/arm/boot/dts/r8a7778.dtsi
@@ -51,7 +51,8 @@
 	};
 
 	ether: ethernet at fde00000 {
-		compatible = "renesas,ether-r8a7778";
+		compatible = "renesas,ether-r8a7778",
+			     "renesas,rcar-gen1-ether";
 		reg = <0xfde00000 0x400>;
 		interrupts = <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp1_clks R8A7778_CLK_ETHER>;
-- 
2.11.0
