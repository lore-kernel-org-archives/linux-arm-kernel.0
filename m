From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Fri, 16 Feb 2018 21:32:54 +0300
Subject: [PATCH v2 3/5] arm64: dts: renesas: r8a77980: add EtherAVB support
In-Reply-To: <ae31804b-969b-9b20-16d0-50f5dea42f08@cogentembedded.com>
References: <ae31804b-969b-9b20-16d0-50f5dea42f08@cogentembedded.com>
Message-ID: <e857aaca-0328-2bd2-5bbf-b6badb5a4b1e@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Define the generic R8A77980 part of the EtherAVB device node.

Based on the original (and large) patch by Vladimir Barinov.

Signed-off-by: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
Changes in version 2:
- removed the 2nd address/size tuple from the "reg" property;
- changed the "phy-mode" property to the RGMII by default.

 arch/arm64/boot/dts/renesas/r8a77980.dtsi |   44 ++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

Index: renesas/arch/arm64/boot/dts/renesas/r8a77980.dtsi
===================================================================
--- renesas.orig/arch/arm64/boot/dts/renesas/r8a77980.dtsi
+++ renesas/arch/arm64/boot/dts/renesas/r8a77980.dtsi
@@ -164,6 +164,50 @@
 			status = "disabled";
 		};
 
+		avb: ethernet at e6800000 {
+			compatible = "renesas,etheravb-r8a77980",
+				     "renesas,etheravb-rcar-gen3";
+			reg = <0 0xe6800000 0 0x800>;
+			interrupts = <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 46 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 47 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 50 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 51 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 53 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 54 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 58 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 59 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 60 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 61 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 63 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "ch0", "ch1", "ch2", "ch3",
+					  "ch4", "ch5", "ch6", "ch7",
+					  "ch8", "ch9", "ch10", "ch11",
+					  "ch12", "ch13", "ch14", "ch15",
+					  "ch16", "ch17", "ch18", "ch19",
+					  "ch20", "ch21", "ch22", "ch23",
+					  "ch24";
+			clocks = <&cpg CPG_MOD 812>;
+			power-domains = <&sysc 32>;
+			resets = <&cpg 812>;
+			phy-mode = "rgmii";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
 		scif0: serial at e6e60000 {
 			compatible = "renesas,scif-r8a77980",
 				     "renesas,rcar-gen3-scif",
