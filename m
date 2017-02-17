From: fabrice.gasnier@st.com (Fabrice Gasnier)
Date: Fri, 17 Feb 2017 17:03:48 +0100
Subject: [RFC 3/4] dt-bindings: iio: add support for GPIO triggers
In-Reply-To: <1487347429-31761-1-git-send-email-fabrice.gasnier@st.com>
References: <1487347429-31761-1-git-send-email-fabrice.gasnier@st.com>
Message-ID: <1487347429-31761-4-git-send-email-fabrice.gasnier@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Document Industrial I/O GPIO trigger support.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 .../bindings/iio/trigger/iio-trig-gpio.txt         | 26 ++++++++++++++++++++++
 1 file changed, 26 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/trigger/iio-trig-gpio.txt

diff --git a/Documentation/devicetree/bindings/iio/trigger/iio-trig-gpio.txt b/Documentation/devicetree/bindings/iio/trigger/iio-trig-gpio.txt
new file mode 100644
index 0000000..a8dbf5c
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/trigger/iio-trig-gpio.txt
@@ -0,0 +1,26 @@
+Industrial I/O - GPIO based trigger
+
+GPIOs may be used as IIO trigger provider, when trigger is connected to
+GPIO lines.
+
+Required properties:
+- compatible: Should be "iio-gpio-trigger"
+- gpios: Should specify one GPIO line used as trigger source.
+  See Documentation/devicetree/bindings/gpio/gpio.txt
+- #io-trigger-cells: Should be 0, as simple trigger provider.
+  See Documentation/devicetree/bindings/iio/iio-bindings.txt
+
+Optional properties:
+- label: String to specifiy trigger name.
+- gpio-trigger-rising-edge: A rising edge on GPIO will trigger.
+- gpio-trigger-falling-edge: A falling edge on GPIO will trigger.
+  Note: Both rising and falling edge may be used. In case none of
+  rising or falling edge is selected, rising edge is selected by
+  default.
+
+Example:
+	gpiotrig0: iio-gpio-trigger0 {
+		#io-trigger-cells = <0>;
+		compatible = "iio-gpio-trigger";
+		gpios = <&gpioa 11 0>;
+	}
-- 
1.9.1
