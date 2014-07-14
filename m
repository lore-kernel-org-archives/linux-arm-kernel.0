From: stefan@agner.ch (Stefan Agner)
Date: Mon, 14 Jul 2014 09:48:28 +0200
Subject: [PATCH v2 1/4] ARM: dts: vf610: add FlexCAN node
In-Reply-To: <cover.1405322992.git.stefan@agner.ch>
References: <cover.1405322992.git.stefan@agner.ch>
Message-ID: <2be5a3885653a02dc07bf96ce086fddd71285f5a.1405322992.git.stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add FlexCAN node for the two FlexCAN IP instances in Vybrid.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 arch/arm/boot/dts/vf610.dtsi | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm/boot/dts/vf610.dtsi b/arch/arm/boot/dts/vf610.dtsi
index 3fb127a..9404853 100644
--- a/arch/arm/boot/dts/vf610.dtsi
+++ b/arch/arm/boot/dts/vf610.dtsi
@@ -14,6 +14,8 @@
 
 / {
 	aliases {
+		can0 = &can0;
+		can1 = &can1;
 		serial0 = &uart0;
 		serial1 = &uart1;
 		serial2 = &uart2;
@@ -103,6 +105,16 @@
 					<&clks VF610_CLK_DMAMUX1>;
 			};
 
+			can0: flexcan at 40020000 {
+				compatible = "fsl,vf610-flexcan";
+				reg = <0x40020000 0x4000>;
+				interrupts = <0 58 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clks VF610_CLK_FLEXCAN0>,
+					 <&clks VF610_CLK_FLEXCAN0>;
+				clock-names = "ipg", "per";
+				status = "disabled";
+			};
+
 			uart0: serial at 40027000 {
 				compatible = "fsl,vf610-lpuart";
 				reg = <0x40027000 0x1000>;
@@ -414,6 +426,17 @@
 				clock-names = "nfc";
 				status = "disabled";
 			};
+
+			can1: flexcan at 400d4000 {
+				compatible = "fsl,vf610-flexcan";
+				reg = <0x400d4000 0x4000>;
+				interrupts = <0 59 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clks VF610_CLK_FLEXCAN1>,
+					 <&clks VF610_CLK_FLEXCAN1>;
+				clock-names = "ipg", "per";
+				status = "disabled";
+			};
+
 		};
 	};
 };
-- 
2.0.1
