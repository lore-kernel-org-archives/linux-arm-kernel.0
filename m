From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Fri, 10 Nov 2017 23:02:19 +0300
Subject: [PATCH 1/3] arm64: dts: renesas: r8a77970: add PFC support
Message-ID: <20171110200705.772746681@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Define the generic R8A77970 part of the PFC device node.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
 arch/arm64/boot/dts/renesas/r8a77970.dtsi |    5 +++++
 1 file changed, 5 insertions(+)

Index: renesas/arch/arm64/boot/dts/renesas/r8a77970.dtsi
===================================================================
--- renesas.orig/arch/arm64/boot/dts/renesas/r8a77970.dtsi
+++ renesas/arch/arm64/boot/dts/renesas/r8a77970.dtsi
@@ -134,6 +134,11 @@
 			#power-domain-cells = <1>;
 		};
 
+		pfc: pin-controller at e6060000 {
+			compatible = "renesas,pfc-r8a77970";
+			reg = <0 0xe6060000 0 0x504>;
+		};
+
 		intc_ex: interrupt-controller at e61c0000 {
 			compatible = "renesas,intc-ex-r8a77970", "renesas,irqc";
 			#interrupt-cells = <2>;
