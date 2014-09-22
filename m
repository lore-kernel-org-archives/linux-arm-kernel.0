From: bhuvanchandra.dv@toradex.com (Bhuvanchandra DV)
Date: Mon, 22 Sep 2014 15:38:11 +0530
Subject: [PATCH v3 1/2] ARM: dts: vf610-colibri: Add PWM support
In-Reply-To: <cover.1411378369.git.bhuvanchandra.dv@toradex.com>
References: <cover.1411378369.git.bhuvanchandra.dv@toradex.com>
Message-ID: <d508a6ad39e07d5489c4b5110784902ab0241c44.1411378369.git.bhuvanchandra.dv@toradex.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Colibri standard defines four pins as PWM outputs, two of them (PWM
A and C) are routed to FTM instance 0 and the other two (PWM B and D)
are routed to FTM instance 1. Hence enable both FTM instances for the
Colibri module and mux the four pins accordingly.

Signed-off-by: Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>
---
 arch/arm/boot/dts/vf610-colibri-eval-v3.dts |    8 ++++++++
 arch/arm/boot/dts/vf610-colibri.dtsi        |   24 ++++++++++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/arch/arm/boot/dts/vf610-colibri-eval-v3.dts b/arch/arm/boot/dts/vf610-colibri-eval-v3.dts
index 7fb3066..00f63d9 100644
--- a/arch/arm/boot/dts/vf610-colibri-eval-v3.dts
+++ b/arch/arm/boot/dts/vf610-colibri-eval-v3.dts
@@ -33,6 +33,14 @@
 	status = "okay";
 };
 
+&pwm0 {
+	status = "okay";
+};
+
+&pwm1 {
+	status = "okay";
+};
+
 &uart0 {
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/vf610-colibri.dtsi b/arch/arm/boot/dts/vf610-colibri.dtsi
index 0cd8343..1f73c1c 100644
--- a/arch/arm/boot/dts/vf610-colibri.dtsi
+++ b/arch/arm/boot/dts/vf610-colibri.dtsi
@@ -44,6 +44,16 @@
 	arm,tag-latency = <3 2 3>;
 };
 
+&pwm0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pwm0>;
+};
+
+&pwm1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pwm1>;
+};
+
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_uart0>;
@@ -97,6 +107,20 @@
 			>;
 		};
 
+		pinctrl_pwm0: pwm0grp {
+			fsl,pins = <
+				VF610_PAD_PTB0__FTM0_CH0		0x1182
+				VF610_PAD_PTB1__FTM0_CH1		0x1182
+			>;
+		};
+
+		pinctrl_pwm1: pwm1grp {
+			fsl,pins = <
+				VF610_PAD_PTB8__FTM1_CH0		0x1182
+				VF610_PAD_PTB9__FTM1_CH1		0x1182
+			>;
+		};
+
 		pinctrl_uart0: uart0grp {
 			fsl,pins = <
 				VF610_PAD_PTB10__UART0_TX		0x21a2
-- 
1.7.9.5
