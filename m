From: Andrei.Stefanescu@microchip.com (Andrei.Stefanescu at microchip.com)
Date: Tue, 20 Nov 2018 08:08:36 +0000
Subject: [PATCH v2 1/2] dt-bindings: gpio: add SAMA5D2 PIOBU support
In-Reply-To: <1542701330-23466-1-git-send-email-andrei.stefanescu@microchip.com>
References: <1542701330-23466-1-git-send-email-andrei.stefanescu@microchip.com>
Message-ID: <1542701330-23466-2-git-send-email-andrei.stefanescu@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch describes the compatible and the device tree
bindings necessary for the SAMA5D2 PIOBU GPIO.

Signed-off-by: Andrei Stefanescu <andrei.stefanescu@microchip.com>
---
 .../bindings/gpio/gpio-sama5d2-piobu.txt           | 31 ++++++++++++++++++++++
 1 file changed, 31 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/gpio-sama5d2-piobu.txt

diff --git a/Documentation/devicetree/bindings/gpio/gpio-sama5d2-piobu.txt b/Documentation/devicetree/bindings/gpio/gpio-sama5d2-piobu.txt
new file mode 100644
index 0000000..2e260e1
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/gpio-sama5d2-piobu.txt
@@ -0,0 +1,31 @@
+GPIO controller for SAMA5D2 PIOBU pins.
+
+These pins have the property of not losing their voltage
+during Backup/Self-refresh mode.
+
+These bindings should be set to a node in the dtsi file.
+
+Required properties:
+- compatible:		"syscon", "microchip,sama5d2-piobu"
+- #gpio-cells:		There are 2. The pin number is the
+			first, the second represents additional
+			parameters such as GPIO_ACTIVE_HIGH/LOW.
+- gpio-controller:	Marks the port as GPIO controller.
+
+Note that the driver uses syscon and should be the child of
+the syscon node.
+
+Example:
+
+	secumod at fc040000 {
+		compatible = "atmel,sama5d2-secumod", "syscon", "simple-mfd";
+		status = "okay";
+		reg = <0xfc040000 0x100>;
+
+		pioBU: piobu {
+			status = "okay";
+			compatible = "microchip,sama5d2-piobu";
+			gpio-controller;
+			#gpio-cells = <2>;
+		};
+	};
-- 
2.7.4
