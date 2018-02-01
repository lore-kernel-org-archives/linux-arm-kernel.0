From: fabrice.gasnier@st.com (Fabrice Gasnier)
Date: Thu, 1 Feb 2018 14:44:36 +0100
Subject: [PATCH 1/3] dt-bindings: pwm-stm32-lp: add #pwm-cells
In-Reply-To: <1517492678-767-1-git-send-email-fabrice.gasnier@st.com>
References: <1517492678-767-1-git-send-email-fabrice.gasnier@st.com>
Message-ID: <1517492678-767-2-git-send-email-fabrice.gasnier@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Gerald Baeza <gerald.baeza@st.com>

STM32 Low-Power Timer supports generic 3 cells pwm to encode
PWM number, period and polarity.

Signed-off-by: Gerald Baeza <gerald.baeza@st.com>
Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 Documentation/devicetree/bindings/pwm/pwm-stm32-lp.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/pwm/pwm-stm32-lp.txt b/Documentation/devicetree/bindings/pwm/pwm-stm32-lp.txt
index f8338d1..bd23302 100644
--- a/Documentation/devicetree/bindings/pwm/pwm-stm32-lp.txt
+++ b/Documentation/devicetree/bindings/pwm/pwm-stm32-lp.txt
@@ -7,6 +7,8 @@ See ../mfd/stm32-lptimer.txt for details about the parent node.
 
 Required parameters:
 - compatible:		Must be "st,stm32-pwm-lp".
+- #pwm-cells:		Should be set to 3. This PWM chip uses the default 3 cells
+			bindings defined in pwm.txt.
 
 Optional properties:
 - pinctrl-names: 	Set to "default".
@@ -18,6 +20,7 @@ Example:
 		...
 		pwm {
 			compatible = "st,stm32-pwm-lp";
+			#pwm-cells = <3>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&lppwm1_pins>;
 		};
-- 
1.9.1
