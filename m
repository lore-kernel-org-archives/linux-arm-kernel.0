From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 15 Oct 2012 15:58:11 +0100
Subject: [PATCH 2/2] Documentation: Describe Device Tree bindings for
 GPIO Regulator driver
In-Reply-To: <1350307020-5910-2-git-send-email-lee.jones@linaro.org>
References: <1350307020-5910-1-git-send-email-lee.jones@linaro.org>
 <1350307020-5910-2-git-send-email-lee.jones@linaro.org>
Message-ID: <20121015145811.GA7662@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Author: Lee Jones <lee.jones@linaro.org>
Date:   Mon Oct 15 13:12:08 2012 +0100

    Documentation: Describe Device Tree bindings for GPIO Regulator driver
    
    Here we specify all non-standard bindings which can be used when
    requesting the use of an GPIO controlled regulator from Device Tree.
    
    Mark Brown <broonie@opensource.wolfsonmicro.com>
    Signed-off-by: Lee Jones <lee.jones@linaro.org>

diff --git a/Documentation/devicetree/bindings/regulator/gpio-regulator.txt b/Documentation/devicetree/bindings/regulator/gpio-regulator.txt
new file mode 100644
index 0000000..a7cdb6e
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/gpio-regulator.txt
@@ -0,0 +1,36 @@
+GPIO controlled regulators
+
+Required properties:
+- compatible            : Must be "regulator-gpio".
+
+Optional properties:
+- gpio-enable           : GPIO to use to enable/disable the regulator.
+- gpios           	: GPIO group used to control voltage.
+- states		: Selection of available voltages and GPIO configs.
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
+
+		regulator-name = "mmci-gpio-supply";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <2600000>;
+
+		gpio-enable = <&gpio0 23 0x4
+		gpios = <&gpio0 24 0x4
+			 &gpio0 25 0x4>;
+		states = <1800000 0x3
+			  2200000 0x2
+			  2600000 0x1
+			  2900000 0x0>;
+
+		startup-delay-us = <100000>;
+		enable-active-high;
+		regulator-boot-on;
+	};
