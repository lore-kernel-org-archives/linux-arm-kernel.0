From: shc_work@mail.ru (Alexander Shiyan)
Date: Wed, 11 Dec 2013 19:52:35 +0400
Subject: [PATCH 2/2] serial: clps711x: dts: Add bindings documentation for the
 CLPS711X UART
Message-ID: <1386777155-24851-1-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the devicetree documentation for the Cirrus Logic
CLPS711X UART.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 .../bindings/serial/cirrus,clps711x-uart.txt       | 29 ++++++++++++++++++++++
 1 file changed, 29 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/serial/cirrus,clps711x-uart.txt

diff --git a/Documentation/devicetree/bindings/serial/cirrus,clps711x-uart.txt b/Documentation/devicetree/bindings/serial/cirrus,clps711x-uart.txt
new file mode 100644
index 0000000..8bbdd21
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/cirrus,clps711x-uart.txt
@@ -0,0 +1,29 @@
+* Cirrus Logic CLPS711X Universal Asynchronous Receiver/Transmitter (UART)
+
+Required properties:
+- compatible: Should be "cirrus,clps711x-uart".
+- reg: Address and length of the register set for the device.
+- interrupts: Should contain UART TX and RX interrupt.
+- clocks: Should contain UART core clock number.
+- syscon: Phandle to SYSCON node, which contain UART control bits.
+
+Optional properties:
+- uart-use-ms: Indicate the UART has modem signal (DCD, DSR, CTS).
+- uart-use-irda: Indicate the UART use IRDA mode.
+
+Note: Each UART port should have an alias correctly numbered
+in "aliases" node.
+
+Example:
+	aliases {
+		serial0 = &uart1;
+	};
+
+	uart1: uart at 80000480 {
+		compatible = "cirrus,clps711x-uart";
+		reg = <0x80000480 0x80>;
+		interrupts = <12 13>;
+		clocks = <&clks 11>;
+		syscon = <&syscon1>;
+		uart-use-ms;
+	};
-- 
1.8.3.2
