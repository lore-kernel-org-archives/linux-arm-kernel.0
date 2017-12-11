From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Mon, 11 Dec 2017 21:39:10 +0100
Subject: [PATCH 1/3] dt-bindings: bcm2836-l1-intc: add interrupt polarity
 support
In-Reply-To: <1513024752-11246-1-git-send-email-stefan.wahren@i2se.com>
References: <1513024752-11246-1-git-send-email-stefan.wahren@i2se.com>
Message-ID: <1513024752-11246-2-git-send-email-stefan.wahren@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This increases the interrupt cells for the 1st level interrupt controller
binding in order to describe the polarity like on the other ARM platforms.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 .../devicetree/bindings/interrupt-controller/brcm,bcm2836-l1-intc.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/brcm,bcm2836-l1-intc.txt b/Documentation/devicetree/bindings/interrupt-controller/brcm,bcm2836-l1-intc.txt
index f320dcd..8ced169 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/brcm,bcm2836-l1-intc.txt
+++ b/Documentation/devicetree/bindings/interrupt-controller/brcm,bcm2836-l1-intc.txt
@@ -12,7 +12,7 @@ Required properties:
 			  registers
 - interrupt-controller:	Identifies the node as an interrupt controller
 - #interrupt-cells:	Specifies the number of cells needed to encode an
-			  interrupt source. The value shall be 1
+			  interrupt source. The value shall be 2
 
 Please refer to interrupts.txt in this directory for details of the common
 Interrupt Controllers bindings used by client devices.
@@ -32,6 +32,6 @@ local_intc: local_intc {
 	compatible = "brcm,bcm2836-l1-intc";
 	reg = <0x40000000 0x100>;
 	interrupt-controller;
-	#interrupt-cells = <1>;
+	#interrupt-cells = <2>;
 	interrupt-parent = <&local_intc>;
 };
-- 
2.7.4
