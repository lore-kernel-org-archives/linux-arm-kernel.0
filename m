From: lkundrak@v3.sk (Lubomir Rintel)
Date: Mon, 17 Sep 2018 13:35:55 +0200
Subject: [PATCH v2 1/5] dt-bindings: spi/spi-pxa2xx: add PXA2xx SSP SPI
 Controller
In-Reply-To: <20180917113559.11101-1-lkundrak@v3.sk>
References: <20180917113559.11101-1-lkundrak@v3.sk>
Message-ID: <20180917113559.11101-2-lkundrak@v3.sk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is the SPI controller found on Marvel MMP2 and perhaps more
platforms.

Changes since v1:
- s/ssp at d4035000/spi at d4035000/

Cc: Mark Brown <broonie@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 .../devicetree/bindings/spi/spi-pxa2xx.txt    | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-pxa2xx.txt

diff --git a/Documentation/devicetree/bindings/spi/spi-pxa2xx.txt b/Documentation/devicetree/bindings/spi/spi-pxa2xx.txt
new file mode 100644
index 000000000000..0335a9bd2e8a
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/spi-pxa2xx.txt
@@ -0,0 +1,24 @@
+PXA2xx SSP SPI Controller
+
+Required properties:
+- compatible: Must be "marvell,mmp2-ssp".
+- reg: Offset and length of the device's register set.
+- interrupts: Should be the interrupt number.
+- clocks: Should contain a single entry describing the clock input.
+- #address-cells:  Number of cells required to define a chip select address.
+- #size-cells: Should be zero.
+
+Optional properties:
+- cs-gpios: list of GPIO chip selects. See the SPI bus bindings,
+  Documentation/devicetree/bindings/spi/spi-bus.txt
+
+Child nodes represent devices on the SPI bus
+  See ../spi/spi-bus.txt
+
+Example:
+	ssp1: spi at d4035000 {
+		compatible = "marvell,mmp2-ssp";
+		reg = <0xd4035000 0x1000>;
+		clocks = <&soc_clocks MMP2_CLK_SSP0>;
+		interrupts = <0>;
+	};
-- 
2.17.1
