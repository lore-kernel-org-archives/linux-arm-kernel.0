From: florian.vaussard@epfl.ch (Florian Vaussard)
Date: Mon,  3 Sep 2012 15:54:51 +0200
Subject: [PATCH 3/3] gpio-twl4030: updates the bindings for new dt properties
In-Reply-To: <1346680491-4211-1-git-send-email-florian.vaussard@epfl.ch>
References: <1346680491-4211-1-git-send-email-florian.vaussard@epfl.ch>
Message-ID: <1346680491-4211-4-git-send-email-florian.vaussard@epfl.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the new properties to the documentation of bindings.

Signed-off-by: Florian Vaussard <florian.vaussard@epfl.ch>
---
 .../devicetree/bindings/gpio/gpio-twl4030.txt      |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/Documentation/devicetree/bindings/gpio/gpio-twl4030.txt b/Documentation/devicetree/bindings/gpio/gpio-twl4030.txt
index 16695d9..690a32e 100644
--- a/Documentation/devicetree/bindings/gpio/gpio-twl4030.txt
+++ b/Documentation/devicetree/bindings/gpio/gpio-twl4030.txt
@@ -11,6 +11,11 @@ Required properties:
 - interrupt-controller: Mark the device node as an interrupt controller
   The first cell is the GPIO number.
   The second cell is not used.
+- ti,use-leds : Enables LEDA and LEDB outputs if set to "true"
+- ti,debounce : if n-th bit is set, debounces GPIO-n
+- ti,mmc-cd : if n-th bit is set, GPIO-n controls VMMC(n+1)
+- ti,pullups : if n-th bit is set, set a pullup on GPIO-n
+- ti,pulldowns : if n-th bit is set, set a pulldown on GPIO-n
 
 Example:
 
@@ -20,4 +25,5 @@ twl_gpio: gpio {
     gpio-controller;
     #interrupt-cells = <2>;
     interrupt-controller;
+    ti,use-leds = "true";
 };
-- 
1.7.5.4
