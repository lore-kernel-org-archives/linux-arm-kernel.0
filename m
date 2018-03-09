From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Fri, 9 Mar 2018 15:06:32 +0300
Subject: [PATCH 1/3] arm64: dts: renesas: r8a77980: add PFC support
In-Reply-To: <88e52531-e538-8685-110a-1a2e79a3fe49@cogentembedded.com>
References: <88e52531-e538-8685-110a-1a2e79a3fe49@cogentembedded.com>
Message-ID: <e1130d4e-7c70-fe3d-1a09-349e95ad1b33@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Define the generic R8A77980 part of the PFC device node.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
 arch/arm64/boot/dts/renesas/r8a77980.dtsi |    5 +++++
 1 file changed, 5 insertions(+)

Index: renesas/arch/arm64/boot/dts/renesas/r8a77980.dtsi
===================================================================
--- renesas.orig/arch/arm64/boot/dts/renesas/r8a77980.dtsi
+++ renesas/arch/arm64/boot/dts/renesas/r8a77980.dtsi
@@ -71,6 +71,11 @@
 		#size-cells = <2>;
 		ranges;
 
+		pfc: pin-controller at e6060000 {
+			compatible = "renesas,pfc-r8a77980";
+			reg = <0 0xe6060000 0 0x50c>;
+		};
+
 		cpg: clock-controller at e6150000 {
 			compatible = "renesas,r8a77980-cpg-mssr";
 			reg = <0 0xe6150000 0 0x1000>;
