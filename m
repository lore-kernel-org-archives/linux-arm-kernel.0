From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 15 May 2014 20:00:58 +0900
Subject: [PATCH v3] serial: sh-sci: Add device tree support for r8a7779
Message-ID: <1400151658-17488-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Simply document a new compat string.
There appears to be no need for a driver updates.

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

---
v3
* Keep lists sorted by SoC number
* Added Ack from Laurent Pinchart

v2
* Do not update the driver to set SCSCR_CKE1.
  Instead DT may provide the P clock as the clock for the SCIF devices.
---
 Documentation/devicetree/bindings/serial/renesas,sci-serial.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt b/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
index 53e6c17..64fd7de 100644
--- a/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
+++ b/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
@@ -4,6 +4,7 @@ Required properties:
 
   - compatible: Must contain one of the following:
 
+    - "renesas,scif-r8a7779" for R8A7779 (R-Car H1) SCIF compatible UART.
     - "renesas,scif-r8a7790" for R8A7790 (R-Car H2) SCIF compatible UART.
     - "renesas,scifa-r8a7790" for R8A7790 (R-Car H2) SCIFA compatible UART.
     - "renesas,scifb-r8a7790" for R8A7790 (R-Car H2) SCIFB compatible UART.
-- 
1.8.5.2
