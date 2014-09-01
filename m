From: tremyfr@gmail.com (Philippe Reynes)
Date: Mon,  1 Sep 2014 20:44:32 +0200
Subject: [PATCH v4] apf27dev: add max1027 in the dts
Message-ID: <1409597072-29196-1-git-send-email-tremyfr@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Philippe Reynes <tremyfr@gmail.com>
---
 arch/arm/boot/dts/imx27-apf27dev.dts |   17 +++++++++++++++++
 1 files changed, 17 insertions(+), 0 deletions(-)

Changelog:
v4: (thanks Shawn Guo for the feedback)
- put max1027 pinctl in the right place
- use 0x0 instead of 0

v3: (thanks Alexander Shiyan for the feedback)
- add datasheet pin name as comment

v2: (thanks Alexander Shiyan for the feedback)
- spi mode 0 is the default so no need to explicitly define it

diff --git a/arch/arm/boot/dts/imx27-apf27dev.dts b/arch/arm/boot/dts/imx27-apf27dev.dts
index b982309..bba3f41 100644
--- a/arch/arm/boot/dts/imx27-apf27dev.dts
+++ b/arch/arm/boot/dts/imx27-apf27dev.dts
@@ -82,6 +82,16 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_cspi1 &pinctrl_cspi1_cs>;
 	status = "okay";
+
+	adc at 0 {
+		compatible = "maxim,max1027";
+		reg = <0>;
+		interrupt-parent = <&gpio5>;
+		interrupts = <15 IRQ_TYPE_EDGE_FALLING>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_max1027>;
+		spi-max-frequency = <10000000>;
+	};
 };
 
 &cspi2 {
@@ -210,6 +220,13 @@
 			>;
 		};
 
+		pinctrl_max1027: max1027 {
+			 fsl,pins = <
+				 MX27_PAD_UART1_CTS__GPIO5_14 0x0 /* CNVST */
+				 MX27_PAD_UART1_RTS__GPIO5_15 0x0 /* EOC */
+			>;
+		};
+
 		pinctrl_pwm: pwmgrp {
 			fsl,pins = <
 				MX27_PAD_PWMO__PWMO 0x0
-- 
1.7.4.4
