From: zhongkaihua@huawei.com (Zhong Kaihua)
Date: Thu, 19 Nov 2015 16:37:08 +0800
Subject: [PATCH V2 1/2] dt-bindings: spi: Documentation for Hi6220 spi driver
Message-ID: <1447922229-60552-1-git-send-email-zhongkaihua@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

dt-bindings: spi: Documentation for Hi6220 spi driver

Signed-off-by: Zhong Kaihua <zhongkaihua@huawei.com>
---
 .../devicetree/bindings/spi/spi-hi6220.txt         | 45 ++++++++++++++++++++++
 1 file changed, 45 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-hi6220.txt

diff --git a/Documentation/devicetree/bindings/spi/spi-hi6220.txt b/Documentation/devicetree/bindings/spi/spi-hi6220.txt
new file mode 100644
index 0000000..91aa169
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/spi-hi6220.txt
@@ -0,0 +1,45 @@
+Hi6220 SPI controller
+
+Required properties:
+- compatible : "arm,pl022", "arm,primecell"
+- reg : Offset and length of the register set for the device
+- interrupts : Should contain SPI controller interrupt
+- num-cs : total number of chipselects
+
+Required Board Specific Properties:
+
+- #address-cells: should be 1.
+- #size-cells: should be 0.
+
+Optional properties:
+- cs-gpios : should specify GPIOs used for chipselects.
+  The gpios will be referred to as reg = <index> in the SPI child nodes.
+  If unspecified, a single SPI device without a chip select can be used.
+- dmas : Two or more DMA channel specifiers following the convention outlined
+         in bindings/dma/dma.txt
+- dma-names: Names for the dma channels, if present. There must be at
+	     least one channel named "tx" for transmit and named "rx" for
+             receive.
+
+Example:
+             spi_0: spi at f7106000 {
+			compatible = "arm,pl022", "arm,primecell";
+			reg = <0x0 0xf7106000 0x0 0x1000>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			interrupts = <0 50 4>;
+			bus-id = <0>;
+			enable-dma = <1>;
+			dmas =	<&dma0 12 &dma0 13>;
+			dma-names = "rx", "tx";
+
+			clocks = <&clock_sys HI6220_SPI_CLK>;
+			clock-names = "apb_pclk";
+			pinctrl-names = "default";
+			pinctrl-0 = <&spi0_pmx_func &spi0_cfg_func>;
+			num-cs = <4>;
+			cs-gpios = <&gpio6 2 0>, <&gpio6 3 0>, <&gpio6 4 0>, <&gpio6 5 0>;
+
+			status = "ok";
+		};
+
-- 
1.9.1
