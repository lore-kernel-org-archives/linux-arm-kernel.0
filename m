From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 17 Oct 2017 08:09:57 +0200
Subject: [PATCH 09/11] ARM: dts: r8a7792: Use R-Car SDHI Gen2 fallback compat
 string
In-Reply-To: <20171017060959.16702-1-horms+renesas@verge.net.au>
References: <20171017060959.16702-1-horms+renesas@verge.net.au>
Message-ID: <20171017060959.16702-10-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use newly added R-Car SDHI Gen2 fallback compat string
in the DT of the r8a7792 SoC.

This should have no run-time effect as the driver matches against
the per-SoC compat string before considering the fallback compat string.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7792.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7792.dtsi b/arch/arm/boot/dts/r8a7792.dtsi
index 131f65b0426e..7b394273031e 100644
--- a/arch/arm/boot/dts/r8a7792.dtsi
+++ b/arch/arm/boot/dts/r8a7792.dtsi
@@ -507,7 +507,8 @@
 		};
 
 		sdhi0: sd at ee100000 {
-			compatible = "renesas,sdhi-r8a7792";
+			compatible = "renesas,sdhi-r8a7792",
+				     "renesas,rcar-gen2-sdhi";
 			reg = <0 0xee100000 0 0x328>;
 			interrupts = <0 165 IRQ_TYPE_LEVEL_HIGH>;
 			dmas = <&dmac0 0xcd>, <&dmac0 0xce>,
-- 
2.11.0
