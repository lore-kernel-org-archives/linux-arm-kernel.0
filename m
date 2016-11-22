From: benjamin.gaignard@linaro.org (Benjamin Gaignard)
Date: Tue, 22 Nov 2016 17:13:23 +0100
Subject: [PATCH 3/7] add pwm-stm32 DT bindings
In-Reply-To: <1479831207-32699-1-git-send-email-benjamin.gaignard@st.com>
References: <1479831207-32699-1-git-send-email-benjamin.gaignard@st.com>
Message-ID: <1479831207-32699-4-git-send-email-benjamin.gaignard@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Define binding for pwm-stm32

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
---
 .../devicetree/bindings/pwm/pwm-stm32.txt          | 43 ++++++++++++++++++++++
 1 file changed, 43 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/pwm-stm32.txt

diff --git a/Documentation/devicetree/bindings/pwm/pwm-stm32.txt b/Documentation/devicetree/bindings/pwm/pwm-stm32.txt
new file mode 100644
index 0000000..819e024
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/pwm-stm32.txt
@@ -0,0 +1,43 @@
+STMicroelectronics PWM driver bindings for STM32
+--------------------------------------
+
+Must be a child of STM32 multifunctions timer driver
+
+Required parameters:
+- compatible :		"st,stm32-pwm1"
+			"st,stm32-pwm2"
+			"st,stm32-pwm3"
+			"st,stm32-pwm4"
+			"st,stm32-pwm5"
+			"st,stm32-pwm8"
+			"st,stm32-pwm9"
+			"st,stm32-pwm10"
+			"st,stm32-pwm11"
+			"st,stm32-pwm12"
+			"st,stm32-pwm13"
+			"st,stm32-pwm14"
+- pinctrl-names: 	Set to "default".
+- pinctrl-0: 		List of phandles pointing to pin configuration nodes
+			for PWM module.
+			For Pinctrl properties, please refer to [1].
+
+Optional parameters:
+- st,breakinput-polarity if set enable break input feature.
+			 The value define the active polarity:
+			  - 0 (active LOW)
+			  - 1 (active HIGH)
+
+[1] Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt
+
+Example:
+	mfd_timer1: mfdtimer1 at 40010000 {
+		compatible = "st,stm32-mfd-timer1";
+		reg = <0x40010000 0x400>;
+		clocks = <&rcc 0 160>;
+		clock-names = "mfd_timer_clk";
+		interrupts = <27>;
+
+		pwm1: pwm1 at 40010000 {
+			compatible = "st,stm32-pwm1";
+		};
+	};
-- 
1.9.1
