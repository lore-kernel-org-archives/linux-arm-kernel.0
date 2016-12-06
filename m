From: benjamin.gaignard@linaro.org (Benjamin Gaignard)
Date: Tue,  6 Dec 2016 13:38:45 +0100
Subject: [PATCH v4 3/7] PWM: add pwm-stm32 DT bindings
In-Reply-To: <1481027929-13704-1-git-send-email-benjamin.gaignard@st.com>
References: <1481027929-13704-1-git-send-email-benjamin.gaignard@st.com>
Message-ID: <1481027929-13704-4-git-send-email-benjamin.gaignard@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Define bindings for pwm-stm32

version 2:
- use parameters instead of compatible of handle the hardware configuration

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
---
 .../devicetree/bindings/pwm/pwm-stm32.txt          | 33 ++++++++++++++++++++++
 1 file changed, 33 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/pwm-stm32.txt

diff --git a/Documentation/devicetree/bindings/pwm/pwm-stm32.txt b/Documentation/devicetree/bindings/pwm/pwm-stm32.txt
new file mode 100644
index 0000000..c0cc246
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/pwm-stm32.txt
@@ -0,0 +1,33 @@
+STMicroelectronics STM32 General Purpose Timer PWM bindings
+
+Must be a sub-node of an STM32 General Purpose Timer device tree node.
+See ../mfd/stm32-general-purpose-timer.txt for details about the parent node.
+
+Required parameters:
+- compatible:		Must be "st,stm32-pwm".
+- pinctrl-names: 	Set to "default".
+- pinctrl-0: 		List of phandles pointing to pin configuration nodes for PWM module.
+			For Pinctrl properties see ../pinctrl/pinctrl-bindings.txt
+
+Optional parameters:
+- st,breakinput-polarity: If present, a break input is available
+            for the channel. In that case the property value denotes the
+            polarity of the break input:
+            - 0: active low
+            - 1: active high
+
+Example:
+	gptimer at 40010000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "st,stm32-gptimer";
+		reg = <0x40010000 0x400>;
+		clocks = <&rcc 0 160>;
+		clock-names = "clk_int";
+
+		pwm at 0 {
+			compatible = "st,stm32-pwm";
+			pinctrl-0	= <&pwm1_pins>;
+			pinctrl-names	= "default";
+		};
+	};
-- 
1.9.1
