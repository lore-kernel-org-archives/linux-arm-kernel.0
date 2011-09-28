From: robherring2@gmail.com (Rob Herring)
Date: Tue, 27 Sep 2011 20:45:13 -0500
Subject: [PATCH 1/2] devicetree: Add ARM pl061 gpio controller binding doc
Message-ID: <1317174314-16122-1-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

Add binding documentation for ARM's Primecell PL061 GPIO controller.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
---
 .../devicetree/bindings/gpio/pl061-gpio.txt        |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/gpio/pl061-gpio.txt

diff --git a/Documentation/devicetree/bindings/gpio/pl061-gpio.txt b/Documentation/devicetree/bindings/gpio/pl061-gpio.txt
new file mode 100644
index 0000000..a2c416b
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/pl061-gpio.txt
@@ -0,0 +1,10 @@
+ARM PL061 GPIO controller
+
+Required properties:
+- compatible : "arm,pl061", "arm,primecell"
+- #gpio-cells : Should be two. The first cell is the pin number and the
+  second cell is used to specify optional parameters:
+  - bit 0 specifies polarity (0 for normal, 1 for inverted)
+- gpio-controller : Marks the device node as a GPIO controller.
+- interrupts : Interrupt mapping for GPIO IRQ.
+
-- 
1.7.5.4
