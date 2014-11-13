From: bhuvanchandra.dv@toradex.com (Bhuvanchandra DV)
Date: Thu, 13 Nov 2014 10:05:31 +0530
Subject: [RESEND PATCH V2 1/2] ARM: dts: vf-colibri: Add I2C support
In-Reply-To: <cover.1415852424.git.bhuvanchandra.dv@toradex.com>
References: <cover.1415852424.git.bhuvanchandra.dv@toradex.com>
Message-ID: <cd1efeb312d35f45fee426ab3783beff7af4d327.1415852425.git.bhuvanchandra.dv@toradex.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Acked-by: Stefan Agner <stefan@agner.ch>
Signed-off-by: Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>
---
 arch/arm/boot/dts/vf-colibri-eval-v3.dtsi |    6 +++++-
 arch/arm/boot/dts/vf-colibri.dtsi         |   13 +++++++++++++
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/vf-colibri-eval-v3.dtsi b/arch/arm/boot/dts/vf-colibri-eval-v3.dtsi
index 80e8fbc..7324bdc 100644
--- a/arch/arm/boot/dts/vf-colibri-eval-v3.dtsi
+++ b/arch/arm/boot/dts/vf-colibri-eval-v3.dtsi
@@ -33,6 +33,10 @@
 	status = "okay";
 };
 
+&i2c0 {
+	status = "okay";
+};
+
 &pwm0 {
 	status = "okay";
 };
@@ -51,4 +55,4 @@
 
 &uart2 {
 	status = "okay";
-};
\ No newline at end of file
+};
diff --git a/arch/arm/boot/dts/vf-colibri.dtsi b/arch/arm/boot/dts/vf-colibri.dtsi
index ab40367..471eec0 100644
--- a/arch/arm/boot/dts/vf-colibri.dtsi
+++ b/arch/arm/boot/dts/vf-colibri.dtsi
@@ -39,6 +39,12 @@
 	pinctrl-0 = <&pinctrl_fec1>;
 };
 
+&i2c0 {
+	clock-frequency = <400000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c0>;
+};
+
 &pwm0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pwm0>;
@@ -102,6 +108,13 @@
 			>;
 		};
 
+		pinctrl_i2c0: i2c0grp {
+			fsl,pins = <
+				VF610_PAD_PTB14__I2C0_SCL		0x37ff
+				VF610_PAD_PTB15__I2C0_SDA		0x37ff
+			>;
+		};
+
 		pinctrl_pwm0: pwm0grp {
 			fsl,pins = <
 				VF610_PAD_PTB0__FTM0_CH0		0x1182
-- 
1.7.9.5
