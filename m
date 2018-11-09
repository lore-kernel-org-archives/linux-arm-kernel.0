From: hayashi.kunihiko@socionext.com (Kunihiko Hayashi)
Date: Fri,  9 Nov 2018 10:42:04 +0900
Subject: [PATCH 1/4] dt-bindings: reset: uniphier: Replace the expression of
 USB3 with generic peripherals
In-Reply-To: <1541727727-10821-1-git-send-email-hayashi.kunihiko@socionext.com>
References: <1541727727-10821-1-git-send-email-hayashi.kunihiko@socionext.com>
Message-ID: <1541727727-10821-2-git-send-email-hayashi.kunihiko@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Replace the expression of "USB3 glue layer" with the glue layer of the
generic peripherals to allow other devices to use it. The reset control
belongs to this glue layer.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 .../devicetree/bindings/reset/uniphier-reset.txt   | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/Documentation/devicetree/bindings/reset/uniphier-reset.txt b/Documentation/devicetree/bindings/reset/uniphier-reset.txt
index 101743d..f63c511 100644
--- a/Documentation/devicetree/bindings/reset/uniphier-reset.txt
+++ b/Documentation/devicetree/bindings/reset/uniphier-reset.txt
@@ -120,27 +120,27 @@ Example:
 	};
 
 
-USB3 core reset
----------------
+Peripheral core reset in glue layer
+-----------------------------------
 
-USB3 core reset belongs to USB3 glue layer. Before using the core reset,
-it is necessary to control the clocks and resets to enable this layer.
-These clocks and resets should be described in each property.
+Some peripheral core reset belongs to its own glue layer. Before using
+this core reset, it is necessary to control the clocks and resets to enable
+this layer. These clocks and resets should be described in each property.
 
 Required properties:
 - compatible: Should be
-    "socionext,uniphier-pro4-usb3-reset" - for Pro4 SoC
-    "socionext,uniphier-pxs2-usb3-reset" - for PXs2 SoC
-    "socionext,uniphier-ld20-usb3-reset" - for LD20 SoC
-    "socionext,uniphier-pxs3-usb3-reset" - for PXs3 SoC
+    "socionext,uniphier-pro4-usb3-reset" - for Pro4 SoC USB3
+    "socionext,uniphier-pxs2-usb3-reset" - for PXs2 SoC USB3
+    "socionext,uniphier-ld20-usb3-reset" - for LD20 SoC USB3
+    "socionext,uniphier-pxs3-usb3-reset" - for PXs3 SoC USB3
 - #reset-cells: Should be 1.
 - reg: Specifies offset and length of the register set for the device.
-- clocks: A list of phandles to the clock gate for USB3 glue layer.
+- clocks: A list of phandles to the clock gate for the glue layer.
 	According to the clock-names, appropriate clocks are required.
 - clock-names: Should contain
     "gio", "link" - for Pro4 SoC
     "link"        - for others
-- resets: A list of phandles to the reset control for USB3 glue layer.
+- resets: A list of phandles to the reset control for the glue layer.
 	According to the reset-names, appropriate resets are required.
 - reset-names: Should contain
     "gio", "link" - for Pro4 SoC
-- 
2.7.4
