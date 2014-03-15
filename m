From: carlo@caione.org (Carlo Caione)
Date: Sat, 15 Mar 2014 16:43:43 +0100
Subject: [PATCH v2 6/8] ARM: sunxi: dt: Add x-powers-axp209.dtsi file
In-Reply-To: <1394898225-28452-1-git-send-email-carlo@caione.org>
References: <1394898225-28452-1-git-send-email-carlo@caione.org>
Message-ID: <1394898225-28452-7-git-send-email-carlo@caione.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This dtsi describes the axp209 PMIC, and is to be included from inside
the i2c controller node to which the axp209 is connected.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Carlo Caione <carlo@caione.org>
---
 arch/arm/boot/dts/x-powers-axp209.dtsi | 60 ++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)
 create mode 100644 arch/arm/boot/dts/x-powers-axp209.dtsi

diff --git a/arch/arm/boot/dts/x-powers-axp209.dtsi b/arch/arm/boot/dts/x-powers-axp209.dtsi
new file mode 100644
index 0000000..d272e67
--- /dev/null
+++ b/arch/arm/boot/dts/x-powers-axp209.dtsi
@@ -0,0 +1,60 @@
+/*
+ * x-powers,axp209 common code to be include from inside the axp209 node
+ *
+ * Copyright 2014 - Carlo Caione <carlo@caione.org>
+ *
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
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
-- 
1.8.3.2
