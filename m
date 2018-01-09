From: quentin.schulz@free-electrons.com (Quentin Schulz)
Date: Tue,  9 Jan 2018 10:33:33 +0100
Subject: [PATCH v2 02/16] dt-bindings: iio: adc: add binding for X-Powers AXP
 PMICs ADC
In-Reply-To: <cover.1e46d70f7931be8154b450a2fcdf066450a1aa6f.1515486346.git-series.quentin.schulz@free-electrons.com>
References: <cover.1e46d70f7931be8154b450a2fcdf066450a1aa6f.1515486346.git-series.quentin.schulz@free-electrons.com>
Message-ID: <bef3ba5e4a2c47f13fa9ba8e6fb0267b7bb15026.1515486346.git-series.quentin.schulz@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

X-Powers PMICs have several ADC channels that can be used for different
purposes, e.g. PMIC internal temperature, battery voltage or AC current.

This is the documentation for AXP209, AXP221/223 ADC bindings.

Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
---
 Documentation/devicetree/bindings/iio/adc/axp20x_adc.txt | 39 +++++++++-
 1 file changed, 39 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/axp20x_adc.txt

diff --git a/Documentation/devicetree/bindings/iio/adc/axp20x_adc.txt b/Documentation/devicetree/bindings/iio/adc/axp20x_adc.txt
new file mode 100644
index 0000000..ed6d04e
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/axp20x_adc.txt
@@ -0,0 +1,39 @@
+* X-Powers AXP ADC bindings
+
+Required properties:
+  - compatible: should be one of:
+    - "x-powers,axp20x-adc",
+    - "x-powers,axp22x-adc",
+  - #io-channel-cells: should be 1,
+
+Example:
+
+&axp22x {
+	axp_adc: axp-adc {
+		compatible = "x-powers,axp22x-adc";
+		#io-channel-cells = <1>;
+	};
+};
+
+ADC channels and their indexes per variant:
+
+AXP209
+------
+ 0 | acin_v
+ 1 | acin_i
+ 2 | vbus_v
+ 3 | vbus_i
+ 4 | pmic_temp
+ 5 | gpio0_v
+ 6 | gpio1_v
+ 7 | ipsout_v
+ 8 | batt_v
+ 9 | batt_chrg_i
+10 | batt_dischrg_i
+
+AXP22x
+------
+ 0 | pmic_temp
+ 1 | batt_v
+ 2 | batt_chrg_i
+ 3 | batt_dischrg_i
-- 
git-series 0.9.1
