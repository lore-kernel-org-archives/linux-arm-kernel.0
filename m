From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Thu, 06 Oct 2016 00:42:28 +0300
Subject: [PATCH v3 07/11] ARM: dts: r8a7743: add Ether support
In-Reply-To: <2056698.ncAHq8vRQ3@wasted.cogentembedded.com>
References: <2056698.ncAHq8vRQ3@wasted.cogentembedded.com>
Message-ID: <1823688.my1YjA2iHn@wasted.cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Define the generic R8A7743 part of the Ether device node.

Based on the original (and large) patch by Dmitry Shifrin
<dmitry.shifrin@cogentembedded.com>.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
Changes in version 3:
- resoled a reject;
- updated the "clocks" property for the CPG/MSSR driver.

Changes in version 2:
- new patch.

 arch/arm/boot/dts/r8a7743.dtsi |   12 ++++++++++++
 1 file changed, 12 insertions(+)

Index: renesas/arch/arm/boot/dts/r8a7743.dtsi
===================================================================
--- renesas.orig/arch/arm/boot/dts/r8a7743.dtsi
+++ renesas/arch/arm/boot/dts/r8a7743.dtsi
@@ -423,6 +423,18 @@
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
