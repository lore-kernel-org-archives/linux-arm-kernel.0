From: biju.das@bp.renesas.com (Biju Das)
Date: Mon, 14 Aug 2017 12:49:47 +0100
Subject: [PATCH  1/3] ARM: dts: r8a7743: Add SDHI controllers
In-Reply-To: <1502711389-16040-1-git-send-email-biju.das@bp.renesas.com>
References: <1502711389-16040-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1502711389-16040-2-git-send-email-biju.das@bp.renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the SDHI controllers to the r8a7743 device tree.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 arch/arm/boot/dts/r8a7743.dtsi | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7743.dtsi b/arch/arm/boot/dts/r8a7743.dtsi
index ce80a26..3bd3ab5 100644
--- a/arch/arm/boot/dts/r8a7743.dtsi
+++ b/arch/arm/boot/dts/r8a7743.dtsi
@@ -754,6 +754,48 @@
 			max-frequency = <97500000>;
 			status = "disabled";
 		};
+
+		sdhi0: sd at ee100000 {
+			compatible = "renesas,sdhi-r8a7743";
+			reg = <0 0xee100000 0 0x328>;
+			interrupts = <GIC_SPI 165 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 314>;
+			dmas = <&dmac0 0xcd>, <&dmac0 0xce>,
+			       <&dmac1 0xcd>, <&dmac1 0xce>;
+			dma-names = "tx", "rx", "tx", "rx";
+			max-frequency = <195000000>;
+			power-domains = <&sysc R8A7743_PD_ALWAYS_ON>;
+			resets = <&cpg 314>;
+			status = "disabled";
+		};
+
+		sdhi1: sd at ee140000 {
+			compatible = "renesas,sdhi-r8a7743";
+			reg = <0 0xee140000 0 0x100>;
+			interrupts = <GIC_SPI 167 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 312>;
+			dmas = <&dmac0 0xc1>, <&dmac0 0xc2>,
+			       <&dmac1 0xc1>, <&dmac1 0xc2>;
+			dma-names = "tx", "rx", "tx", "rx";
+			max-frequency = <97500000>;
+			power-domains = <&sysc R8A7743_PD_ALWAYS_ON>;
+			resets = <&cpg 312>;
+			status = "disabled";
+		};
+
+		sdhi2: sd at ee160000 {
+			compatible = "renesas,sdhi-r8a7743";
+			reg = <0 0xee160000 0 0x100>;
+			interrupts = <GIC_SPI 168 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 311>;
+			dmas = <&dmac0 0xd3>, <&dmac0 0xd4>,
+			       <&dmac1 0xd3>, <&dmac1 0xd4>;
+			dma-names = "tx", "rx", "tx", "rx";
+			max-frequency = <97500000>;
+			power-domains = <&sysc R8A7743_PD_ALWAYS_ON>;
+			resets = <&cpg 311>;
+			status = "disabled";
+		};
 	};
 
 	/* External root clock */
-- 
1.9.1
