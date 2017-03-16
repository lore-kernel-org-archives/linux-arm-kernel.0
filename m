From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Thu, 16 Mar 2017 15:07:25 +0100
Subject: [PATCH v2 3/4] ARM: dts: r8a7743: Add reset control properties
In-Reply-To: <1489673246-11015-1-git-send-email-geert+renesas@glider.be>
References: <1489673246-11015-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1489673246-11015-4-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add properties to describe the reset topology for on-SoC devices:
  - Add the "#reset-cells" property to the CPG/MSSR device node,
  - Add resets and reset-names properties to the various device nodes.

This allows to reset SoC devices using the Reset Controller API.

Note that all resets added match the corresponding module clocks.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - No changes.
---
 arch/arm/boot/dts/r8a7743.dtsi | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7743.dtsi b/arch/arm/boot/dts/r8a7743.dtsi
index cd908796fb3b7c18..0ddac81742e4cdc7 100644
--- a/arch/arm/boot/dts/r8a7743.dtsi
+++ b/arch/arm/boot/dts/r8a7743.dtsi
@@ -62,6 +62,7 @@
 			clocks = <&cpg CPG_MOD 408>;
 			clock-names = "clk";
 			power-domains = <&sysc R8A7743_PD_ALWAYS_ON>;
+			resets = <&cpg 408>;
 		};
 
 		irqc: interrupt-controller at e61c0000 {
@@ -81,6 +82,7 @@
 				     <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 407>;
 			power-domains = <&sysc R8A7743_PD_ALWAYS_ON>;
+			resets = <&cpg 407>;
 		};
 
 		timer {
@@ -102,6 +104,7 @@
 			clock-names = "extal", "usb_extal";
 			#clock-cells = <2>;
 			#power-domain-cells = <0>;
+			#reset-cells = <1>;
 		};
 
 		prr: chipid at ff000044 {
@@ -148,6 +151,7 @@
 			clocks = <&cpg CPG_MOD 219>;
 			clock-names = "fck";
 			power-domains = <&sysc R8A7743_PD_ALWAYS_ON>;
+			resets = <&cpg 219>;
 			#dma-cells = <1>;
 			dma-channels = <15>;
 		};
@@ -180,6 +184,7 @@
 			clocks = <&cpg CPG_MOD 218>;
 			clock-names = "fck";
 			power-domains = <&sysc R8A7743_PD_ALWAYS_ON>;
+			resets = <&cpg 218>;
 			#dma-cells = <1>;
 			dma-channels = <15>;
 		};
@@ -195,6 +200,7 @@
 			       <&dmac1 0x21>, <&dmac1 0x22>;
 			dma-names = "tx", "rx", "tx", "rx";
 			power-domains = <&sysc R8A7743_PD_ALWAYS_ON>;
+			resets = <&cpg 204>;
 			status = "disabled";
 		};
 
@@ -209,6 +215,7 @@
 			       <&dmac1 0x25>, <&dmac1 0x26>;
 			dma-names = "tx", "rx", "tx", "rx";
 			power-domains = <&sysc R8A7743_PD_ALWAYS_ON>;
+			resets = <&cpg 203>;
 			status = "disabled";
 		};
 
@@ -223,6 +230,7 @@
 			       <&dmac1 0x27>, <&dmac1 0x28>;
 			dma-names = "tx", "rx", "tx", "rx";
 			power-domains = <&sysc R8A7743_PD_ALWAYS_ON>;
+			resets = <&cpg 202>;
 			status = "disabled";
 		};
 
@@ -237,6 +245,7 @@
 			       <&dmac1 0x1b>, <&dmac1 0x1c>;
 			dma-names = "tx", "rx", "tx", "rx";
 			power-domains = <&sysc R8A7743_PD_ALWAYS_ON>;
+			resets = <&cpg 1106>;
 			status = "disabled";
 		};
 
@@ -251,6 +260,7 @@
 			       <&dmac1 0x1f>, <&dmac1 0x20>;
 			dma-names = "tx", "rx", "tx", "rx";
 			power-domains = <&sysc R8A7743_PD_ALWAYS_ON>;
+			resets = <&cpg 1107>;
 			status = "disabled";
 		};
 
@@ -265,6 +275,7 @@
 			       <&dmac1 0x23>, <&dmac1 0x24>;
 			dma-names = "tx", "rx", "tx", "rx";
 			power-domains = <&sysc R8A7743_PD_ALWAYS_ON>;
+			resets = <&cpg 1108>;
 			status = "disabled";
 		};
 
@@ -279,6 +290,7 @@
 			       <&dmac1 0x3d>, <&dmac1 0x3e>;
 			dma-names = "tx", "rx", "tx", "rx";
 			power-domains = <&sysc R8A7743_PD_ALWAYS_ON>;
+			resets = <&cpg 206>;
 			status = "disabled";
 		};
 
@@ -293,6 +305,7 @@
 			       <&dmac1 0x19>, <&dmac1 0x1a>;
 			dma-names = "tx", "rx", "tx", "rx";
 			power-domains = <&sysc R8A7743_PD_ALWAYS_ON>;
+			resets = <&cpg 207>;
 			status = "disabled";
 		};
 
@@ -307,6 +320,7 @@
 			       <&dmac1 0x1d>, <&dmac1 0x1e>;
 			dma-names = "tx", "rx", "tx", "rx";
 			power-domains = <&sysc R8A7743_PD_ALWAYS_ON>;
+			resets = <&cpg 216>;
 			status = "disabled";
 		};
 
@@ -322,6 +336,7 @@
 			       <&dmac1 0x29>, <&dmac1 0x2a>;
 			dma-names = "tx", "rx", "tx", "rx";
 			power-domains = <&sysc R8A7743_PD_ALWAYS_ON>;
+			resets = <&cpg 721>;
 			status = "disabled";
 		};
 
@@ -337,6 +352,7 @@
 			       <&dmac1 0x2d>, <&dmac1 0x2e>;
 			dma-names = "tx", "rx", "tx", "rx";
 			power-domains = <&sysc R8A7743_PD_ALWAYS_ON>;
+			resets = <&cpg 720>;
 			status = "disabled";
 		};
 
@@ -352,6 +368,7 @@
 			       <&dmac1 0x2b>, <&dmac1 0x2c>;
 			dma-names = "tx", "rx", "tx", "rx";
 			power-domains = <&sysc R8A7743_PD_ALWAYS_ON>;
+			resets = <&cpg 719>;
 			status = "disabled";
 		};
 
@@ -367,6 +384,7 @@
 			       <&dmac1 0x2f>, <&dmac1 0x30>;
 			dma-names = "tx", "rx", "tx", "rx";
 			power-domains = <&sysc R8A7743_PD_ALWAYS_ON>;
+			resets = <&cpg 718>;
 			status = "disabled";
 		};
 
@@ -382,6 +400,7 @@
 			       <&dmac1 0xfb>, <&dmac1 0xfc>;
 			dma-names = "tx", "rx", "tx", "rx";
 			power-domains = <&sysc R8A7743_PD_ALWAYS_ON>;
+			resets = <&cpg 715>;
 			status = "disabled";
 		};
 
@@ -397,6 +416,7 @@
 			       <&dmac1 0xfd>, <&dmac1 0xfe>;
 			dma-names = "tx", "rx", "tx", "rx";
 			power-domains = <&sysc R8A7743_PD_ALWAYS_ON>;
+			resets = <&cpg 714>;
 			status = "disabled";
 		};
 
@@ -412,6 +432,7 @@
 			       <&dmac1 0x39>, <&dmac1 0x3a>;
 			dma-names = "tx", "rx", "tx", "rx";
 			power-domains = <&sysc R8A7743_PD_ALWAYS_ON>;
+			resets = <&cpg 717>;
 			status = "disabled";
 		};
 
@@ -427,6 +448,7 @@
 			       <&dmac1 0x4d>, <&dmac1 0x4e>;
 			dma-names = "tx", "rx", "tx", "rx";
 			power-domains = <&sysc R8A7743_PD_ALWAYS_ON>;
+			resets = <&cpg 716>;
 			status = "disabled";
 		};
 
@@ -442,6 +464,7 @@
 			       <&dmac1 0x3b>, <&dmac1 0x3c>;
 			dma-names = "tx", "rx", "tx", "rx";
 			power-domains = <&sysc R8A7743_PD_ALWAYS_ON>;
+			resets = <&cpg 713>;
 			status = "disabled";
 		};
 
@@ -451,6 +474,7 @@
 			interrupts = <GIC_SPI 162 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 813>;
 			power-domains = <&sysc R8A7743_PD_ALWAYS_ON>;
+			resets = <&cpg 813>;
 			phy-mode = "rmii";
 			#address-cells = <1>;
 			#size-cells = <0>;
-- 
2.7.4
