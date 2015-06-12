From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Fri, 12 Jun 2015 18:04:17 +0900
Subject: [PATCH] serial: 8250_uniphier: add bindings document for UniPhier UART
Message-ID: <1434099857-13594-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is binding information for the UniPhier on-chip UART driver
(drivers/tty/serial/8250/8250_uniphier.c).

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Greg,

If not too late, can you merge this patch into your tty repository
for the upcoming merge window, please?


 .../devicetree/bindings/serial/uniphier-uart.txt   | 23 ++++++++++++++++++++++
 1 file changed, 23 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/serial/uniphier-uart.txt

diff --git a/Documentation/devicetree/bindings/serial/uniphier-uart.txt b/Documentation/devicetree/bindings/serial/uniphier-uart.txt
new file mode 100644
index 0000000..0b3892a
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/uniphier-uart.txt
@@ -0,0 +1,23 @@
+UniPhier UART controller
+
+Required properties:
+- compatible: should be "socionext,uniphier-uart".
+- reg: offset and length of the register set for the device.
+- interrupts: a single interrupt specifier.
+- clocks: phandle to the input clock.
+
+Optional properties:
+- fifo-size: the RX/TX FIFO size.  Defaults to 64 if not specified.
+
+Example:
+	aliases {
+		serial0 = &serial0;
+	};
+
+	serial0: serial at 54006800 {
+		compatible = "socionext,uniphier-uart";
+		reg = <0x54006800 0x40>;
+		interrupts = <0 33 4>;
+		clocks = <&uart_clk>;
+		fifo-size = <64>;
+	};
-- 
1.9.1
