From: chunkeey@googlemail.com (Christian Lamparter)
Date: Fri,  6 May 2016 13:10:19 +0200
Subject: [PATCH v7 1/3] gpio: dt-bindings: add wd,mbl-gpio bindings
In-Reply-To: <cover.1462372360.git.chunkeey@googlemail.com>
References: <cover.1462372360.git.chunkeey@googlemail.com>
Message-ID: <9bc9349d6e13d81c6200b0cd8fa20c76263043f6.1462372360.git.chunkeey@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the device tree bindings for the Western Digital's
MyBook Live memory-mapped GPIO controllers.

The gpios will be supported by gpio-mmio code of the
GPIO generic library.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Christian Lamparter <chunkeey@googlemail.com>
---
 .../devicetree/bindings/gpio/wd,mbl-gpio.txt       | 38 ++++++++++++++++++++++
 1 file changed, 38 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/wd,mbl-gpio.txt

diff --git a/Documentation/devicetree/bindings/gpio/wd,mbl-gpio.txt b/Documentation/devicetree/bindings/gpio/wd,mbl-gpio.txt
new file mode 100644
index 0000000..038c3a6
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/wd,mbl-gpio.txt
@@ -0,0 +1,38 @@
+Bindings for the Western Digital's MyBook Live memory-mapped GPIO controllers.
+
+The Western Digital MyBook Live has two memory-mapped GPIO controllers.
+Both GPIO controller only have a single 8-bit data register, where GPIO
+state can be read and/or written.
+
+Required properties:
+	- compatible: should be "wd,mbl-gpio"
+	- reg-names: must contain
+		"dat" - data register
+	- reg: address + size pairs describing the GPIO register sets;
+		order must correspond with the order of entries in reg-names
+	- #gpio-cells: must be set to 2. The first cell is the pin number and
+			the second cell is used to specify the GPIO polarity:
+			0 = active high
+			1 = active low
+	- gpio-controller: marks the device node as a GPIO controller.
+
+Optional properties:
+	- no-output: GPIOs are read-only.
+
+Examples:
+	GPIO0: gpio0 at e0000000 {
+		compatible = "wd,mbl-gpio";
+		reg-names = "dat";
+		reg = <0xe0000000 0x1>;
+		#gpio-cells = <2>;
+		gpio-controller;
+	};
+
+	GPIO1: gpio1 at e0100000 {
+		compatible = "wd,mbl-gpio";
+		reg-names = "dat";
+		reg = <0xe0100000 0x1>;
+		#gpio-cells = <2>;
+		gpio-controller;
+		no-output;
+	};
-- 
2.8.1
