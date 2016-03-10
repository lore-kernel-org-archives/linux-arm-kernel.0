From: Gang.Liu@nxp.com (Liu Gang)
Date: Thu, 10 Mar 2016 16:57:19 +0800
Subject: [PATCH] gpio/ls1021a: Add gpio support for ls1021a platform
Message-ID: <1457600240-47141-1-git-send-email-Gang.Liu@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add gpio nodes for ls1021a platform dts file. The gpio
IP block of the ls1021a can be supported by the code
drivers/gpio/gpio-mpc8xxx.c.

Signed-off-by: Liu Gang <Gang.Liu@nxp.com>
---
 arch/arm/boot/dts/ls1021a.dtsi | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/arm/boot/dts/ls1021a.dtsi b/arch/arm/boot/dts/ls1021a.dtsi
index 2c84ca2..57915c2 100644
--- a/arch/arm/boot/dts/ls1021a.dtsi
+++ b/arch/arm/boot/dts/ls1021a.dtsi
@@ -332,6 +332,46 @@
 			status = "disabled";
 		};
 
+		gpio0: gpio at 2300000 {
+			compatible = "fsl,qoriq-gpio";
+			reg = <0x0 0x2300000 0x0 0x10000>;
+			interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
+		gpio1: gpio at 2310000 {
+			compatible = "fsl,qoriq-gpio";
+			reg = <0x0 0x2310000 0x0 0x10000>;
+			interrupts = <GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
+		gpio2: gpio at 2320000 {
+			compatible = "fsl,qoriq-gpio";
+			reg = <0x0 0x2320000 0x0 0x10000>;
+			interrupts = <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
+		gpio3: gpio at 2330000 {
+			compatible = "fsl,qoriq-gpio";
+			reg = <0x0 0x2330000 0x0 0x10000>;
+			interrupts = <GIC_SPI 166 IRQ_TYPE_LEVEL_HIGH>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
 		lpuart0: serial at 2950000 {
 			compatible = "fsl,ls1021a-lpuart";
 			reg = <0x0 0x2950000 0x0 0x1000>;
-- 
2.1.0.27.g96db324
