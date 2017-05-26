From: uwe@kleine-koenig.org (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Fri, 26 May 2017 20:06:05 +0200
Subject: [PATCH 1/5] dts: gpio_atmel: adapt binding doc to reality
Message-ID: <20170526180609.2699-1-uwe@kleine-koenig.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The second cell in a gpio reference is used to pass GPIO_ACTIVE_LOW or
GPIO_ACTIVE_HIGH. The gpio device can also be used as irq controller and
a reference can contain the IRQ_TYPE_* values in the second cell.

Signed-off-by: Uwe Kleine-K?nig <uwe@kleine-koenig.org>
---
 Documentation/devicetree/bindings/gpio/gpio_atmel.txt | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/gpio/gpio_atmel.txt b/Documentation/devicetree/bindings/gpio/gpio_atmel.txt
index 85f8c0d084fa..b53fe3bce270 100644
--- a/Documentation/devicetree/bindings/gpio/gpio_atmel.txt
+++ b/Documentation/devicetree/bindings/gpio/gpio_atmel.txt
@@ -5,9 +5,16 @@ Required properties:
 - reg: Should contain GPIO controller registers location and length
 - interrupts: Should be the port interrupt shared by all the pins.
 - #gpio-cells: Should be two.  The first cell is the pin number and
-  the second cell is used to specify optional parameters (currently
-  unused).
+  the second cell is used to specify optional parameters to declare if the GPIO
+  is active high or low. See gpio.txt.
 - gpio-controller: Marks the device node as a GPIO controller.
+- interrupt-controller: Marks the device node as a GPIO controller.
+- #interrupt-cells: Should be two. The first cell is the pin number and the
+  second cell is used to specify irq type flags:
+      1 = low-to-high edge triggered.
+      2 = high-to-low edge triggered.
+      4 = active high level-sensitive.
+      8 = active low level-sensitive.
 
 optional properties:
 - #gpio-lines: Number of gpio if absent 32.
@@ -21,5 +28,7 @@ Example:
 		#gpio-cells = <2>;
 		gpio-controller;
 		#gpio-lines = <19>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
 	};
 
-- 
2.11.0
