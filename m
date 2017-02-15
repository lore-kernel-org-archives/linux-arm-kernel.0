From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Wed, 15 Feb 2017 17:55:22 +0100
Subject: [PATCH 05/11] Documentation: devicetree: serial: Document Actions
 Semi Owl UARTs
In-Reply-To: <20170215165528.10052-1-afaerber@suse.de>
References: <20170215165528.10052-1-afaerber@suse.de>
Message-ID: <20170215165528.10052-6-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 .../devicetree/bindings/serial/acts,owl-uart.txt         | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/serial/acts,owl-uart.txt

diff --git a/Documentation/devicetree/bindings/serial/acts,owl-uart.txt b/Documentation/devicetree/bindings/serial/acts,owl-uart.txt
new file mode 100644
index 0000000..a1aecd8
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/acts,owl-uart.txt
@@ -0,0 +1,16 @@
+Actions Semi Owl UART
+
+Required properties:
+- compatible :  "acts,s500-uart", "acts,owl-uart" for S500
+                "acts,s900-uart", "acts,owl-uart" for S900
+- reg        :  Offset and length of the register set for the device.
+- interrupts :  Should contain UART interrupt.
+
+
+Example:
+
+		uart3: serial at b0126000 {
+			compatible = "acts,s500-uart", "acts,owl-uart";
+			reg = <0xb0126000 0x1000>;
+			interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
+		};
-- 
2.10.2
