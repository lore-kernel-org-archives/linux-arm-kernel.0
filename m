From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 23 Aug 2018 12:33:31 +0200
Subject: [PATCH 3/4] bus: Add DT bindings for 96Boards low speed connector
In-Reply-To: <20180823103332.32047-1-linus.walleij@linaro.org>
References: <20180823103332.32047-1-linus.walleij@linaro.org>
Message-ID: <20180823103332.32047-4-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We need to be able to grab resources on a 96Boards low
speed connector to populate and use a daughterboard, so
define some very rudimentary properties simply passing
phandles for the resources used on the low speed
connector.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 .../bus/96boards,low-speed-connector.txt      | 50 +++++++++++++++++++
 1 file changed, 50 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/bus/96boards,low-speed-connector.txt

diff --git a/Documentation/devicetree/bindings/bus/96boards,low-speed-connector.txt b/Documentation/devicetree/bindings/bus/96boards,low-speed-connector.txt
new file mode 100644
index 000000000000..6631b3edd01f
--- /dev/null
+++ b/Documentation/devicetree/bindings/bus/96boards,low-speed-connector.txt
@@ -0,0 +1,50 @@
+96Boards Low Speed Connectors
+
+The 96Boards connectors represent a non-dicoverable Low Speed (LS)
+and High Speed (HS) external bus on the 96Board development
+boards. Each 96Board presents both of these connectors.
+
+The Low Speed (LS) connector is a 40 pin 2x20 female pin header:
+- Power
+- Two buttons: power and reset
+- 2 x UART one optional with just RX/TX, one required with modem
+  CTS/RTS
+- 2 x I2C
+- 1 x SPI
+- 1 x I2S (audio)
+- 12 x GPIO lines named GPIO-A thru GPIO-L
+
+Further details on the electronics and signals are available in
+"96Boards Consumer Edition, Low Cost Hardware Platform Specification"
+As of writing version 1.0, January 2015.
+
+Required properties:
+
+- compatible: shall be "96boards,low-speed-connector"
+- i2c0: phandle to the I2C0 bus
+- i2c1: phandle to the I2C1 bus
+- spi: phandle to the SPI bus
+- gpios: a list of phandles to the GPIOs connected to the
+  connector. The handles need to be uniformly specified with the
+  0 flag as the connector is not the end consumer.
+
+Example:
+
+lscon: connector {
+	compatible = "96boards,low-speed-connector";
+	i2c0 = <&i2csw_0>;
+	i2c1 = <&i2csw_1>;
+	spi = <&spi0>;
+	gpios = <&gpio 36 0>, /* GPIO-A */
+	        <&gpio 37 0>, /* GPIO-B */
+		<&gpio 39 0>, /* GPIO-C */
+		<&gpio 40 0>, /* GPIO-D */
+		<&gpio 44 0>, /* GPIO-E */
+		<&gpio 45 0>, /* GPIO-F */
+		<&gpio 78 0>, /* GPIO-G */
+		<&gpio 79 0>, /* GPIO-H */
+		<&gpio 80 0>, /* GPIO-I */
+		<&gpio 81 0>, /* GPIO-J */
+		<&gpio 82 0>, /* GPIO-K */
+		<&gpio 83 0>; /* GPIO-L */
+};
-- 
2.17.0
