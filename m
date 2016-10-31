From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Mon, 31 Oct 2016 22:56:36 +0300
Subject: [PATCH v6 4/7] ARM: dts: r8a7743: add Ether support
In-Reply-To: <1746536.qobnGdHRfV@wasted.cogentembedded.com>
References: <1746536.qobnGdHRfV@wasted.cogentembedded.com>
Message-ID: <1507182.SPSiN92QcM@wasted.cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Define the generic R8A7743 part of the Ether device node.

Based on the original (and large) patch by Dmitry Shifrin
<dmitry.shifrin@cogentembedded.com>.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

---
Changes in version 5:
- refreshed the patch.

Changes in version 4:
- refreshed the patch;
- added Geert's tag.

Changes in version 3:
- resolved a reject;
- updated the "clocks" property for the CPG/MSSR driver.

Changes in version 2:
- new patch.

 arch/arm/boot/dts/r8a7743.dtsi |   12 ++++++++++++
 1 file changed, 12 insertions(+)

Index: renesas/arch/arm/boot/dts/r8a7743.dtsi
===================================================================
--- renesas.orig/arch/arm/boot/dts/r8a7743.dtsi
+++ renesas/arch/arm/boot/dts/r8a7743.dtsi
@@ -418,6 +418,18 @@
 			power-domains = <&sysc R8A7743_PD_ALWAYS_ON>;
 			status = "disabled";
 		};
+
+		ether: ethernet at ee700000 {
+			compatible = "renesas,ether-r8a7743";
+			reg = <0 0xee700000 0 0x400>;
+			interrupts = <GIC_SPI 162 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 813>;
+			power-domains = <&sysc R8A7743_PD_ALWAYS_ON>;
+			phy-mode = "rmii";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
 	};
 
 	/* External root clock */
