From: fabrice.gasnier@st.com (Fabrice Gasnier)
Date: Mon, 28 Aug 2017 12:04:08 +0200
Subject: [RESEND PATCH v3 3/9] dt-bindings: pwm: Add STM32 LPTimer PWM binding
In-Reply-To: <1503914654-19963-1-git-send-email-fabrice.gasnier@st.com>
References: <1503914654-19963-1-git-send-email-fabrice.gasnier@st.com>
Message-ID: <1503914654-19963-4-git-send-email-fabrice.gasnier@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add documentation for STMicroelectronics STM32 Low-Power Timer
PWM binding.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
Acked-by: Rob Herring <robh@kernel.org>
---
Changes in v3:
- Rob's comment on node name: timer at ...

Changes in v2:
- s/Low Power/Low-Power/
- remove 0x in example (parent node)
- improve properties description
---
 .../devicetree/bindings/pwm/pwm-stm32-lp.txt       | 24 ++++++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/pwm-stm32-lp.txt

diff --git a/Documentation/devicetree/bindings/pwm/pwm-stm32-lp.txt b/Documentation/devicetree/bindings/pwm/pwm-stm32-lp.txt
new file mode 100644
index 0000000..f8338d1
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/pwm-stm32-lp.txt
@@ -0,0 +1,24 @@
+STMicroelectronics STM32 Low-Power Timer PWM
+
+STM32 Low-Power Timer provides single channel PWM.
+
+Must be a sub-node of an STM32 Low-Power Timer device tree node.
+See ../mfd/stm32-lptimer.txt for details about the parent node.
+
+Required parameters:
+- compatible:		Must be "st,stm32-pwm-lp".
+
+Optional properties:
+- pinctrl-names: 	Set to "default".
+- pinctrl-0: 		Phandle pointing to pin configuration node for PWM.
+
+Example:
+	timer at 40002400 {
+		compatible = "st,stm32-lptimer";
+		...
+		pwm {
+			compatible = "st,stm32-pwm-lp";
+			pinctrl-names = "default";
+			pinctrl-0 = <&lppwm1_pins>;
+		};
+	};
-- 
1.9.1
