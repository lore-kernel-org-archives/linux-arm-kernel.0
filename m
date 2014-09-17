From: bhuvanchandra.dv@toradex.com (Bhuvanchandra DV)
Date: Wed, 17 Sep 2014 13:46:29 +0530
Subject: [PATCH 2/3] ARM: dts: vf610-colibri: Add PWM support
In-Reply-To: <cover.1410930820.git.bhuvanchandra.dv@toradex.com>
References: <cover.1410930820.git.bhuvanchandra.dv@toradex.com>
Message-ID: <819bd3bc9541ca53f005b7cf95bc890f1a9215e5.1410930820.git.bhuvanchandra.dv@toradex.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 The Colibri standard defines four pins as PWM outputs, two of them (PWM
 A and C) are routed to FTM instance 0 and the other two (PWM B and D)
 are routed to FTM instance 1. Hence enable both FTM instances for the
 Colibri module and mux the four pins accordingly.

Signed-off-by: Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>
---
 arch/arm/boot/dts/vf610-colibri-eval-v3.dts |    8 ++++++++
 arch/arm/boot/dts/vf610-colibri.dtsi        |   25 +++++++++++++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/arch/arm/boot/dts/vf610-colibri-eval-v3.dts b/arch/arm/boot/dts/vf610-colibri-eval-v3.dts
index 7fb3066..ba98039 100644
--- a/arch/arm/boot/dts/vf610-colibri-eval-v3.dts
+++ b/arch/arm/boot/dts/vf610-colibri-eval-v3.dts
@@ -44,3 +44,11 @@
 &uart2 {
 	status = "okay";
 };
+
+&pwm0 {
+	status = "okay";
+};
+
+&pwm1 {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/vf610-colibri.dtsi b/arch/arm/boot/dts/vf610-colibri.dtsi
index 0cd8343..9bd1415 100644
--- a/arch/arm/boot/dts/vf610-colibri.dtsi
+++ b/arch/arm/boot/dts/vf610-colibri.dtsi
@@ -69,6 +69,16 @@
 	status = "okay";
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
 &iomuxc {
 	vf610-colibri {
 		pinctrl_esdhc1: esdhc1grp {
@@ -119,5 +129,20 @@
 				VF610_PAD_PTD3__UART2_CTS		0x21a1
 			>;
 		};
+
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
 	};
 };
-- 
1.7.9.5
