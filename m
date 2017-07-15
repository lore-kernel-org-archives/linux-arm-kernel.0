From: linus.walleij@linaro.org (Linus Walleij)
Date: Sat, 15 Jul 2017 19:50:52 +0200
Subject: [PATCH 1/5] pinctrl: Add DT bindings for Cortina Gemini
Message-ID: <20170715175056.13040-1-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Cortina Gemini pin controller uses the standard pin control
bindings for muxing functions with groups so these bindings
should be entirely uncontroversial.

Cc: devicetree at vger.kernel.org
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 .../bindings/pinctrl/cortina,gemini-pinctrl.txt    | 54 ++++++++++++++++++++++
 1 file changed, 54 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/cortina,gemini-pinctrl.txt

diff --git a/Documentation/devicetree/bindings/pinctrl/cortina,gemini-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/cortina,gemini-pinctrl.txt
new file mode 100644
index 000000000000..2ef3e8a65559
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/cortina,gemini-pinctrl.txt
@@ -0,0 +1,54 @@
+Cortina Systems Gemini pin controller
+
+This pin controller is found in the Cortina Systems Gemini SoC family,
+see further arm/gemini.txt. It is a purely group-based multiplexing pin
+controller.
+
+Required properties:
+- compatible: "cortina,gemini-pinctrl"
+- regmap: phandle to the system controller node
+
+Subnodes of the pin controller contain pin control multiplexing set-up.
+Please refer to pinctrl-bindings.txt for generic pin multiplexing nodes.
+
+Example:
+
+pinctrl {
+	compatible = "cortina,gemini-pinctrl";
+	regmap = <&syscon>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&dram_default_pins>, <&system_default_pins>,
+		    <&vcontrol_default_pins>;
+
+	dram_default_pins: pinctrl-dram {
+		mux {
+			function = "dram";
+			groups = "dramgrp";
+		};
+	};
+	rtc_default_pins: pinctrl-rtc {
+		mux {
+			function = "rtc";
+			groups = "rtcgrp";
+		};
+	};
+	power_default_pins: pinctrl-power {
+		mux {
+			function = "power";
+			groups = "powergrp";
+		};
+	};
+	system_default_pins: pinctrl-system {
+		mux {
+			function = "system";
+			groups = "systemgrp";
+		};
+	};
+	(...)
+	uart_default_pins: pinctrl-uart {
+		mux {
+			function = "uart";
+			groups = "uartrxtxgrp";
+		};
+	};
+};
-- 
2.9.4
