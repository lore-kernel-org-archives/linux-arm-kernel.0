From: pramodku@broadcom.com (Pramod Kumar)
Date: Mon, 19 Oct 2015 11:13:08 +0530
Subject: [PATCH 01/11] dt-bindings: pinctrl: Optional DT property to support
 pin mappings
In-Reply-To: <1445233398-27129-1-git-send-email-pramodku@broadcom.com>
References: <1445233398-27129-1-git-send-email-pramodku@broadcom.com>
Message-ID: <1445233398-27129-2-git-send-email-pramodku@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If GPIO controller's pins are muxed, pin-controller subsystem
need to be intimated by defining mapping between gpio and
pinmux controller. This patch adds required properties to
define this mapping via DT.

Signed-off-by: Pramod Kumar <pramodku@broadcom.com>
Reviewed-by: Ray Jui <rjui@broadcom.com>
Reviewed-by: Scott Branden <sbranden@broadcom.com>
---
 .../devicetree/bindings/pinctrl/brcm,cygnus-gpio.txt         | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/brcm,cygnus-gpio.txt b/Documentation/devicetree/bindings/pinctrl/brcm,cygnus-gpio.txt
index 6540ca5..25a5002 100644
--- a/Documentation/devicetree/bindings/pinctrl/brcm,cygnus-gpio.txt
+++ b/Documentation/devicetree/bindings/pinctrl/brcm,cygnus-gpio.txt
@@ -26,9 +26,13 @@ Optional properties:
 - interrupt-controller:
     Specifies that the node is an interrupt controller
 
-- pinmux:
-    Specifies the phandle to the IOMUX device, where pins can be individually
-muxed to GPIO
+- gpio-ranges:
+    Specifies the mapping between gpio controller and pin-controllers pins.
+    This requires 4 fields in cells defined as -
+    1. Phandle of pin-controller.
+    2. GPIO base pin offset.
+    3  Pin-control base pin offset.
+    4. number of gpio pins which are linearly mapped from pin base.
 
 Supported generic PINCONF properties in child nodes:
 
@@ -78,6 +82,8 @@ Example:
 		gpio-controller;
 		interrupts = <GIC_SPI 174 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-controller;
+		gpio-ranges = <&pinctrl 0 42 1>,
+				<&pinctrl 1 44 3>;
 	};
 
 	/*
-- 
1.9.1
