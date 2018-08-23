From: biju.das@bp.renesas.com (Biju Das)
Date: Thu, 23 Aug 2018 09:58:49 +0100
Subject: [PATCH 3/5] arm64: dts: renesas: r8a774a1: Add INTC-EX device node
In-Reply-To: <1535014731-64472-1-git-send-email-biju.das@bp.renesas.com>
References: <1535014731-64472-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1535014731-64472-4-git-send-email-biju.das@bp.renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for the Interrupt Controller for External Devices
(INTC-EX) on RZ/G2M.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r8a774a1.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a774a1.dtsi b/arch/arm64/boot/dts/renesas/r8a774a1.dtsi
index 81fba7f..15d7785 100644
--- a/arch/arm64/boot/dts/renesas/r8a774a1.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a774a1.dtsi
@@ -144,6 +144,22 @@
 			#power-domain-cells = <1>;
 		};
 
+		intc_ex: interrupt-controller at e61c0000 {
+			compatible = "renesas,intc-ex-r8a774a1", "renesas,irqc";
+			#interrupt-cells = <2>;
+			interrupt-controller;
+			reg = <0 0xe61c0000 0 0x200>;
+			interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 161 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 407>;
+			power-domains = <&sysc 32>;
+			resets = <&cpg 407>;
+		};
+
 		hscif0: serial at e6540000 {
 			compatible = "renesas,hscif-r8a774a1",
 				     "renesas,rcar-gen3-hscif",
-- 
2.7.4
