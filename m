From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Mon, 19 Jun 2017 03:46:39 +0200
Subject: [PATCH v5 07/26] dt-bindings: serial: Document Actions Semi Owl UARTs
In-Reply-To: <7fff8813-cea4-0530-bf7b-3d0ad50d6e93@suse.de>
References: <7fff8813-cea4-0530-bf7b-3d0ad50d6e93@suse.de>
Message-ID: <20170619014640.6829-1-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This UART is found on S500 and S900 SoCs.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 v2 -> v3 -> v4 -> v5: Unchanged
 
 v1 -> v2:
 * Adopted "actions" vendor prefix
 
 .../devicetree/bindings/serial/actions,owl-uart.txt      | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/serial/actions,owl-uart.txt

diff --git a/Documentation/devicetree/bindings/serial/actions,owl-uart.txt b/Documentation/devicetree/bindings/serial/actions,owl-uart.txt
new file mode 100644
index 000000000000..aa873eada02d
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/actions,owl-uart.txt
@@ -0,0 +1,16 @@
+Actions Semi Owl UART
+
+Required properties:
+- compatible :  "actions,s500-uart", "actions,owl-uart" for S500
+                "actions,s900-uart", "actions,owl-uart" for S900
+- reg        :  Offset and length of the register set for the device.
+- interrupts :  Should contain UART interrupt.
+
+
+Example:
+
+		uart3: serial at b0126000 {
+			compatible = "actions,s500-uart", "actions,owl-uart";
+			reg = <0xb0126000 0x1000>;
+			interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
+		};
-- 
2.12.3
