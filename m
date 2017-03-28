From: hgkr.klein@gmail.com (Helmut Klein)
Date: Tue, 28 Mar 2017 11:25:44 +0200
Subject: [PATCH v2,
 2/3] tty/serial: meson_uart: add documentation for the dt-bindings
In-Reply-To: <20170328092545.4644-1-hgkr.klein@gmail.com>
References: <20170328092545.4644-1-hgkr.klein@gmail.com>
Message-ID: <20170328092545.4644-3-hgkr.klein@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the documentation for the device tree binding of meson_uart

Signed-off-by: Helmut Klein <hgkr.klein@gmail.com>
---
 .../bindings/serial/amlogic,meson_uart.txt         | 25 ++++++++++++++++++++++
 1 file changed, 25 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/serial/amlogic,meson_uart.txt

diff --git a/Documentation/devicetree/bindings/serial/amlogic,meson_uart.txt b/Documentation/devicetree/bindings/serial/amlogic,meson_uart.txt
new file mode 100644
index 000000000000..6f94ba25760d
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/amlogic,meson_uart.txt
@@ -0,0 +1,25 @@
+* Amlogic Meson UART, used in multiple SoCs (e.g. S905, s905X, ...)
+
+Required properties:
+- compatible	: "amlogic,meson-uart"
+- reg		: offset and length of the register set for the device.
+- interrupts	: device interrupt
+- clocks	: the baud rate clock for the UART and optionally the core clock for the none AO uarts
+e.g.
+uart_A: serial at 84c0 {
+	compatible = "amlogic,meson-uart";
+	reg = <0x0 0x84c0 0x0 0x14>;
+	pinctrl-0 = <&uart_a_pins &uart_a_cts_rts_pins>;
+	interrupts = <GIC_SPI 26 IRQ_TYPE_EDGE_RISING>;
+	clocks = <&xtal>, <&clkc CLKID_UART0>;
+	clock-names = "xtal", "core";
+	status = "ok";
+};
+
+Note: Each port should have an alias correctly numbered in "aliases" node.
+
+e.g.
+aliases {
+	serial0 = &uart_AO;
+	serial1 = &uart_A;
+};
--
2.11.0
