From: biju.das@bp.renesas.com (Biju Das)
Date: Fri, 24 Aug 2018 11:43:49 +0100
Subject: [PATCH 3/3] arm64: dts: renesas: r8a774a1: Add USB3.0 device nodes
In-Reply-To: <1535107429-5458-1-git-send-email-biju.das@bp.renesas.com>
References: <1535107429-5458-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1535107429-5458-4-git-send-email-biju.das@bp.renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add usb3.0 phy, host and function device nodes on RZ/G2M SoC dtsi.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r8a774a1.dtsi | 35 +++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a774a1.dtsi b/arch/arm64/boot/dts/renesas/r8a774a1.dtsi
index 0c1bae7..d9005cb 100644
--- a/arch/arm64/boot/dts/renesas/r8a774a1.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a774a1.dtsi
@@ -641,6 +641,19 @@
 			dma-channels = <2>;
 		};
 
+		usb3_phy0: usb-phy at e65ee000 {
+			compatible = "renesas,r8a774a1-usb3-phy",
+				     "renesas,rcar-gen3-usb3-phy";
+			reg = <0 0xe65ee000 0 0x90>;
+			clocks = <&cpg CPG_MOD 328>, <&usb3s0_clk>,
+				 <&usb_extal_clk>;
+			clock-names = "usb3-if", "usb3s_clk", "usb_extal";
+			power-domains = <&sysc 32>;
+			resets = <&cpg 328>;
+			#phy-cells = <0>;
+			status = "disabled";
+		};
+
 		dmac0: dma-controller at e6700000 {
 			compatible = "renesas,dmac-r8a774a1",
 				     "renesas,rcar-dmac";
@@ -1389,6 +1402,28 @@
 			dma-channels = <16>;
 		};
 
+		xhci0: usb at ee000000 {
+			compatible = "renesas,xhci-r8a774a1",
+				     "renesas,rcar-gen3-xhci";
+			reg = <0 0xee000000 0 0xc00>;
+			interrupts = <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 328>;
+			power-domains = <&sysc 32>;
+			resets = <&cpg 328>;
+			status = "disabled";
+		};
+
+		usb3_peri0: usb at ee020000 {
+			compatible = "renesas,r8a774a1-usb3-peri",
+				     "renesas,rcar-gen3-usb3-peri";
+			reg = <0 0xee020000 0 0x400>;
+			interrupts = <GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 328>;
+			power-domains = <&sysc 32>;
+			resets = <&cpg 328>;
+			status = "disabled";
+		};
+
 		ohci0: usb at ee080000 {
 			compatible = "generic-ohci";
 			reg = <0 0xee080000 0 0x100>;
-- 
2.7.4
