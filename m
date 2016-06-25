From: megous@megous.com (megous at megous.com)
Date: Sat, 25 Jun 2016 05:45:02 +0200
Subject: [PATCH v2 05/14] dt-bindings: document SY8106A regulator driver
In-Reply-To: <20160625034511.7966-1-megous@megous.com>
References: <20160625034511.7966-1-megous@megous.com>
Message-ID: <20160625034511.7966-6-megous@megous.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ondrej Jirman <megous@megous.com>

This patch adds the binding documentation for the
sy8106a regulator driver.

Signed-off-by: Ondrej Jirman <megous@megous.com>
---
 .../bindings/regulator/sy8106a-regulator.txt        | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/sy8106a-regulator.txt

diff --git a/Documentation/devicetree/bindings/regulator/sy8106a-regulator.txt b/Documentation/devicetree/bindings/regulator/sy8106a-regulator.txt
new file mode 100644
index 0000000..1e623a34
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/sy8106a-regulator.txt
@@ -0,0 +1,21 @@
+SY8106A Voltage regulator
+
+Required properties:
+- compatible: Must be "silergy,sy8106a"
+- reg: I2C slave address - must be <0x65>
+
+Any property defined as part of the core regulator binding, defined in
+regulator.txt, can also be used.
+
+Example:
+
+	sy8106a {
+		compatible = "silergy,sy8106a";
+		reg = <0x65>;
+		regulator-name = "sy8106a-vdd";
+		regulator-min-microvolt = <1000000>;
+		regulator-max-microvolt = <1400000>;
+		regulator-ramp-delay = <200>;
+		regulator-boot-on;
+		regulator-always-on;
+	};
-- 
2.9.0
