From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Fri, 20 Jan 2017 15:08:25 +0100
Subject: [PATCH 7/8] ARM: dts: r8a7743: Add reset control properties
In-Reply-To: <1484921306-9967-1-git-send-email-geert+renesas@glider.be>
References: <1484921306-9967-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1484921306-9967-8-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add properties to describe the reset topology for on-SoC devices:
  - Add the "#reset-cells" property to the CPG/MSSR device node,
  - Add resets and reset-names properties to the various device nodes.

This allows to reset SoC devices using the Reset Controller API.

Note that all resets added match the corresponding module clocks.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/r8a7743.dtsi | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7743.dtsi b/arch/arm/boot/dts/r8a7743.dtsi
index 40d2cdede7022ff6..5f2287ea00922ee0 100644
--- a/arch/arm/boot/dts/r8a7743.dtsi
+++ b/arch/arm/boot/dts/r8a7743.dtsi
@@ -63,6 +63,7 @@
 			clocks = <&cpg CPG_MOD 408>;
 			clock-names = "clk";
 			power-domains = <&sysc R8A7743_PD_ALWAYS_ON>;
+			resets = <&cpg 408>;
 		};
 
 		irqc: interrupt-controller at e61c0000 {
@@ -82,6 +83,7 @@
 				     <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 407>;
 			power-domains = <&sysc R8A7743_PD_ALWAYS_ON>;
+			resets = <&cpg 407>;
 		};
 
 		timer {
@@ -103,6 +105,7 @@
 			clock-names = "extal", "usb_extal";
 			#clock-cells = <2>;
 			#power-domain-cells = <0>;
+			#reset-cells = <1>;
 		};
 
 		prr: chipid at ff000044 {
@@ -149,6 +152,7 @@
 			clocks = <&cpg CPG_MOD 219>;
 			clock-names = "fck";
 			power-domains = <&sysc R8A7743_PD_ALWAYS_ON>;
+			resets = <&cpg 219>;
 			#dma-cells = <1>;
 			dma-channels = <15>;
 		};
@@ -181,6 +185,7 @@
 			clocks = <&cpg CPG_MOD 218>;
 			clock-names = "fck";
 			power-domains = <&sysc R8A7743_PD_ALWAYS_ON>;
+			resets = <&cpg 218>;
 			#dma-cells = <1>;
 			dma-channels = <15>;
 		};
@@ -196,6 +201,7 @@
 			       <&dmac1 0x21>, <&dmac1 0x22>;
 			dma-names = "tx", "rx", "tx", "rx";
 			power-domains = <&sysc R8A7743_PD_ALWAYS_ON>;
+			resets = <&cpg 204>;
 			status = "disabled";
 		};
 
@@ -210,6 +216,7 @@
 			       <&dmac1 0x25>, <&dmac1 0x26>;
 			dma-names = "tx", "rx", "tx", "rx";
 			power-domains = <&sysc R8A7743_PD_ALWAYS_ON>;
+			resets = <&cpg 203>;
 			status = "disabled";
 		};
 
@@ -224,6 +231,7 @@
 			       <&dmac1 0x27>, <&dmac1 0x28>;
 			dma-names = "tx", "rx", "tx", "rx";
 			power-domains = <&sysc R8A7743_PD_ALWAYS_ON>;
+			resets = <&cpg 202>;
 			status = "disabled";
 		};
 
@@ -238,6 +246,7 @@
 			       <&dmac1 0x1b>, <&dmac1 0x1c>;
 			dma-names = "tx", "rx", "tx", "rx";
 			power-domains = <&sysc R8A7743_PD_ALWAYS_ON>;
+			resets = <&cpg 1106>;
 			status = "disabled";
 		};
 
@@ -252,6 +261,7 @@
 			       <&dmac1 0x1f>, <&dmac1 0x20>;
 			dma-names = "tx", "rx", "tx", "rx";
 			power-domains = <&sysc R8A7743_PD_ALWAYS_ON>;
+			resets = <&cpg 1107>;
 			status = "disabled";
 		};
 
@@ -266,6 +276,7 @@
 			       <&dmac1 0x23>, <&dmac1 0x24>;
 			dma-names = "tx", "rx", "tx", "rx";
 			power-domains = <&sysc R8A7743_PD_ALWAYS_ON>;
+			resets = <&cpg 1108>;
 			status = "disabled";
 		};
 
@@ -280,6 +291,7 @@
 		       <&dmac1 0x3d>, <&dmac1 0x3e>;
 			dma-names = "tx", "rx", "tx", "rx";
 			power-domains = <&sysc R8A7743_PD_ALWAYS_ON>;
+			resets = <&cpg 206>;
 			status = "disabled";
 		};
 
@@ -294,6 +306,7 @@
 			       <&dmac1 0x19>, <&dmac1 0x1a>;
 			dma-names = "tx", "rx", "tx", "rx";
 			power-domains = <&sysc R8A7743_PD_ALWAYS_ON>;
+			resets = <&cpg 207>;
 			status = "disabled";
 		};
 
@@ -308,6 +321,7 @@
 			       <&dmac1 0x1d>, <&dmac1 0x1e>;
 			dma-names = "tx", "rx", "tx", "rx";
 			power-domains = <&sysc R8A7743_PD_ALWAYS_ON>;
+			resets = <&cpg 216>;
 			status = "disabled";
 		};
 
@@ -323,6 +337,7 @@
 			       <&dmac1 0x29>, <&dmac1 0x2a>;
 			dma-names = "tx", "rx", "tx", "rx";
 			power-domains = <&sysc R8A7743_PD_ALWAYS_ON>;
+			resets = <&cpg 721>;
 			status = "disabled";
 		};
 
@@ -338,6 +353,7 @@
 			       <&dmac1 0x2d>, <&dmac1 0x2e>;
 			dma-names = "tx", "rx", "tx", "rx";
 			power-domains = <&sysc R8A7743_PD_ALWAYS_ON>;
+			resets = <&cpg 720>;
 			status = "disabled";
 		};
 
@@ -353,6 +369,7 @@
 			       <&dmac1 0x2b>, <&dmac1 0x2c>;
 			dma-names = "tx", "rx", "tx", "rx";
 			power-domains = <&sysc R8A7743_PD_ALWAYS_ON>;
+			resets = <&cpg 719>;
 			status = "disabled";
 		};
 
@@ -368,6 +385,7 @@
 			       <&dmac1 0x2f>, <&dmac1 0x30>;
 			dma-names = "tx", "rx", "tx", "rx";
 			power-domains = <&sysc R8A7743_PD_ALWAYS_ON>;
+			resets = <&cpg 718>;
 			status = "disabled";
 		};
 
@@ -383,6 +401,7 @@
 			       <&dmac1 0xfb>, <&dmac1 0xfc>;
 			dma-names = "tx", "rx", "tx", "rx";
 			power-domains = <&sysc R8A7743_PD_ALWAYS_ON>;
+			resets = <&cpg 715>;
 			status = "disabled";
 		};
 
@@ -398,6 +417,7 @@
 			       <&dmac1 0xfd>, <&dmac1 0xfe>;
 			dma-names = "tx", "rx", "tx", "rx";
 			power-domains = <&sysc R8A7743_PD_ALWAYS_ON>;
+			resets = <&cpg 714>;
 			status = "disabled";
 		};
 
@@ -413,6 +433,7 @@
 			       <&dmac1 0x39>, <&dmac1 0x3a>;
 			dma-names = "tx", "rx", "tx", "rx";
 			power-domains = <&sysc R8A7743_PD_ALWAYS_ON>;
+			resets = <&cpg 717>;
 			status = "disabled";
 		};
 
@@ -428,6 +449,7 @@
 			       <&dmac1 0x4d>, <&dmac1 0x4e>;
 			dma-names = "tx", "rx", "tx", "rx";
 			power-domains = <&sysc R8A7743_PD_ALWAYS_ON>;
+			resets = <&cpg 716>;
 			status = "disabled";
 		};
 
@@ -443,6 +465,7 @@
 			       <&dmac1 0x3b>, <&dmac1 0x3c>;
 			dma-names = "tx", "rx", "tx", "rx";
 			power-domains = <&sysc R8A7743_PD_ALWAYS_ON>;
+			resets = <&cpg 713>;
 			status = "disabled";
 		};
 
@@ -452,6 +475,7 @@
 			interrupts = <GIC_SPI 162 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 813>;
 			power-domains = <&sysc R8A7743_PD_ALWAYS_ON>;
+			resets = <&cpg 813>;
 			phy-mode = "rmii";
 			#address-cells = <1>;
 			#size-cells = <0>;
-- 
1.9.1
