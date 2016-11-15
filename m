From: fabrice.gasnier@st.com (Fabrice Gasnier)
Date: Tue, 15 Nov 2016 16:31:01 +0100
Subject: [PATCH v3 6/6] ARM: dts: stm32f429: enable adc on eval board
In-Reply-To: <1479223861-21747-1-git-send-email-fabrice.gasnier@st.com>
References: <1479223861-21747-1-git-send-email-fabrice.gasnier@st.com>
Message-ID: <1479223861-21747-7-git-send-email-fabrice.gasnier@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable analog to digital converter on stm32f429i-eval board.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 arch/arm/boot/dts/stm32429i-eval.dts | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm/boot/dts/stm32429i-eval.dts b/arch/arm/boot/dts/stm32429i-eval.dts
index 6bfc595..c144735 100644
--- a/arch/arm/boot/dts/stm32429i-eval.dts
+++ b/arch/arm/boot/dts/stm32429i-eval.dts
@@ -65,6 +65,20 @@
 		serial0 = &usart1;
 	};
 
+	regulators {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		reg_vref: regulator at 0 {
+			compatible = "regulator-fixed";
+			reg = <0>;
+			regulator-name = "vref";
+			regulator-min-microvolt = <3300000>;
+			regulator-max-microvolt = <3300000>;
+		};
+	};
+
 	leds {
 		compatible = "gpio-leds";
 		green {
@@ -123,3 +137,14 @@
 	pinctrl-names = "default";
 	status = "okay";
 };
+
+&adc {
+	pinctrl-names = "default";
+	pinctrl-0 = <&adc3_in8_pin>;
+	vref-supply = <&reg_vref>;
+	status = "okay";
+	adc3: adc at 200 {
+		st,adc-channels = <8>;
+		status = "okay";
+	};
+};
-- 
1.9.1
