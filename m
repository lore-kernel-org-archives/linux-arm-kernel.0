From: kernel@martin.sperl.org (kernel at martin.sperl.org)
Date: Sat,  9 Jan 2016 13:07:32 +0000
Subject: [PATCH V2 1/2] dt/bindings: serial: bcm2835: add binding
 documentation for bcm2835-aux-uart
In-Reply-To: <1452344854-2576-1-git-send-email-kernel@martin.sperl.org>
References: <1452344854-2576-1-git-send-email-kernel@martin.sperl.org>
Message-ID: <1452344854-2576-2-git-send-email-kernel@martin.sperl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Martin Sperl <kernel@martin.sperl.org>

Add binding documentation for the bcm2835-aux-uart driver.

Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
---
 .../bindings/serial/brcm,bcm2835-aux-uart.txt        |   18 ++++++++++++++++++
 1 file changed, 18 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/serial/brcm,bcm2835-aux-uart.txt

diff --git a/Documentation/devicetree/bindings/serial/brcm,bcm2835-aux-uart.txt b/Documentation/devicetree/bindings/serial/brcm,bcm2835-aux-uart.txt
new file mode 100644
index 0000000..2defe5c
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/brcm,bcm2835-aux-uart.txt
@@ -0,0 +1,18 @@
+* BCM2835 AUXILIAR UART
+
+Required properties:
+
+- compatible: "brcm,bcm2835-aux-uart"
+- reg: The base address of the UART register bank.
+- interrupts: A single interrupt specifier.
+- clocks: Clock driving the hardware; used to figure out the baud rate
+  divisor.
+
+Example:
+
+	uart1: uart at 7e215040 {
+		compatible = "brcm,bcm2835-aux-uart";
+		reg = <0x7e215040 0x40>;
+		interrupts = <1 29>;
+		clocks = <&aux BCM2835_AUX_CLOCK_UART>;
+	};
-- 
1.7.10.4
