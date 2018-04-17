From: fabrice.gasnier@st.com (Fabrice Gasnier)
Date: Tue, 17 Apr 2018 15:45:29 +0200
Subject: [PATCH 3/4] ARM: dts: stm32: add PWM and triggers on stm32mp157c-ev1
 board
In-Reply-To: <1523972730-29240-1-git-send-email-fabrice.gasnier@st.com>
References: <1523972730-29240-1-git-send-email-fabrice.gasnier@st.com>
Message-ID: <1523972730-29240-4-git-send-email-fabrice.gasnier@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

stm32mp157c evaluation board has TIM2_CH4, TIM8_CH4 and TIM12_CH1
available on GPIO expansion connector.
Add PWM and associated triggers (for ADC/DAC) on these timers.
Keep them disabled so these pins can be used as GPIOs by default.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 arch/arm/boot/dts/stm32mp157c-ev1.dts | 36 +++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/arm/boot/dts/stm32mp157c-ev1.dts b/arch/arm/boot/dts/stm32mp157c-ev1.dts
index 57e6dbc..2109558 100644
--- a/arch/arm/boot/dts/stm32mp157c-ev1.dts
+++ b/arch/arm/boot/dts/stm32mp157c-ev1.dts
@@ -19,3 +19,39 @@
 		serial0 = &uart4;
 	};
 };
+
+&timers2 {
+	status = "disabled";
+	pwm {
+		pinctrl-0 = <&pwm2_pins_a>;
+		pinctrl-names = "default";
+		status = "okay";
+	};
+	timer at 1 {
+		status = "okay";
+	};
+};
+
+&timers8 {
+	status = "disabled";
+	pwm {
+		pinctrl-0 = <&pwm8_pins_a>;
+		pinctrl-names = "default";
+		status = "okay";
+	};
+	timer at 7 {
+		status = "okay";
+	};
+};
+
+&timers12 {
+	status = "disabled";
+	pwm {
+		pinctrl-0 = <&pwm12_pins_a>;
+		pinctrl-names = "default";
+		status = "okay";
+	};
+	timer at 11 {
+		status = "okay";
+	};
+};
-- 
1.9.1
