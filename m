From: quentin.schulz@free-electrons.com (Quentin Schulz)
Date: Fri,  1 Dec 2017 14:44:44 +0100
Subject: [PATCH v4 03/10] dt-bindings: gpio: gpio-axp209: add pinctrl features
In-Reply-To: <cover.3ff63fdf302c6bda02ea7d160ad2aa5afee0899d.1512135804.git-series.quentin.schulz@free-electrons.com>
References: <cover.3ff63fdf302c6bda02ea7d160ad2aa5afee0899d.1512135804.git-series.quentin.schulz@free-electrons.com>
Message-ID: <7fdc42fd2d3572069292ebe1376bb446beb4d8a9.1512135804.git-series.quentin.schulz@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The X-Powers AXP209 has 3 GPIOs. GPIO0/1 can each act either as a GPIO,
an ADC or a LDO regulator. GPIO2 can only act as a GPIO.

This adds the pinctrl features to the driver so GPIO0/1 can be used as
ADC or LDO regulator.

Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/gpio/gpio-axp209.txt | 28 ++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/gpio/gpio-axp209.txt b/Documentation/devicetree/bindings/gpio/gpio-axp209.txt
index a661130..4705020 100644
--- a/Documentation/devicetree/bindings/gpio/gpio-axp209.txt
+++ b/Documentation/devicetree/bindings/gpio/gpio-axp209.txt
@@ -1,4 +1,4 @@
-AXP209 GPIO controller
+AXP209 GPIO & pinctrl controller
 
 This driver follows the usual GPIO bindings found in
 Documentation/devicetree/bindings/gpio/gpio.txt
@@ -28,3 +28,29 @@ axp209: pmic at 34 {
 		#gpio-cells = <2>;
 	};
 };
+
+The GPIOs can be muxed to other functions and therefore, must be a subnode of
+axp_gpio.
+
+Example:
+
+&axp_gpio {
+	gpio0_adc: gpio0-adc {
+		pins = "GPIO0";
+		function = "adc";
+	};
+};
+
+&example_node {
+	pinctrl-names = "default";
+	pinctrl-0 = <&gpio0_adc>;
+};
+
+GPIOs and their functions
+-------------------------
+
+GPIO	|	Functions
+------------------------
+GPIO0	|	gpio_in, gpio_out, ldo, adc
+GPIO1	|	gpio_in, gpio_out, ldo, adc
+GPIO2	|	gpio_in, gpio_out
-- 
git-series 0.9.1
