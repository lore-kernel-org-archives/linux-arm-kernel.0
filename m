From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Fri, 17 Jun 2016 01:03:53 +0300
Subject: [PATCH 2/2] ARM: dts: r8a7792: add JPU support
In-Reply-To: <7346244.CEZI3u99oZ@wasted.cogentembedded.com>
References: <7346244.CEZI3u99oZ@wasted.cogentembedded.com>
Message-ID: <2415204.YUO4drecC0@wasted.cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Describe JPEG Processing Unit (JPU) in the R8A7792 device tree.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
 arch/arm/boot/dts/r8a7792.dtsi |    9 +++++++++
 1 file changed, 9 insertions(+)

Index: renesas/arch/arm/boot/dts/r8a7792.dtsi
===================================================================
--- renesas.orig/arch/arm/boot/dts/r8a7792.dtsi
+++ renesas/arch/arm/boot/dts/r8a7792.dtsi
@@ -246,6 +246,15 @@
 			status = "disabled";
 		};
 
+		jpu: jpeg-codec at fe980000 {
+			compatible = "renesas,jpu-r8a7792",
+				     "renesas,rcar-gen2-jpu";
+			reg = <0 0xfe980000 0 0x10300>;
+			interrupts = <GIC_SPI 272 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mstp1_clks R8A7792_CLK_JPU>;
+			power-domains = <&sysc R8A7792_PD_ALWAYS_ON>;
+		};
+
 		/* Special CPG clocks */
 		cpg_clocks: cpg_clocks at e6150000 {
 			compatible = "renesas,r8a7792-cpg-clocks",
