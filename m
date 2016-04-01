From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Fri,  1 Apr 2016 15:02:54 +0100
Subject: [PATCH v5 03/10] dt-bindings: document the MPS2 UART bindings
In-Reply-To: <1459519381-34441-1-git-send-email-vladimir.murzin@arm.com>
References: <1459519381-34441-1-git-send-email-vladimir.murzin@arm.com>
Message-ID: <1459519381-34441-4-git-send-email-vladimir.murzin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds documentation of device tree bindings for the
UART found on ARM MPS2 platform

Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/serial/arm,mps2-uart.txt   |   19 +++++++++++++++++++
 1 file changed, 19 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/serial/arm,mps2-uart.txt

diff --git a/Documentation/devicetree/bindings/serial/arm,mps2-uart.txt b/Documentation/devicetree/bindings/serial/arm,mps2-uart.txt
new file mode 100644
index 0000000..128cc6a
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/arm,mps2-uart.txt
@@ -0,0 +1,19 @@
+ARM MPS2 UART
+
+Required properties:
+- compatible	: Should be "arm,mps2-uart"
+- reg		: Address and length of the register set
+- interrupts	: Reference to the UART RX, TX and overrun interrupts
+
+Required clocking property:
+- clocks	  : The input clock of the UART
+
+
+Examples:
+
+uart0: serial at 40004000 {
+	compatible = "arm,mps2-uart";
+	reg = <0x40004000 0x1000>;
+	interrupts = <0 1 12>;
+	clocks = <&sysclk>;
+};
-- 
1.7.9.5
