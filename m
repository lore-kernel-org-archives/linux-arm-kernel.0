From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 15 Aug 2016 10:55:32 +0200
Subject: [PATCH 13/26] ARM: dts: r8a7792: add SDHI support
In-Reply-To: <cover.1471251169.git.horms+renesas@verge.net.au>
References: <cover.1471251169.git.horms+renesas@verge.net.au>
Message-ID: <ce01b14ecf19a18cd95e698f915f5ea582086c21.1471251169.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Define the generic R8A7792 part of the SDHI0 device node.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7792.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7792.dtsi b/arch/arm/boot/dts/r8a7792.dtsi
index 4148c5867c07..228860d9464a 100644
--- a/arch/arm/boot/dts/r8a7792.dtsi
+++ b/arch/arm/boot/dts/r8a7792.dtsi
@@ -435,6 +435,18 @@
 			status = "disabled";
 		};
 
+		sdhi0: sd at ee100000 {
+			compatible = "renesas,sdhi-r8a7792";
+			reg = <0 0xee100000 0 0x328>;
+			interrupts = <0 165 IRQ_TYPE_LEVEL_HIGH>;
+			dmas = <&dmac0 0xcd>, <&dmac0 0xce>,
+			       <&dmac1 0xcd>, <&dmac1 0xce>;
+			dma-names = "tx", "rx", "tx", "rx";
+			clocks = <&mstp3_clks R8A7792_CLK_SDHI0>;
+			power-domains = <&sysc R8A7792_PD_ALWAYS_ON>;
+			status = "disabled";
+		};
+
 		jpu: jpeg-codec at fe980000 {
 			compatible = "renesas,jpu-r8a7792",
 				     "renesas,rcar-gen2-jpu";
-- 
2.7.0.rc3.207.g0ac5344
