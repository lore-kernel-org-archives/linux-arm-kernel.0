From: biju.das@bp.renesas.com (Biju Das)
Date: Fri, 24 Aug 2018 11:43:47 +0100
Subject: [PATCH 1/3] arm64: dts: renesas: r8a774a1: Add USB2.0 phy and
 host(EHCI/OHCI) device nodes
In-Reply-To: <1535107429-5458-1-git-send-email-biju.das@bp.renesas.com>
References: <1535107429-5458-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1535107429-5458-2-git-send-email-biju.das@bp.renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add USB2.0 phy and host (EHCI/OHCI) device nodes on RZ/G2M SoC dtsi.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r8a774a1.dtsi | 73 +++++++++++++++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a774a1.dtsi b/arch/arm64/boot/dts/renesas/r8a774a1.dtsi
index cd204f5..a794089 100644
--- a/arch/arm64/boot/dts/renesas/r8a774a1.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a774a1.dtsi
@@ -1344,6 +1344,79 @@
 			dma-channels = <16>;
 		};
 
+		ohci0: usb at ee080000 {
+			compatible = "generic-ohci";
+			reg = <0 0xee080000 0 0x100>;
+			interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 703>;
+			phys = <&usb2_phy0>;
+			phy-names = "usb";
+			power-domains = <&sysc 32>;
+			resets = <&cpg 703>;
+			status = "disabled";
+		};
+
+		ohci1: usb at ee0a0000 {
+			compatible = "generic-ohci";
+			reg = <0 0xee0a0000 0 0x100>;
+			interrupts = <GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 702>;
+			phys = <&usb2_phy1>;
+			phy-names = "usb";
+			power-domains = <&sysc 32>;
+			resets = <&cpg 702>;
+			status = "disabled";
+		};
+
+		ehci0: usb at ee080100 {
+			compatible = "generic-ehci";
+			reg = <0 0xee080100 0 0x100>;
+			interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 703>;
+			phys = <&usb2_phy0>;
+			phy-names = "usb";
+			companion= <&ohci0>;
+			power-domains = <&sysc 32>;
+			resets = <&cpg 703>;
+			status = "disabled";
+		};
+
+		ehci1: usb at ee0a0100 {
+			compatible = "generic-ehci";
+			reg = <0 0xee0a0100 0 0x100>;
+			interrupts = <GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 702>;
+			phys = <&usb2_phy1>;
+			phy-names = "usb";
+			companion= <&ohci1>;
+			power-domains = <&sysc 32>;
+			resets = <&cpg 702>;
+			status = "disabled";
+		};
+
+		usb2_phy0: usb-phy at ee080200 {
+			compatible = "renesas,usb2-phy-r8a774a1",
+				     "renesas,rcar-gen3-usb2-phy";
+			reg = <0 0xee080200 0 0x700>;
+			interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 703>;
+			power-domains = <&sysc 32>;
+			resets = <&cpg 703>;
+			#phy-cells = <0>;
+			status = "disabled";
+		};
+
+		usb2_phy1: usb-phy at ee0a0200 {
+			compatible = "renesas,usb2-phy-r8a774a1",
+				     "renesas,rcar-gen3-usb2-phy";
+			reg = <0 0xee0a0200 0 0x700>;
+			clocks = <&cpg CPG_MOD 702>;
+			power-domains = <&sysc 32>;
+			resets = <&cpg 702>;
+			#phy-cells = <0>;
+			status = "disabled";
+		};
+
 		sdhi0: sd at ee100000 {
 			compatible = "renesas,sdhi-r8a774a1",
 				     "renesas,rcar-gen3-sdhi";
-- 
2.7.4
