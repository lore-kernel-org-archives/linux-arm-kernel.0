From: b-cousson@ti.com (Benoit Cousson)
Date: Wed, 24 Aug 2011 15:09:16 +0200
Subject: [RFC PATCH 10/10] documentation/dt: Add OMAP GPIO properties
In-Reply-To: <1314191356-10963-1-git-send-email-b-cousson@ti.com>
References: <1314191356-10963-1-git-send-email-b-cousson@ti.com>
Message-ID: <1314191356-10963-11-git-send-email-b-cousson@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add documentation for GPIO properties specific to OMAP.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Randy Dunlap <rdunlap@xenotime.net>
---
 .../devicetree/bindings/gpio/gpio-omap.txt         |   33 ++++++++++++++++++++
 1 files changed, 33 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/gpio/gpio-omap.txt

diff --git a/Documentation/devicetree/bindings/gpio/gpio-omap.txt b/Documentation/devicetree/bindings/gpio/gpio-omap.txt
new file mode 100644
index 0000000..692b1c7
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/gpio-omap.txt
@@ -0,0 +1,33 @@
+OMAP GPIO controller
+
+Required properties:
+- compatible:
+  - "ti,omap2-gpio" for OMAP2 and OMAP3 controllers
+  - "ti,omap4-gpio" for OMAP4 controller
+- #gpio-cells : Should be two.
+  - first cell is the pin number
+  - second cell is used to specify optional parameters (unused)
+- gpio-controller : Marks the device node as a GPIO controller.
+
+OMAP specific properties:
+- hwmods: Name of the hwmod associated to the GPIO
+- id: 32 bits to identify the id (1 based index)
+- bank_width: number of pin supported by the controller (16 or 32)
+- debounce: set if the controller support the debouce funtionnality
+- bank_count: number of controller support by the SoC. This is a temporary
+  hack until the bank_count is removed from the driver.
+
+
+Example:
+
+gpio4: gpio4 {
+    compatible = "ti,omap4-gpio", "ti,omap-gpio";
+    hwmods = "gpio4";
+    id = <4>;
+    bank_width = <32>;
+    debounce;
+    no_idle_on_suspend;
+    #gpio-cells = <2>;
+    gpio-controller;
+};
+
-- 
1.7.0.4
