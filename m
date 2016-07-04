From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Mon, 04 Jul 2016 23:52:59 +0300
Subject: [PATCH v2 1/3] ARM: dts: r8a7792: add PFC support
In-Reply-To: <2793535.9X0Tq7I1Mq@wasted.cogentembedded.com>
References: <2793535.9X0Tq7I1Mq@wasted.cogentembedded.com>
Message-ID: <2998532.i3jfGt2X0c@wasted.cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Define the generic R8A7792 part of the PFC device node.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

---
Changes in version 2:
- killed extra empty line;
- added Geert's tag.

 arch/arm/boot/dts/r8a7792.dtsi |    5 +++++
 1 file changed, 5 insertions(+)

Index: renesas/arch/arm/boot/dts/r8a7792.dtsi
===================================================================
--- renesas.orig/arch/arm/boot/dts/r8a7792.dtsi
+++ renesas/arch/arm/boot/dts/r8a7792.dtsi
@@ -108,6 +108,11 @@
 			#power-domain-cells = <1>;
 		};
 
+		pfc: pin-controller at e6060000 {
+			compatible = "renesas,pfc-r8a7792";
+			reg = <0 0xe6060000 0 0x144>;
+		};
+
 		dmac0: dma-controller at e6700000 {
 			compatible = "renesas,dmac-r8a7792",
 				     "renesas,rcar-dmac";
