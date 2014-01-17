From: b35083@freescale.com (Jingchang Lu)
Date: Fri, 17 Jan 2014 14:04:43 +0800
Subject: [PATCHv10 1/2] ARM: dts: vf610: Add eDMA node
In-Reply-To: <1389938684-29467-1-git-send-email-b35083@freescale.com>
References: <1389938684-29467-1-git-send-email-b35083@freescale.com>
Message-ID: <1389938684-29467-2-git-send-email-b35083@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jingchang Lu <b35083@freescale.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
no changes in v10.

changes in v9:
 remove include/dt-bindings/dma/vf610-edma.h, the request source ID
 is the same as SoC's reference manual.

changes in v8:
 describe dmamux info in edma node to avoid confusion.
 change eDMA requst source macro definitions.

 changes in v7:
 fix dmamux2 and dmamux3 register number.

 no changes in v2 ~ v6.

 arch/arm/boot/dts/vf610.dtsi | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm/boot/dts/vf610.dtsi b/arch/arm/boot/dts/vf610.dtsi
index 48dbfe5..8febb29f 100644
--- a/arch/arm/boot/dts/vf610.dtsi
+++ b/arch/arm/boot/dts/vf610.dtsi
@@ -88,6 +88,21 @@
 				arm,tag-latency = <2 2 2>;
 			};
 
+			edma0: dma-controller at 40018000 {
+				#dma-cells = <2>;
+				compatible = "fsl,vf610-edma";
+				reg = <0x40018000 0x2000>,
+					<0x40024000 0x1000>,
+					<0x40025000 0x1000>;
+				interrupts = <0 8 IRQ_TYPE_LEVEL_HIGH>,
+						<0 9 IRQ_TYPE_LEVEL_HIGH>;
+				interrupt-names = "edma-tx", "edma-err";
+				dma-channels = <32>;
+				clock-names = "dmamux0", "dmamux1";
+				clocks = <&clks VF610_CLK_DMAMUX0>,
+					<&clks VF610_CLK_DMAMUX1>;
+			};
+
 			uart0: serial at 40027000 {
 				compatible = "fsl,vf610-lpuart";
 				reg = <0x40027000 0x1000>;
@@ -263,6 +278,21 @@
 			reg = <0x40080000 0x80000>;
 			ranges;
 
+			edma1: dma-controller at 40098000 {
+				#dma-cells = <2>;
+				compatible = "fsl,vf610-edma";
+				reg = <0x40098000 0x2000>,
+					<0x400a1000 0x1000>,
+					<0x400a2000 0x1000>;
+				interrupts = <0 10 IRQ_TYPE_LEVEL_HIGH>,
+						<0 11 IRQ_TYPE_LEVEL_HIGH>;
+				interrupt-names = "edma-tx", "edma-err";
+				dma-channels = <32>;
+				clock-names = "dmamux0", "dmamux1";
+				clocks = <&clks VF610_CLK_DMAMUX2>,
+					<&clks VF610_CLK_DMAMUX3>;
+			};
+
 			uart4: serial at 400a9000 {
 				compatible = "fsl,vf610-lpuart";
 				reg = <0x400a9000 0x1000>;
-- 
1.8.0
