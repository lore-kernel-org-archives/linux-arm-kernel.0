From: marex@denx.de (Marek Vasut)
Date: Fri,  8 Jun 2012 20:57:10 +0200
Subject: [PATCH] MXS: Enable FLEXCAN for MXS/DT
Message-ID: <1339181830-22863-1-git-send-email-marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Detlev Zundel <dzu@denx.de>
CC: Dong Aisheng <b29396@freescale.com>
CC: Fabio Estevam <fabio.estevam@freescale.com>
Cc: Linux ARM kernel <linux-arm-kernel@lists.infradead.org>
CC: Shawn Guo <shawn.guo@linaro.org>
Cc: Stefano Babic <sbabic@denx.de>
Cc: Wolfgang Denk <wd@denx.de>
---
 arch/arm/boot/dts/imx28.dtsi |   18 ++++++++++++++++++
 arch/arm/mach-mxs/Kconfig    |    1 +
 2 files changed, 19 insertions(+)

diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
index 5053019..a40e30d 100644
--- a/arch/arm/boot/dts/imx28.dtsi
+++ b/arch/arm/boot/dts/imx28.dtsi
@@ -167,6 +167,22 @@
 					fsl,pull-up = <0>;
 				};
 
+				flexcan0_pins_a: flexcan0 at 0 {
+					reg = <0>;
+					fsl,pinmux-ids = <0x0161 0x0162>;
+					fsl,drive-strength = <2>;
+					fsl,voltage = <1>;
+					fsl,pull-up = <0>;
+				};
+
+				flexcan1_pins_a: flexcan1 at 0 {
+					reg = <0>;
+					fsl,pinmux-ids = <0x0121 0x0122>;
+					fsl,drive-strength = <2>;
+					fsl,voltage = <1>;
+					fsl,pull-up = <0>;
+				};
+
 				gpmi_pins_a: gpmi-nand at 0 {
 					reg = <0>;
 					fsl,pinmux-ids = <0x0000 0x0010 0x0020
@@ -295,12 +311,14 @@
 			};
 
 			can0: can@80032000 {
+				compatible = "fsl,p1010-flexcan";
 				reg = <0x80032000 2000>;
 				interrupts = <8>;
 				status = "disabled";
 			};
 
 			can1: can at 80034000 {
+				compatible = "fsl,p1010-flexcan";
 				reg = <0x80034000 2000>;
 				interrupts = <9>;
 				status = "disabled";
diff --git a/arch/arm/mach-mxs/Kconfig b/arch/arm/mach-mxs/Kconfig
index 91cf062..5451c07 100644
--- a/arch/arm/mach-mxs/Kconfig
+++ b/arch/arm/mach-mxs/Kconfig
@@ -18,6 +18,7 @@ config SOC_IMX28
 	select CPU_ARM926T
 	select HAVE_PWM
 	select PINCTRL_IMX28
+	select HAVE_CAN_FLEXCAN
 
 comment "MXS platforms:"
 
-- 
1.7.10
