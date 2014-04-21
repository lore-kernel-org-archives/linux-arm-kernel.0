From: marex@denx.de (Marek Vasut)
Date: Mon, 21 Apr 2014 22:56:49 +0200
Subject: [PATCH] ARM: dts: imx6qdl-sabresd: Add PCIe support
Message-ID: <1398113809-7580-1-git-send-email-marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for the PCI express bus available on MX6 SabreSDP.

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/boot/dts/imx6qdl-sabresd.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
index 7a88d9a..0d43e37 100644
--- a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
@@ -384,6 +384,13 @@
 			>;
 		};
 
+		pinctrl_pcie: pciegrp {
+			fsl,pins = <
+				MX6QDL_PAD_EIM_D19__GPIO3_IO19	0x80000000
+				MX6QDL_PAD_GPIO_17__GPIO7_IO12	0x80000000
+			>;
+		};
+
 		pinctrl_pwm1: pwm1grp {
 			fsl,pins = <
 				MX6QDL_PAD_SD1_DAT3__PWM1_OUT		0x1b0b1
@@ -468,6 +475,14 @@
 	};
 };
 
+&pcie {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pcie>;
+	power-on-gpio = <&gpio3 19 0>;
+	reset-gpio = <&gpio7 12 0>;
+	status = "okay";
+};
+
 &pwm1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pwm1>;
-- 
1.9.1
