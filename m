From: jaghu@google.com (Jaghathiswari Rankappagounder Natarajan)
Date: Tue, 13 Dec 2016 23:55:01 -0800
Subject: [PATCH linux v1 1/4] Documentation: dt-bindings: Document bindings
 for seven segment display support
In-Reply-To: <1481702104-8617-1-git-send-email-jaghu@google.com>
References: <1481702104-8617-1-git-send-email-jaghu@google.com>
Message-ID: <1481702104-8617-2-git-send-email-jaghu@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This binding provides interface for adding clock, data and clear signal GPIO
lines to control seven segment display.

Signed-off-by: Jaghathiswari Rankappagounder Natarajan <jaghu@google.com>
---
 .../devicetree/bindings/misc/seven-seg-gpio.txt    | 27 ++++++++++++++++++++++
 1 file changed, 27 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/misc/seven-seg-gpio.txt

diff --git a/Documentation/devicetree/bindings/misc/seven-seg-gpio.txt b/Documentation/devicetree/bindings/misc/seven-seg-gpio.txt
new file mode 100644
index 0000000..9a4e255
--- /dev/null
+++ b/Documentation/devicetree/bindings/misc/seven-seg-gpio.txt
@@ -0,0 +1,27 @@
+This binding defines interface to add clock, data and clear GPIO lines required
+for seven segment display support.
+
+Required properties:
+- compatible : should be "seven-seg-gpio-dev".
+- clock-gpios :  Should specify the GPIO pin connected to the Clock line on the
+  hardware.
+- data-gpios : Should specify the GPIO pin connected to Data line on the
+  hardware.
+- clear-gpios : Should specify the GPIO pin connected to Clear line on the
+  hardware.
+
+Optional properties:
+- refresh-interval-ms : The interval at which to refresh the display.
+  If this property is not present, the default value is 1000.
+
+Examples:
+
+#include <dt-bindings/gpio/gpio.h>
+
+seven-seg-disp {
+	compatible = "seven-seg-gpio-dev";
+	refresh-interval-ms = "1000";
+	clock-gpios = <&gpio 0 GPIO_ACTIVE_LOW>;
+	data-gpios = <&gpio 1 GPIO_ACTIVE_HIGH>;
+	clear-gpios = <&gpio 2 GPIO_ACTIVE_HIGH>;
+};
--
2.8.0.rc3.226.g39d4020
