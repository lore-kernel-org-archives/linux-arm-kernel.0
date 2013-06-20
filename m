From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 20 Jun 2013 22:09:10 +0900
Subject: [PATCH 1/2] gpio-rcar: Reference core gpio documentation in the DT
 bindings
In-Reply-To: <1371733751-27730-1-git-send-email-horms+renesas@verge.net.au>
References: <1371733751-27730-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1371733751-27730-2-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Replaced the detailed gpio-ranges documentation with a reference to the
code gpio DT bindings, and mention the gpio flags symbolic names.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 .../devicetree/bindings/gpio/renesas,gpio-rcar.txt     | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/Documentation/devicetree/bindings/gpio/renesas,gpio-rcar.txt b/Documentation/devicetree/bindings/gpio/renesas,gpio-rcar.txt
index 46d76a0..cb3dc7b 100644
--- a/Documentation/devicetree/bindings/gpio/renesas,gpio-rcar.txt
+++ b/Documentation/devicetree/bindings/gpio/renesas,gpio-rcar.txt
@@ -16,18 +16,12 @@ Required Properties:
 
   - gpio-controller: Marks the device node as a gpio controller.
   - #gpio-cells: Should be 2. The first cell is the GPIO number and the second
-    cell is used to specify optional parameters as bit flags. Only the GPIO
-    active low flag (bit 0) is currently supported.
-  - gpio-ranges: Range of pins managed by the GPIO controller as a 4-cells
-    tuple using the following syntax.
-
-    <[phandle of the pin controller node]
-     0
-     [index of the first pin]
-     [number of pins]>
-
-Please refer to gpio.txt in this directory for details of the common GPIO
-bindings used by client devices.
+    cell specifies GPIO flags, as defined in <dt-bindings/gpio/gpio.h>. Only the
+    GPIO_ACTIVE_HIGH and GPIO_ACTIVE_LOW flags are supported.
+  - gpio-ranges: Range of pins managed by the GPIO controller.
+
+Please refer to gpio.txt in this directory for details of gpio-ranges property
+and the common GPIO bindings used by client devices.
 
 Example: R8A7779 (R-Car H1) GPIO controller nodes
 
-- 
1.8.2.1
