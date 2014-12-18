From: baruch@tkos.co.il (Baruch Siach)
Date: Thu, 18 Dec 2014 21:45:25 +0200
Subject: [PATCH 3/3] serial: add device tree binding documentation for
 Conexant USART
In-Reply-To: <cover.1418930377.git.baruch@tkos.co.il>
References: <cover.1418930377.git.baruch@tkos.co.il>
Message-ID: <71eb6f2f64c6965e38b29c7463b7edb4966142ad.1418930377.git.baruch@tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
 .../devicetree/bindings/serial/digicolor-usart.txt | 27 ++++++++++++++++++++++
 1 file changed, 27 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/serial/digicolor-usart.txt

diff --git a/Documentation/devicetree/bindings/serial/digicolor-usart.txt b/Documentation/devicetree/bindings/serial/digicolor-usart.txt
new file mode 100644
index 000000000000..2d3ede66889d
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/digicolor-usart.txt
@@ -0,0 +1,27 @@
+Binding for Conexant Digicolor USART
+
+Note: this binding is only applicable for using the USART peripheral as
+UART. USART also support synchronous serial protocols like SPI and I2S. Use
+the binding that matches the wiring of your system.
+
+Required properties:
+- compatible : should be "cnxt,cx92755-usart".
+- reg: Should contain USART controller registers location and length.
+- interrupts: Should contain a single USART controller interrupt.
+- clocks: Must contain phandles to the USART clock
+  See ../clocks/clock-bindings.txt for details.
+
+Note: Each UART port should have an alias correctly numbered
+in "aliases" node.
+
+Example:
+	aliases {
+		serial0 = &uart0;
+	};
+
+	uart0: uart at f0000740 {
+		compatible = "cnxt,cx92755-usart";
+		reg = <0xf0000740 0x20>;
+		clocks = <&main_clk>;
+		interrupts = <44>;
+	};
-- 
2.1.3
