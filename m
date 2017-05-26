From: uwe@kleine-koenig.org (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 26 May 2017 21:07:03 +0200
Subject: [PATCH v2 1/5] dts: gpio_atmel: adapt binding doc to reality
In-Reply-To: <20170526185214.GB20946@lunn.ch>
Message-ID: <20170526190703.t5fab33peh2cmobm@taurus.defre.kleine-koenig.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The second cell in a gpio reference is used to pass GPIO_ACTIVE_LOW or
GPIO_ACTIVE_HIGH. The gpio device can also be used as irq controller and
a reference can contain the IRQ_TYPE_* values in the second cell.

Signed-off-by: Uwe Kleine-K?nig <uwe@kleine-koenig.org>
---
On Fri, May 26, 2017 at 08:52:14PM +0200, Andrew Lunn wrote:
> > +- interrupt-controller: Marks the device node as a GPIO controller.
> 
> Interrupt controller, not GPIO controller.
> 
> > +- #interrupt-cells: Should be two. The first cell is the pin number and the
> > +  second cell is used to specify irq type flags:
> > +      1 = low-to-high edge triggered.
> > +      2 = high-to-low edge triggered.
> > +      4 = active high level-sensitive.
> > +      8 = active low level-sensitive.
> 
> Maybe just reference interrupts.txt?

ack for both and changed in this v2.

Thanks
Uwe

 Documentation/devicetree/bindings/gpio/gpio_atmel.txt | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/gpio/gpio_atmel.txt b/Documentation/devicetree/bindings/gpio/gpio_atmel.txt
--- a/Documentation/devicetree/bindings/gpio/gpio_atmel.txt
+++ b/Documentation/devicetree/bindings/gpio/gpio_atmel.txt
@@ -5,9 +5,13 @@ Required properties:
 - reg: Should contain GPIO controller registers location and length
 - interrupts: Should be the port interrupt shared by all the pins.
 - #gpio-cells: Should be two.  The first cell is the pin number and
-  the second cell is used to specify optional parameters (currently
-  unused).
+  the second cell is used to specify optional parameters to declare if the GPIO
+  is active high or low. See gpio.txt.
 - gpio-controller: Marks the device node as a GPIO controller.
+- interrupt-controller: Marks the device node as an interrupt controller.
+- #interrupt-cells: Should be two. The first cell is the pin number and the
+  second cell is used to specify irq type flags, see the two cell description
+  in interrupt-controller/interrupts.txt for details.
 
 optional properties:
 - #gpio-lines: Number of gpio if absent 32.
@@ -21,5 +25,7 @@ Example:
 		#gpio-cells = <2>;
 		gpio-controller;
 		#gpio-lines = <19>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
 	};
 
-- 
2.11.0
