From: fabrice.gasnier@st.com (Fabrice Gasnier)
Date: Mon, 30 Jan 2017 15:33:58 +0100
Subject: [PATCH v2 3/5] Documentation: dt: iio: document stm32 exti trigger
In-Reply-To: <1485786840-4557-1-git-send-email-fabrice.gasnier@st.com>
References: <1485786840-4557-1-git-send-email-fabrice.gasnier@st.com>
Message-ID: <1485786840-4557-4-git-send-email-fabrice.gasnier@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add dt documentation for st,stm32-exti-trigger.
EXTi gpio signal can be routed internally as trigger source for various
IPs (e.g. for ADC or DAC conversions).

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 .../bindings/iio/trigger/st,stm32-exti-trigger.txt      | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/trigger/st,stm32-exti-trigger.txt

diff --git a/Documentation/devicetree/bindings/iio/trigger/st,stm32-exti-trigger.txt b/Documentation/devicetree/bindings/iio/trigger/st,stm32-exti-trigger.txt
new file mode 100644
index 0000000..ebf2645
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/trigger/st,stm32-exti-trigger.txt
@@ -0,0 +1,17 @@
+STMicroelectronics STM32 EXTI trigger bindings
+
+EXTi gpio signal can be routed internally as trigger source for various
+IPs (e.g. for ADC or DAC conversions).
+
+Contents of a stm32 exti trigger root node:
+-------------------------------------------
+Required properties:
+- compatible: Should be "st,stm32-exti-trigger"
+- extiN-gpio: optional gpio line that may be used as external trigger source
+  (e.g. N may be 0..15. For example, exti11-gpio can trig ADC on stm32f4).
+
+Example:
+	triggers {
+		compatible = "st,stm32-exti-trigger";
+		exti11-gpio=<&gpioa 11 0>;
+	};
-- 
1.9.1
