From: baruch@tkos.co.il (Baruch Siach)
Date: Tue,  2 Jan 2018 15:19:19 +0200
Subject: [PATCH 2/4] dt-bindings: gpio: add raspberry pi GPIO expander binding
In-Reply-To: <cover.1514898134.git.baruch@tkos.co.il>
References: <cover.1514898134.git.baruch@tkos.co.il>
Message-ID: <4ca1795c6e09eb89f481cdec55180b4f1165bbfd.1514898134.git.baruch@tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Raspberry Pi 3 GPIO expander is controlled by the VC4 firmware over
I2C. The firmware mailbox interface allows the ARM core to control the
GPIO lines.

Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
 .../bindings/gpio/brcm,bcm2835-expgpio.txt         | 24 ++++++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/brcm,bcm2835-expgpio.txt

diff --git a/Documentation/devicetree/bindings/gpio/brcm,bcm2835-expgpio.txt b/Documentation/devicetree/bindings/gpio/brcm,bcm2835-expgpio.txt
new file mode 100644
index 000000000000..55257f31a9be
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/brcm,bcm2835-expgpio.txt
@@ -0,0 +1,24 @@
+Raspberry Pi GPIO expander
+
+The Raspberry Pi 3 GPIO expander is controlled by the VC4 firmware. The
+firmware exposes a mailbox interface that allows the ARM core to control the
+GPIO lines on the expander.
+
+Required properties:
+
+- compatible : Should be "brcm,bcm2835-expgpio"
+- gpio-controller : Marks the device node as a gpio controller
+- #gpio-cells : Should be two.  The first cell is the pin number, and
+  the second cell is used to specify the gpio polarity:
+  0 = active high
+  1 = active low
+- firmware : Reference to the RPi firmware device node
+
+Example:
+
+expgpio: expgpio {
+	compatible = "brcm,bcm2835-expgpio";
+	gpio-controller;
+	#gpio-cells = <2>;
+	firmware = <&firmware>;
+};
-- 
2.15.1
