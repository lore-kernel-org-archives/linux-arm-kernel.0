From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Tue, 16 Jun 2015 02:43:51 +0300
Subject: [PATCH v2 2/2] ARM: shmobile: r8a7790: add EtherAVB DT support
In-Reply-To: <2857896.YA1bBSQVkA@wasted.cogentembedded.com>
References: <2857896.YA1bBSQVkA@wasted.cogentembedded.com>
Message-ID: <5039206.91vH9hDYGY@wasted.cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Define the generic R8A7790 part of the EtherAVB device node. 

Based on original patch by Mitsuhiro Kimura <mitsuhiro.kimura.kc@renesas.com>.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
Changes in version 2:
- changed the "compatible" property to match the driver;
- refreshed the patch.

 arch/arm/boot/dts/r8a7790.dtsi |   10 ++++++++++
 1 file changed, 10 insertions(+)

Index: renesas/arch/arm/boot/dts/r8a7790.dtsi
===================================================================
--- renesas.orig/arch/arm/boot/dts/r8a7790.dtsi
+++ renesas/arch/arm/boot/dts/r8a7790.dtsi
@@ -671,6 +671,16 @@
 		status = "disabled";
 	};
 
+	avb: ethernet at e6800000 {
+		compatible = "renesas,etheravb-r8a7790";
+		reg = <0 0xe6800000 0 0x800>, <0 0xee0e8000 0 0x4000>;
+		interrupts = <0 163 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp8_clks R8A7790_CLK_ETHERAVB>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "disabled";
+	};
+
 	sata0: sata at ee300000 {
 		compatible = "renesas,sata-r8a7790";
 		reg = <0 0xee300000 0 0x2000>;
