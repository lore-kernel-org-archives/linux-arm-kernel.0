From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Tue, 14 Jun 2016 11:13:22 +0200
Subject: [PATCH v3 14/14] regulator: pwm: Document pwm-dutycycle-unit and
 pwm-dutycycle-range
In-Reply-To: <1465895602-31008-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1465895602-31008-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1465895602-31008-15-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Document the pwm-dutycycle-unit and pwm-dutycycle-range properties.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
Acked-by: Brian Norris <briannorris@chromium.org>
---
 .../devicetree/bindings/regulator/pwm-regulator.txt   | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/Documentation/devicetree/bindings/regulator/pwm-regulator.txt b/Documentation/devicetree/bindings/regulator/pwm-regulator.txt
index ed936f0..9fbc7b1 100644
--- a/Documentation/devicetree/bindings/regulator/pwm-regulator.txt
+++ b/Documentation/devicetree/bindings/regulator/pwm-regulator.txt
@@ -34,6 +34,18 @@ Only required for Voltage Table Mode:
 			    First cell is voltage in microvolts (uV)
 			    Second cell is duty-cycle in percent (%)
 
+Optional properties for Continuous mode:
+- pwm-dutycycle-unit:	Integer value encoding the duty cycle unit. If not
+			defined, <100> is assumed, meaning that
+			pwm-dutycycle-range contains values expressed in
+			percent.
+
+- pwm-dutycycle-range:	Should contain 2 entries. The first entry is encoding
+			the dutycycle for regulator-min-microvolt and the
+			second one the dutycycle for regulator-max-microvolt.
+			Duty cycle values are expressed in pwm-dutycycle-unit.
+			If not defined, <0 100> is assumed.
+
 NB: To be clear, if voltage-table is provided, then the device will be used
 in Voltage Table Mode.  If no voltage-table is provided, then the device will
 be used in Continuous Voltage Mode.
@@ -48,6 +60,13 @@ Continuous Voltage Example:
 		regulator-min-microvolt = <1016000>;
 		regulator-max-microvolt = <1114000>;
 		regulator-name = "vdd_logic";
+		/* unit == per-mille */
+		pwm-dutycycle-unit = <1000>;
+		/*
+		 * Inverted PWM logic, and the duty cycle range is limited
+		 * to 30%-70%.
+		 */
+		pwm-dutycycle-range <700 300>; /* */
 	};
 
 Voltage Table Example:
-- 
2.7.4
