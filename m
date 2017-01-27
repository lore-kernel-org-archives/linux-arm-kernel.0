From: quentin.schulz@free-electrons.com (Quentin Schulz)
Date: Fri, 27 Jan 2017 09:54:34 +0100
Subject: [PATCH v2 01/25] dt-bindings: iio: adc: add AXP20X/AXP22X ADC DT
 binding
In-Reply-To: <20170127085458.18270-1-quentin.schulz@free-electrons.com>
References: <20170127085458.18270-1-quentin.schulz@free-electrons.com>
Message-ID: <20170127085458.18270-2-quentin.schulz@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The X-Powers AXP20X and AXP22X PMICs have multiple ADCs. They expose the
battery voltage, battery charge and discharge currents, AC-in and VBUS
voltages and currents, 2 GPIOs muxable in ADC mode and PMIC temperature.

This adds the device tree binding documentation for the X-Powers AXP20X
and AXP22X PMICs ADCs.

Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
Acked-by: Rob Herring <robh@kernel.org>
Acked-by: Chen-Yu Tsai <wens@csie.org>
Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---

v2:
 - removing io-channels from required properties,
 - update AXP ADC DT node name from axp209_adc to simply adc,

 .../devicetree/bindings/iio/adc/axp20x_adc.txt     | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/axp20x_adc.txt

diff --git a/Documentation/devicetree/bindings/iio/adc/axp20x_adc.txt b/Documentation/devicetree/bindings/iio/adc/axp20x_adc.txt
new file mode 100644
index 0000000..a071247
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/axp20x_adc.txt
@@ -0,0 +1,22 @@
+X-Powers AXP20X and AXP22X PMIC Analog to Digital Converter (ADC)
+
+The X-Powers AXP20X and AXP22X PMICs have multiple ADCs. They expose the
+battery voltage, battery charge and discharge currents, AC-in and VBUS
+voltages and currents, 2 GPIOs muxable in ADC mode and PMIC temperature.
+
+The AXP22X PMICs do not have all ADCs of the AXP20X though.
+
+Required properties:
+ - compatible, one of:
+			"x-powers,axp209-adc"
+			"x-powers,axp221-adc"
+
+This is a subnode of the AXP20X PMIC.
+
+Example:
+
+&axp209 {
+	axp209_adc: adc {
+		compatible = "x-powers,axp209-adc";
+	};
+};
-- 
2.9.3
