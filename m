From: carlo@caione.org (Carlo Caione)
Date: Sat, 15 Mar 2014 16:43:39 +0100
Subject: [PATCH v2 2/8] mfd: AXP20x: Add bindings documentation
In-Reply-To: <1394898225-28452-1-git-send-email-carlo@caione.org>
References: <1394898225-28452-1-git-send-email-carlo@caione.org>
Message-ID: <1394898225-28452-3-git-send-email-carlo@caione.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Bindings documentation for the AXP20x driver. In this file also two
sub-nodes (PEK and regulators) are documented.

Signed-off-by: Carlo Caione <carlo@caione.org>
---
 Documentation/devicetree/bindings/mfd/axp20x.txt   | 83 ++++++++++++++++++++++
 .../devicetree/bindings/vendor-prefixes.txt        |  1 +
 2 files changed, 84 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/axp20x.txt

diff --git a/Documentation/devicetree/bindings/mfd/axp20x.txt b/Documentation/devicetree/bindings/mfd/axp20x.txt
new file mode 100644
index 0000000..982aefe
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/axp20x.txt
@@ -0,0 +1,83 @@
+* axp20x device tree bindings
+
+The axp20x family current members :-
+axp202 (X-Powers)
+axp209 (X-Powers)
+
+Required properties:
+- compatible 			: Should be "x-powers,axp202" or "x-powers,axp209"
+- interrupt-controller 		: axp20x has its own internal IRQs
+- #interrupt-cells 		: Should be set to 1
+- interrupt-parent 		: The parent interrupt controller
+- interrupts 			: Interrupt specifiers for interrupt sources
+- reg 				: The I2C slave address for the AXP chip
+
+Sub-nodes:
+* regulators : Contain the regulator nodes. The regulators are bound using
+	       their name as listed here: dcdc2, dcdc3, ldo1, ldo2, ldo3,
+	       ldo4, ldo5.
+	       The bindings details of individual regulator device can be found in:
+	       Documentation/devicetree/bindings/regulator/regulator.txt with the
+	       exception of:
+
+	- dcdc-freq		: defines the work frequency of DC-DC in KHz
+				  (range: 750-1875). Default: 1.5MHz
+	- dcdc-workmode		: Optional. 1 for PWM mode, 0 for AUTO mode
+				  Default: AUTO mode
+
+Example:
+
+axp: axp20x at 34 {
+	reg = <0x34>;
+	interrupt-parent = <&nmi_intc>;
+	interrupts = <0 8>;
+
+	compatible = "x-powers,axp209";
+	interrupt-controller;
+	#interrupt-cells = <1>;
+
+	regulators {
+		dcdc-freq = "1500";
+
+		axp_dcdc2: dcdc2 {
+			regulator-min-microvolt = <700000>;
+			regulator-max-microvolt = <2275000>;
+			dcdc-workmode = <0>;
+			regulator-always-on;
+		};
+
+		axp_dcdc3: dcdc3 {
+			regulator-min-microvolt = <700000>;
+			regulator-max-microvolt = <3500000>;
+			dcdc-workmode = <0>;
+			regulator-always-on;
+		};
+
+		axp_ldo1: ldo1 {
+			regulator-min-microvolt = <1300000>;
+			regulator-max-microvolt = <1300000>;
+		};
+
+		axp_ldo2: ldo2 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <3300000>;
+			regulator-always-on;
+		};
+
+		axp_ldo3: ldo3 {
+			regulator-min-microvolt = <700000>;
+			regulator-max-microvolt = <3500000>;
+		};
+
+		axp_ldo4: ldo4 {
+			regulator-min-microvolt = <1250000>;
+			regulator-max-microvolt = <3300000>;
+		};
+
+		axp_ldo5: ldo5 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <3300000>;
+		};
+	};
+};
+
diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 40ce2df..d06ba8c 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -95,3 +95,4 @@ winbond Winbond Electronics corp.
 wlf	Wolfson Microelectronics
 wm	Wondermedia Technologies, Inc.
 xlnx	Xilinx
+x-powers	X-Powers
-- 
1.8.3.2
