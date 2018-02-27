From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Tue, 27 Feb 2018 23:08:22 +0300
Subject: [PATCH v2 1/5] arm64: dts: renesas: r8a77970: add FCPVD support
In-Reply-To: <23a6ac28-134b-b5dd-69a7-910774c4b8c1@cogentembedded.com>
References: <23a6ac28-134b-b5dd-69a7-910774c4b8c1@cogentembedded.com>
Message-ID: <b28f97f3-cd84-07df-2645-1ff3a97c990f@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Describe FCPVD0 in the R8A77970 device tree; it will be used by VSPD0 in
the next patch...

Based on the original (and large) patch by Daisuke Matsushita
<daisuke.matsushita.ns@hitachi.com>.

Signed-off-by: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
 arch/arm64/boot/dts/renesas/r8a77970.dtsi |    8 ++++++++
 1 file changed, 8 insertions(+)

Index: renesas/arch/arm64/boot/dts/renesas/r8a77970.dtsi
===================================================================
--- renesas.orig/arch/arm64/boot/dts/renesas/r8a77970.dtsi
+++ renesas/arch/arm64/boot/dts/renesas/r8a77970.dtsi
@@ -612,6 +612,14 @@
 			#size-cells = <0>;
 			status = "disabled";
 		};
+
+		fcpvd0: fcp at fea27000 {
+			compatible = "renesas,fcpv";
+			reg = <0 0xfea27000 0 0x200>;
+			clocks = <&cpg CPG_MOD 603>;
+			power-domains = <&sysc R8A77970_PD_ALWAYS_ON>;
+			resets = <&cpg 603>;
+		};
 	};
 
 	timer {
