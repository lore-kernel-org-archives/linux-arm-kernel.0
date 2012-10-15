From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 15 Oct 2012 14:17:00 +0100
Subject: [PATCH 2/2] Documentation: Describe Device Tree bindings for GPIO
 Regulator driver
In-Reply-To: <1350307020-5910-1-git-send-email-lee.jones@linaro.org>
References: <1350307020-5910-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1350307020-5910-2-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here we specify all non-standard bindings which can be used when
requesting the use of an GPIO controlled regulator from Device Tree.

Mark Brown <broonie@opensource.wolfsonmicro.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 .../bindings/regulator/gpio-regulator.txt          |   25 ++++++++++++++++++++
 1 file changed, 25 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/gpio-regulator.txt

diff --git a/Documentation/devicetree/bindings/regulator/gpio-regulator.txt b/Documentation/devicetree/bindings/regulator/gpio-regulator.txt
new file mode 100644
index 0000000..5f77ee0
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/gpio-regulator.txt
@@ -0,0 +1,25 @@
+GPIO controlled regulators
+
+Required properties:
+- compatible            : Must be "regulator-gpio".
+
+Optional properties:
+- gpio-enable           : GPIO to use to enable/disable the regulator.
+- startup-delay-us      : Startup time in microseconds.
+- enable-active-high    : Polarity of GPIO is active high (default is low).
+
+Any property defined as part of the core regulator binding defined in
+regulator.txt can also be used.
+
+Example:
+
+	mmciv: gpio-regulator {
+		compatible = "regulator-gpio";
+		regulator-name = "mmci-gpio-supply";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <2600000>;
+		gpio = <&gpio0 24 0x4>;
+		startup-delay-us = <100000>;
+		enable-active-high;
+		regulator-boot-on;
+	};
-- 
1.7.9.5
