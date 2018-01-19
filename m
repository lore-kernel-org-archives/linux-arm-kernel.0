From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Fri, 19 Jan 2018 22:42:35 +0300
Subject: [PATCH 2/5] arm64: dts: renesass: r8a77970: add VSPD support
Message-ID: <20180119195432.374037342@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Describe VSPD0 in the R8A77970 device tree; it will be used by DU in
the next patch...

Based on the original (and large) patch by Daisuke Matsushita
<daisuke.matsushita.ns@hitachi.com>.

Signed-off-by: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
 arch/arm64/boot/dts/renesas/r8a77970.dtsi |   10 ++++++++++
 1 file changed, 10 insertions(+)

Index: renesas/arch/arm64/boot/dts/renesas/r8a77970.dtsi
===================================================================
--- renesas.orig/arch/arm64/boot/dts/renesas/r8a77970.dtsi
+++ renesas/arch/arm64/boot/dts/renesas/r8a77970.dtsi
@@ -620,6 +620,16 @@
 			power-domains = <&sysc R8A77970_PD_ALWAYS_ON>;
 			resets = <&cpg 603>;
 		};
+
+		vspd0: vsp at fea20000 {
+			compatible = "renesas,vsp2";
+			reg = <0 0xfea20000 0 0x4000>;
+			interrupts = <GIC_SPI 169 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 623>;
+			power-domains = <&sysc R8A77970_PD_ALWAYS_ON>;
+			resets = <&cpg 623>;
+			renesas,fcp = <&fcpvd0>;
+		};
 	};
 
 	timer {
