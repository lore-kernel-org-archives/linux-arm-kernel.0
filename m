From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 10 Sep 2012 22:35:40 +0200
Subject: [PATCH 2/3] gpio: 74x164: dts: Add documentation for the dt binding
In-Reply-To: <1347309341-15447-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1347309341-15447-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1347309341-15447-3-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 .../devicetree/bindings/gpio/gpio-74x164.txt       |   22 ++++++++++++++++++++
 1 file changed, 22 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/gpio-74x164.txt

diff --git a/Documentation/devicetree/bindings/gpio/gpio-74x164.txt b/Documentation/devicetree/bindings/gpio/gpio-74x164.txt
new file mode 100644
index 0000000..cc26080
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/gpio-74x164.txt
@@ -0,0 +1,22 @@
+* Generic 8-bits shift register GPIO driver
+
+Required properties:
+- compatible : Should be "fairchild,74hc595"
+- reg : chip select number
+- gpio-controller : Marks the device node as a gpio controller.
+- #gpio-cells : Should be two.  The first cell is the pin number and
+  the second cell is used to specify the gpio polarity:
+      0 = active high
+      1 = active low
+- registers-number: Number of daisy-chained shift registers
+
+Example:
+
+gpio5: gpio5 at 0 {
+	compatible = "fairchild,74hc595";
+	reg = <0>;
+	gpio-controller;
+	#gpio-cells = <2>;
+	registers-number = <4>;
+	spi-max-frequency = <100000>;
+};
-- 
1.7.9.5
