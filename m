From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Thu, 16 Nov 2017 18:22:51 +0000
Subject: [PATCH v2 4/4] ARM: dts: r8a7745: add VIN dt support
In-Reply-To: <1510856571-30281-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1510856571-30281-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1510856571-30281-5-git-send-email-fabrizio.castro@bp.renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add VIN[01] support to SoC dt. Also, add aliases.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Biju Das <biju.das@bp.renesas.com>
---
This patch depends on the following patch:
* ARM: dts: r8a7745: Add CAN[01] SoC support
  https://patchwork.kernel.org/patch/10046867/

v1->v2:
* new patch to keep dt-bindings changes and all the related DT changes in the
  same series

 arch/arm/boot/dts/r8a7745.dtsi | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7745.dtsi b/arch/arm/boot/dts/r8a7745.dtsi
index 529e8c6..0fa7861 100644
--- a/arch/arm/boot/dts/r8a7745.dtsi
+++ b/arch/arm/boot/dts/r8a7745.dtsi
@@ -31,6 +31,8 @@
 		spi1 = &msiof0;
 		spi2 = &msiof1;
 		spi3 = &msiof2;
+		vin0 = &vin0;
+		vin1 = &vin1;
 	};
 
 	cpus {
@@ -837,6 +839,28 @@
 			status = "disabled";
 		};
 
+		vin0: video at e6ef0000 {
+			compatible = "renesas,vin-r8a7745",
+				     "renesas,rcar-gen2-vin";
+			reg = <0 0xe6ef0000 0 0x1000>;
+			interrupts = <GIC_SPI 188 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 811>;
+			power-domains = <&sysc R8A7745_PD_ALWAYS_ON>;
+			resets = <&cpg 811>;
+			status = "disabled";
+		};
+
+		vin1: video at e6ef1000 {
+			compatible = "renesas,vin-r8a7745",
+				     "renesas,rcar-gen2-vin";
+			reg = <0 0xe6ef1000 0 0x1000>;
+			interrupts = <GIC_SPI 189 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 810>;
+			power-domains = <&sysc R8A7745_PD_ALWAYS_ON>;
+			resets = <&cpg 810>;
+			status = "disabled";
+		};
+
 		du: display at feb00000 {
 			compatible = "renesas,du-r8a7745";
 			reg = <0 0xfeb00000 0 0x40000>;
-- 
2.7.4
