From: festevam@gmail.com (Fabio Estevam)
Date: Wed,  8 Apr 2015 21:41:53 -0300
Subject: [PATCH] ARM: dts: imx6qdl-hummingboard: Add PCIe support
Message-ID: <1428540113-24616-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Add PCIe support. Based on a patch from Rabeeh Khoury from the solid-run
tree.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/boot/dts/imx6qdl-hummingboard.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl-hummingboard.dtsi b/arch/arm/boot/dts/imx6qdl-hummingboard.dtsi
index 151a3db..ccdfcfa 100644
--- a/arch/arm/boot/dts/imx6qdl-hummingboard.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-hummingboard.dtsi
@@ -192,6 +192,12 @@
 			>;
 		};
 
+		pinctrl_hummingboard_pcie_reset: hummingboard-pcie-reset {
+			fsl,pins = <
+				MX6QDL_PAD_EIM_DA4__GPIO3_IO04 0x1b0b1
+			>;
+		};
+
 		pinctrl_hummingboard_pwm1: pwm1grp {
 			fsl,pins = <MX6QDL_PAD_DISP0_DAT8__PWM1_OUT 0x1b0b1>;
 		};
@@ -245,6 +251,13 @@
 	};
 };
 
+&pcie {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_hummingboard_pcie_reset>;
+	reset-gpio = <&gpio3 4 0>;
+	status = "okay";
+};
+
 &pwm1 {
 	 pinctrl-names = "default";
 	 pinctrl-0 = <&pinctrl_hummingboard_pwm1>;
-- 
1.9.1
