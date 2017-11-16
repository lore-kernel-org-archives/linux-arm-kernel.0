From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Thu, 16 Nov 2017 18:22:50 +0000
Subject: [PATCH v2 3/4] ARM: dts: r8a7743: add VIN dt support
In-Reply-To: <1510856571-30281-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1510856571-30281-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1510856571-30281-4-git-send-email-fabrizio.castro@bp.renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add VIN[012] support to SoC dt. Also, add aliases.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Biju Das <biju.das@bp.renesas.com>
---
This patch depends on the following patches:
* ARM: dts: r8a7743: Add default PCIe bus clock
  https://patchwork.kernel.org/patch/10056485/
* ARM: dts: r8a7743: Add PCIe Controller device node
  https://patchwork.kernel.org/patch/10056487/

v1->v2:
* no difference

 arch/arm/boot/dts/r8a7743.dtsi | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7743.dtsi b/arch/arm/boot/dts/r8a7743.dtsi
index 9e26c40..c09c667 100644
--- a/arch/arm/boot/dts/r8a7743.dtsi
+++ b/arch/arm/boot/dts/r8a7743.dtsi
@@ -32,6 +32,9 @@
 		spi1 = &msiof0;
 		spi2 = &msiof1;
 		spi3 = &msiof2;
+		vin0 = &vin0;
+		vin1 = &vin1;
+		vin2 = &vin2;
 	};
 
 	cpus {
@@ -1037,6 +1040,39 @@
 			};
 		};
 
+		vin0: video at e6ef0000 {
+			compatible = "renesas,vin-r8a7743",
+				     "renesas,rcar-gen2-vin";
+			reg = <0 0xe6ef0000 0 0x1000>;
+			interrupts = <GIC_SPI 188 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 811>;
+			power-domains = <&sysc R8A7743_PD_ALWAYS_ON>;
+			resets = <&cpg 811>;
+			status = "disabled";
+		};
+
+		vin1: video at e6ef1000 {
+			compatible = "renesas,vin-r8a7743",
+				     "renesas,rcar-gen2-vin";
+			reg = <0 0xe6ef1000 0 0x1000>;
+			interrupts = <GIC_SPI 189 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 810>;
+			power-domains = <&sysc R8A7743_PD_ALWAYS_ON>;
+			resets = <&cpg 810>;
+			status = "disabled";
+		};
+
+		vin2: video at e6ef2000 {
+			compatible = "renesas,vin-r8a7743",
+				     "renesas,rcar-gen2-vin";
+			reg = <0 0xe6ef2000 0 0x1000>;
+			interrupts = <GIC_SPI 190 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 809>;
+			power-domains = <&sysc R8A7743_PD_ALWAYS_ON>;
+			resets = <&cpg 809>;
+			status = "disabled";
+		};
+
 		du: display at feb00000 {
 			compatible = "renesas,du-r8a7743";
 			reg = <0 0xfeb00000 0 0x40000>,
-- 
2.7.4
