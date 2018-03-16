From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 16 Mar 2018 15:51:22 +0100
Subject: [PATCH 52/69] arm64: dts: renesas: r8a77965: Add INTC-EX device node
In-Reply-To: <cover.1521206129.git.horms+renesas@verge.net.au>
References: <cover.1521206129.git.horms+renesas@verge.net.au>
Message-ID: <ba03b432f56e29a8ee639d9e9787da283b2ed09c.1521206129.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Populate the device node for the Interrupt Controller for External
Devices (INTC-EX) on R-Car M3-N, which serves external IRQ pins
IRQ[0-5].

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a77965.dtsi | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a77965.dtsi b/arch/arm64/boot/dts/renesas/r8a77965.dtsi
index c1ecc1b8385f..b9aa0e7eaabf 100644
--- a/arch/arm64/boot/dts/renesas/r8a77965.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a77965.dtsi
@@ -320,10 +320,19 @@
 		};
 
 		intc_ex: interrupt-controller at e61c0000 {
+			compatible = "renesas,intc-ex-r8a77965", "renesas,irqc";
 			#interrupt-cells = <2>;
 			interrupt-controller;
 			reg = <0 0xe61c0000 0 0x200>;
-			/* placeholder */
+			interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 161 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 407>;
+			power-domains = <&sysc 32>;
+			resets = <&cpg 407>;
 		};
 
 		dmac0: dma-controller at e6700000 {
-- 
2.11.0
