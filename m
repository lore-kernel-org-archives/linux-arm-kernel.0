From: benjamin.gaignard@linaro.org (Benjamin Gaignard)
Date: Fri,  2 Dec 2016 11:17:18 +0100
Subject: [PATCH v3 3/7] PWM: add pwm-stm32 DT bindings
In-Reply-To: <1480673842-20804-1-git-send-email-benjamin.gaignard@st.com>
References: <1480673842-20804-1-git-send-email-benjamin.gaignard@st.com>
Message-ID: <1480673842-20804-4-git-send-email-benjamin.gaignard@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Define bindings for pwm-stm32

version 2:
- use parameters instead of compatible of handle the hardware configuration

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
---
 .../devicetree/bindings/pwm/pwm-stm32.txt          | 38 ++++++++++++++++++++++
 1 file changed, 38 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/pwm-stm32.txt

diff --git a/Documentation/devicetree/bindings/pwm/pwm-stm32.txt b/Documentation/devicetree/bindings/pwm/pwm-stm32.txt
new file mode 100644
index 0000000..575b9fb
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/pwm-stm32.txt
@@ -0,0 +1,38 @@
+STMicroelectronics PWM driver bindings for STM32
+
+Must be a sub-node of STM32 general purpose timer driver
+Parent node properties are describe in ../mfd/stm32-general-purpose-timer.txt
+
+Required parameters:
+- compatible:		Must be "st,stm32-pwm"
+- pinctrl-names: 	Set to "default".
+- pinctrl-0: 		List of phandles pointing to pin configuration nodes
+			for PWM module.
+			For Pinctrl properties, please refer to [1].
+
+Optional parameters:
+- st,breakinput:	Set if the hardware have break input capabilities
+- st,breakinput-polarity: Set break input polarity. Default is 0
+			 The value define the active polarity:
+			  - 0 (active LOW)
+			  - 1 (active HIGH)
+- st,pwm-num-chan:	Number of available PWM channels.  Default is 0.
+- st,32bits-counter:	Set if the hardware have a 32 bits counter
+- st,complementary:	Set if the hardware have complementary output channels
+
+[1] Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt
+
+Example:
+	gptimer1: gptimer1 at 40010000 {
+		compatible = "st,stm32-gptimer";
+		reg = <0x40010000 0x400>;
+		clocks = <&rcc 0 160>;
+		clock-names = "clk_int";
+
+		pwm1 at 0 {
+			compatible = "st,stm32-pwm";
+			st,pwm-num-chan = <4>;
+			st,breakinput;
+			st,complementary;
+		};
+	};
-- 
1.9.1
