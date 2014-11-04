From: bhuvanchandra.dv@toradex.com (Bhuvanchandra DV)
Date: Tue, 4 Nov 2014 16:52:09 +0530
Subject: [PATCH 1/2] ARM: dts: vf-colibri: Add I2C support
In-Reply-To: <cover.1415099486.git.bhuvanchandra.dv@toradex.com>
References: <cover.1415099486.git.bhuvanchandra.dv@toradex.com>
Message-ID: <d5e07584708523262df69f5a4dec10609f77baa3.1415099486.git.bhuvanchandra.dv@toradex.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>
---
 arch/arm/boot/dts/vf-colibri-eval-v3.dtsi |    7 ++++++-
 arch/arm/boot/dts/vf-colibri.dtsi         |   13 +++++++++++++
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/vf-colibri-eval-v3.dtsi b/arch/arm/boot/dts/vf-colibri-eval-v3.dtsi
index 80e8fbc..0251e6c 100644
--- a/arch/arm/boot/dts/vf-colibri-eval-v3.dtsi
+++ b/arch/arm/boot/dts/vf-colibri-eval-v3.dtsi
@@ -33,6 +33,11 @@
 	status = "okay";
 };
 
+&i2c0 {
+	clock-frequency = <400000>;
+	status = "okay";
+};
+
 &pwm0 {
 	status = "okay";
 };
@@ -51,4 +56,4 @@
 
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
