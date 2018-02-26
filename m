From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Mon, 26 Feb 2018 16:42:23 +0100
Subject: [PATCH 2/2] arm64: dts: r8a77965: Add INTC-EX device node
In-Reply-To: <1519659743-27027-1-git-send-email-geert+renesas@glider.be>
References: <1519659743-27027-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1519659743-27027-3-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Populate the device node for the Interrupt Controller for External
Devices (INTC-EX) on R-Car M3-N, which serves external IRQ pins
IRQ[0-5].

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm64/boot/dts/renesas/r8a77965.dtsi | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a77965.dtsi b/arch/arm64/boot/dts/renesas/r8a77965.dtsi
index 7435297d2581c410..2f3d1784343cf3ec 100644
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
2.7.4
