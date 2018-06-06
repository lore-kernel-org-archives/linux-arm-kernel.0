From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Wed, 6 Jun 2018 19:54:20 +0300
Subject: [PATCH 1/5] arm64: dts: renesas: r8a77980: add FCPVD support
In-Reply-To: <4fbd0895-c1ec-41fc-912d-8306dd933997@cogentembedded.com>
References: <4fbd0895-c1ec-41fc-912d-8306dd933997@cogentembedded.com>
Message-ID: <710fddfa-f1d5-9be1-62de-d42f19a2f1a9@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Describe FCPVD0 in the R8A77980 device tree; it will be used by VSPD0 in
the next patch...

Based on the original (and large) patch by Vladimir Barinov.

Signed-off-by: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
 arch/arm64/boot/dts/renesas/r8a77980.dtsi |    8 ++++++++
 1 file changed, 8 insertions(+)

Index: renesas/arch/arm64/boot/dts/renesas/r8a77980.dtsi
===================================================================
--- renesas.orig/arch/arm64/boot/dts/renesas/r8a77980.dtsi
+++ renesas/arch/arm64/boot/dts/renesas/r8a77980.dtsi
@@ -653,6 +653,14 @@
 			resets = <&cpg 408>;
 		};
 
+		fcpvd0: fcp at fea27000 {
+			compatible = "renesas,fcpv";
+			reg = <0 0xfea27000 0 0x200>;
+			clocks = <&cpg CPG_MOD 603>;
+			power-domains = <&sysc R8A77980_PD_ALWAYS_ON>;
+			resets = <&cpg 603>;
+		};
+
 		prr: chipid at fff00044 {
 			compatible = "renesas,prr";
 			reg = <0 0xfff00044 0 4>;
