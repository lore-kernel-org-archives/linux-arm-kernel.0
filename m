From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu,  7 Dec 2017 10:53:48 +0100
Subject: [PATCH 45/54] arm64: dts: renesas: r8a77970: Add IPMMU device nodes
In-Reply-To: <cover.1512640145.git.horms+renesas@verge.net.au>
References: <cover.1512640145.git.horms+renesas@verge.net.au>
Message-ID: <ce3b52a1595b25b05df86388d08aa454a885349d.1512640145.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add r8a77970 IPMMU nodes and keep all disabled by default.

Based on work for the r8a7796 by Magnus Damm

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm64/boot/dts/renesas/r8a77970.dtsi | 47 +++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a77970.dtsi b/arch/arm64/boot/dts/renesas/r8a77970.dtsi
index 8b97842aedb7..5f73ee2dfd6d 100644
--- a/arch/arm64/boot/dts/renesas/r8a77970.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a77970.dtsi
@@ -12,6 +12,7 @@
 #include <dt-bindings/clock/renesas-cpg-mssr.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/power/r8a77970-sysc.h>
 
 / {
 	compatible = "renesas,r8a77970";
@@ -134,6 +135,52 @@
 			#power-domain-cells = <1>;
 		};
 
+		ipmmu_vi0: mmu at febd0000 {
+			compatible = "renesas,ipmmu-r8a77970";
+			reg = <0 0xfebd0000 0 0x1000>;
+			renesas,ipmmu-main = <&ipmmu_mm 9>;
+			power-domains = <&sysc R8A77970_PD_ALWAYS_ON>;
+			#iommu-cells = <1>;
+			status = "disabled";
+		};
+
+		ipmmu_ir: mmu at ff8b0000 {
+			compatible = "renesas,ipmmu-r8a77970";
+			reg = <0 0xff8b0000 0 0x1000>;
+			renesas,ipmmu-main = <&ipmmu_mm 3>;
+			power-domains = <&sysc R8A77970_PD_A3IR>;
+			#iommu-cells = <1>;
+			status = "disabled";
+		};
+
+		ipmmu_rt: mmu at ffc80000 {
+			compatible = "renesas,ipmmu-r8a77970";
+			reg = <0 0xffc80000 0 0x1000>;
+			renesas,ipmmu-main = <&ipmmu_mm 7>;
+			power-domains = <&sysc R8A77970_PD_ALWAYS_ON>;
+			#iommu-cells = <1>;
+			status = "disabled";
+		};
+
+		ipmmu_ds1: mmu at e7740000 {
+			compatible = "renesas,ipmmu-r8a77970";
+			reg = <0 0xe7740000 0 0x1000>;
+			renesas,ipmmu-main = <&ipmmu_mm 1>;
+			power-domains = <&sysc R8A77970_PD_ALWAYS_ON>;
+			#iommu-cells = <1>;
+			status = "disabled";
+		};
+
+		ipmmu_mm: mmu at e67b0000 {
+			compatible = "renesas,ipmmu-r8a77970";
+			reg = <0 0xe67b0000 0 0x1000>;
+			interrupts = <GIC_SPI 196 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 197 IRQ_TYPE_LEVEL_HIGH>;
+			power-domains = <&sysc R8A77970_PD_ALWAYS_ON>;
+			#iommu-cells = <1>;
+			status = "disabled";
+		};
+
 		intc_ex: interrupt-controller at e61c0000 {
 			compatible = "renesas,intc-ex-r8a77970", "renesas,irqc";
 			#interrupt-cells = <2>;
-- 
2.11.0
