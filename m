From: sre@kernel.org (Sebastian Reichel)
Date: Fri, 26 Dec 2014 13:34:52 +0100
Subject: [PATCH 1/3] DT Binding for omap3 temperature sensor
In-Reply-To: <1419597294-21487-1-git-send-email-sre@kernel.org>
References: <20141226102933.GA28778@amd>
 <1419597294-21487-1-git-send-email-sre@kernel.org>
Message-ID: <1419597294-21487-2-git-send-email-sre@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

OMAP34xx and OMAP36xx processors contain a register in the syscon area,
which can be used to determine the SoCs temperature. This provides a
DT binding specification for the temperature monitor.

Signed-off-by: Sebastian Reichel <sre@kernel.org>
---
 .../bindings/hwmon/omap3-temperature.txt           | 25 ++++++++++++++++++++++
 1 file changed, 25 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/omap3-temperature.txt

diff --git a/Documentation/devicetree/bindings/hwmon/omap3-temperature.txt b/Documentation/devicetree/bindings/hwmon/omap3-temperature.txt
new file mode 100644
index 0000000..99631ad
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/omap3-temperature.txt
@@ -0,0 +1,25 @@
+* OMAP3 temperature sensor
+
+The OMAP34xx and OMAP36xx processors contain a register in the syscon area,
+which can be used to determine the SoCs temperature.
+
+Requires node properties:
+- compatible :	should contain one of
+	- "ti,omap34xx-temperature-sensor" for OMAP34xx
+	- "ti,omap36xx-temperature-sensor" for OMAP36xx
+- syscon :	Should be a phandle to system configuration node which
+		encompases the temperature register
+- clocks :	Should contain 32KHz fclk clock specifier
+- clock-names :	Should contain clock names
+	- "fck" for the 32KHz fclk clock specifier
+
+Example for omap34xx:
+
+/ {
+	temperature-sensor {
+		compatible = "ti,omap34xx-temperature-sensor";
+		syscon = <&omap3_scm_general>;
+		clocks = <&ts_fck>;
+		clock-names = "fck";
+	};
+};
-- 
2.1.3
