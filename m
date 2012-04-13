From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 13 Apr 2012 15:05:06 +0100
Subject: [PATCH 4/7] drivers/gpio: gpio-nomadik: Provide documentation for
 Device Tree bindings
In-Reply-To: <1334325909-5779-1-git-send-email-lee.jones@linaro.org>
References: <1334325909-5779-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1334325909-5779-5-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add required documentation for specific gpio-nomadik DT bindings.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 .../devicetree/bindings/gpio/gpio-nmk.txt          |   29 ++++++++++++++++++++
 1 files changed, 29 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/gpio/gpio-nmk.txt

diff --git a/Documentation/devicetree/bindings/gpio/gpio-nmk.txt b/Documentation/devicetree/bindings/gpio/gpio-nmk.txt
new file mode 100644
index 0000000..7427b63
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/gpio-nmk.txt
@@ -0,0 +1,29 @@
+Nomadik GPIO controller
+
+Required properties:
+- compatible           : Should be "st,nomadik-gpio".
+- reg                  : Physical base address and length of the controller's registers.
+- interrupts           : The interrupt outputs from the controller.
+- #gpio-cells          : Should be two:
+                           The first cell is the pin number.
+                           The second cell is used to specify optional parameters:
+                             - bits[3:0] trigger type and level flags:
+                                 1 = low-to-high edge triggered.
+                                 2 = high-to-low edge triggered.
+                                 4 = active high level-sensitive.
+                                 8 = active low level-sensitive.
+- gpio-controller      : Marks the device node as a GPIO controller.
+- supports-sleepmode   : Specifies whether controller can sleep or not
+- gpio-bank            : Specifies which bank a controller owns.
+
+Example:
+
+                gpio1: gpio at 8012e080 {
+                        compatible = "st,nomadik-gpio";
+                        reg =  <0x8012e080 0x80>;
+                        interrupts = <0 120 0x4>;
+                        #gpio-cells = <2>;
+                        gpio-controller;
+                        supports-sleepmode;
+                        gpio-bank = <1>;
+                };
-- 
1.7.9.1
