From: hdegoede@redhat.com (Hans de Goede)
Date: Fri, 26 Jun 2015 12:59:14 +0200
Subject: [PATCH v3 1/4] ARM: dts: Add binding documentation for AXP20x pmic
 usb power supply
Message-ID: <1435316357-26606-1-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add binding documentation for the usb power supply part of the AXP20x pmic.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
-Split out into a separate patch from the actual driver commit
---
 .../bindings/power_supply/axp20x_usb_power.txt     | 34 ++++++++++++++++++++++
 1 file changed, 34 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power_supply/axp20x_usb_power.txt

diff --git a/Documentation/devicetree/bindings/power_supply/axp20x_usb_power.txt b/Documentation/devicetree/bindings/power_supply/axp20x_usb_power.txt
new file mode 100644
index 0000000..a84d801
--- /dev/null
+++ b/Documentation/devicetree/bindings/power_supply/axp20x_usb_power.txt
@@ -0,0 +1,34 @@
+AXP20x USB power supply
+
+Required Properties:
+-compatible: "x-powers,axp202-usb-power-supply"
+
+This node is a subnode of the axp20x PMIC.
+
+Example:
+
+axp209: pmic at 34 {
+	compatible = "x-powers,axp209";
+	reg = <0x34>;
+	interrupt-parent = <&nmi_intc>;
+	interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
+	interrupt-controller;
+	#interrupt-cells = <1>;
+
+	regulators {
+		x-powers,dcdc-freq = <1500>;
+
+		vdd_cpu: dcdc2 {
+			regulator-always-on;
+			regulator-min-microvolt = <1000000>;
+			regulator-max-microvolt = <1450000>;
+			regulator-name = "vdd-cpu";
+		};
+
+		...
+	};
+
+	usb_power_supply: usb_power_supply {
+		compatible = "x-powers,axp202-usb-power-supply";
+	};
+};
-- 
2.4.3
