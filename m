From: zonque@gmail.com (Daniel Mack)
Date: Thu, 11 Jul 2013 17:17:54 +0200
Subject: [PATCH 2/5] gpio: pxa: fix Documentation of interrupt-names property
In-Reply-To: <1373555877-29887-1-git-send-email-zonque@gmail.com>
References: <1373555877-29887-1-git-send-email-zonque@gmail.com>
Message-ID: <1373555877-29887-3-git-send-email-zonque@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The property name to pass names for interrupt resources is called
"interrupt-names", not "interrupt-name". Fix it to avoid further
confusion.

Signed-off-by: Daniel Mack <zonque@gmail.com>
Cc: Haojian Zhuang <haojian.zhuang@linaro.org>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>
---
 Documentation/devicetree/bindings/gpio/mrvl-gpio.txt | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/gpio/mrvl-gpio.txt b/Documentation/devicetree/bindings/gpio/mrvl-gpio.txt
index 9b3f1d4..6641626 100644
--- a/Documentation/devicetree/bindings/gpio/mrvl-gpio.txt
+++ b/Documentation/devicetree/bindings/gpio/mrvl-gpio.txt
@@ -10,8 +10,9 @@ Required properties:
   There're three gpio interrupts in arch-pxa, and they're gpio0,
   gpio1 and gpio_mux. There're only one gpio interrupt in arch-mmp,
   gpio_mux.
-- interrupt-name : Should be the name of irq resource. Each interrupt
-  binds its interrupt-name.
+- interrupt-names : Should be the names of irq resources. Each interrupt
+  uses its own interrupt name, so there should be as many interrupt names
+  as referenced interrups.
 - interrupt-controller : Identifies the node as an interrupt controller.
 - #interrupt-cells: Specifies the number of cells needed to encode an
   interrupt source.
@@ -24,7 +25,7 @@ Example:
 		compatible = "marvell,mmp-gpio";
 		reg = <0xd4019000 0x1000>;
 		interrupts = <49>;
-		interrupt-name = "gpio_mux";
+		interrupt-names = "gpio_mux";
 		gpio-controller;
 		#gpio-cells = <1>;
 		interrupt-controller;
-- 
1.8.1.4
