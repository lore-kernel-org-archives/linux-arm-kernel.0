From: chunyan.zhang@spreadtrum.com (Chunyan Zhang)
Date: Mon, 27 Mar 2017 14:06:41 +0800
Subject: [PATCH V5 3/4] dt-bindings: serial: add a new compatible string for
 SC9860
In-Reply-To: <1490594802-27073-1-git-send-email-chunyan.zhang@spreadtrum.com>
References: <1490594802-27073-1-git-send-email-chunyan.zhang@spreadtrum.com>
Message-ID: <1490594802-27073-4-git-send-email-chunyan.zhang@spreadtrum.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

SC9860 use the same serial device which SC9836 uses, so added a new
compatible string to support SC9860 as well, also added an example
of how to describe this serial device in DT.

Signed-off-by: Chunyan Zhang <chunyan.zhang@spreadtrum.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/serial/sprd-uart.txt | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/serial/sprd-uart.txt b/Documentation/devicetree/bindings/serial/sprd-uart.txt
index 2aff0f2..cab40f0 100644
--- a/Documentation/devicetree/bindings/serial/sprd-uart.txt
+++ b/Documentation/devicetree/bindings/serial/sprd-uart.txt
@@ -1,7 +1,19 @@
 * Spreadtrum serial UART
 
 Required properties:
-- compatible: must be "sprd,sc9836-uart"
+- compatible: must be one of:
+  * "sprd,sc9836-uart"
+  * "sprd,sc9860-uart", "sprd,sc9836-uart"
+
 - reg: offset and length of the register set for the device
 - interrupts: exactly one interrupt specifier
 - clocks: phandles to input clocks.
+
+Example:
+	uart0: serial at 0 {
+		compatible = "sprd,sc9860-uart",
+			     "sprd,sc9836-uart";
+		reg = <0x0 0x100>;
+		interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&ext_26m>;
+	};
-- 
2.7.4
