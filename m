From: andrew.jackson@arm.com (Andrew Jackson)
Date: Tue, 30 Dec 2014 10:55:47 +0000
Subject: [PATCH v5 5/6] ASoC: dwc: Add documentation for I2S DT
In-Reply-To: <cover.1419936132.git.Andrew.Jackson@arm.com>
References: <cover.1419936132.git.Andrew.Jackson@arm.com>
Message-ID: <c310f40f0b3b3bcd72cb02a7e3963d56f21e9dd5.1419936132.git.Andrew.Jackson@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Andrew Jackson <Andrew.Jackson@arm.com>

Add documentation for Designware I2S hardware block.  The block requires
one clock (for audio sampling) and DMA channels for receive and transmit.

Signed-off-by: Andrew Jackson <Andrew.Jackson@arm.com>
---
 .../devicetree/bindings/sound/designware-i2s.txt   |   31 ++++++++++++++++++++
 1 files changed, 31 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/designware-i2s.txt

diff --git a/Documentation/devicetree/bindings/sound/designware-i2s.txt b/Documentation/devicetree/bindings/sound/designware-i2s.txt
new file mode 100644
index 0000000..7bb5424
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/designware-i2s.txt
@@ -0,0 +1,31 @@
+DesignWare I2S controller
+
+Required properties:
+ - compatible : Must be "snps,designware-i2s"
+ - reg : Must contain the I2S core's registers location and length
+ - clocks : Pairs of phandle and specifier referencing the controller's
+   clocks. The controller expects one clock: the clock used as the sampling
+   rate reference clock sample.
+ - clock-names : "i2sclk" for the sample rate reference clock.
+ - dmas: Pairs of phandle and specifier for the DMA channels that are used by
+   the core. The core expects one or two dma channels: one for transmit and
+   one for receive.
+ - dma-names : "tx" for the transmit channel, "rx" for the receive channel.
+
+For more details on the 'dma', 'dma-names', 'clock' and 'clock-names'
+properties please check:
+	* resource-names.txt
+	* clock/clock-bindings.txt
+	* dma/dma.txt
+
+Example:
+
+	soc_i2s: i2s at 7ff90000 {
+		compatible = "snps,designware-i2s";
+		reg = <0x0 0x7ff90000 0x0 0x1000>;
+		clocks = <&scpi_i2sclk 0>;
+		clock-names = "i2sclk";
+		#sound-dai-cells = <0>;
+		dmas = <&dma0 5>;
+		dma-names = "tx";
+	};
-- 
1.7.1
