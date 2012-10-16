From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 16 Oct 2012 09:02:33 +0100
Subject: [PATCH 1/1] Documentation: Describe Device Tree bindings for GPIO
 Regulator driver
Message-ID: <1350374553-12678-1-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here we specify all non-standard bindings which can be used when
requesting the use of an GPIO controlled regulator from Device Tree.

Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 .../bindings/regulator/gpio-regulator.txt          |   36 ++++++++++++++++++++
 1 file changed, 36 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/gpio-regulator.txt

diff --git a/Documentation/devicetree/bindings/regulator/gpio-regulator.txt b/Documentation/devicetree/bindings/regulator/gpio-regulator.txt
new file mode 100644
index 0000000..3703be2
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/gpio-regulator.txt
@@ -0,0 +1,36 @@
+GPIO controlled regulators
+
+Required properties:
+- compatible		: Must be "regulator-gpio".
+
+Optional properties:
+- gpio-enable		: GPIO to use to enable/disable the regulator.
+- gpios			: GPIO group used to control voltage.
+- states		: Selection of available voltages and GPIO configs.
+- startup-delay-us	: Startup time in microseconds.
+- enable-active-high	: Polarity of GPIO is active high (default is low).
+
+Any property defined as part of the core regulator binding defined in
+regulator.txt can also be used.
+
+Example:
+
+	mmciv: gpio-regulator {
+		compatible = "regulator-gpio";
+
+		regulator-name = "mmci-gpio-supply";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <2600000>;
+		regulator-boot-on;
+
+		gpio-enable = <&gpio0 23 0x4>;
+		gpios = <&gpio0 24 0x4
+			 &gpio0 25 0x4>;
+		states = <1800000 0x3
+			  2200000 0x2
+			  2600000 0x1
+			  2900000 0x0>;
+
+		startup-delay-us = <100000>;
+		enable-active-high;
+	};
-- 
1.7.9.5
