From: Frank.Li@freescale.com (Frank.Li at freescale.com)
Date: Fri, 29 May 2015 03:40:57 +0800
Subject: [PATCH 1/1] ARM: dts: imx7d: add watch dog support
Message-ID: <1432842057-21102-1-git-send-email-Frank.Li@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Frank Li <Frank.Li@freescale.com>

Enable watchdog support

Signed-off-by: Frank Li <Frank.Li@freescale.com>
---
 arch/arm/boot/dts/imx7d.dtsi | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/arch/arm/boot/dts/imx7d.dtsi b/arch/arm/boot/dts/imx7d.dtsi
index c42cf8d..b4cd8fd 100644
--- a/arch/arm/boot/dts/imx7d.dtsi
+++ b/arch/arm/boot/dts/imx7d.dtsi
@@ -212,6 +212,37 @@
 				#interrupt-cells = <2>;
 			};
 
+			wdog1: wdog at 30280000 {
+				compatible = "fsl,imx7d-wdt", "fsl,imx21-wdt";
+				reg = <0x30280000 0x10000>;
+				interrupts = <GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clks IMX7D_WDOG1_ROOT_CLK>;
+			};
+
+			wdog2: wdog at 30290000 {
+				compatible = "fsl,imx7d-wdt", "fsl,imx21-wdt";
+				reg = <0x30290000 0x10000>;
+				interrupts = <GIC_SPI 79 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clks IMX7D_WDOG2_ROOT_CLK>;
+				status = "disabled";
+			};
+
+			wdog3: wdog at 302a0000 {
+				compatible = "fsl,imx7d-wdt", "fsl,imx21-wdt";
+				reg = <0x302a0000 0x10000>;
+				interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clks IMX7D_WDOG3_ROOT_CLK>;
+				status = "disabled";
+			};
+
+			wdog4: wdog at 302b0000 {
+				compatible = "fsl,imx7d-wdt", "fsl,imx21-wdt";
+				reg = <0x302b0000 0x10000>;
+				interrupts = <GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clks IMX7D_WDOG4_ROOT_CLK>;
+				status = "disabled";
+			};
+
 			gpt1: gpt at 302d0000 {
 				compatible = "fsl,imx7d-gpt", "fsl,imx6sx-gpt";
 				reg = <0x302d0000 0x10000>;
-- 
1.9.1
