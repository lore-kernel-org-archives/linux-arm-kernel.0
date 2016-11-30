From: romain.perier@free-electrons.com (Romain Perier)
Date: Wed, 30 Nov 2016 10:43:49 +0100
Subject: [PATCH v2 3/5] dt-bindings: spi: Add documentation for the Armada
 3700 SPI Controller
In-Reply-To: <20161130094351.2748-1-romain.perier@free-electrons.com>
References: <20161130094351.2748-1-romain.perier@free-electrons.com>
Message-ID: <20161130094351.2748-4-romain.perier@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the devicetree bindings documentation for the SPI controller
present in the Marvell Armada 3700 SoCs.

Signed-off-by: Romain Perier <romain.perier@free-electrons.com>
---
 .../devicetree/bindings/spi/spi-armada-3700.txt    | 25 ++++++++++++++++++++++
 1 file changed, 25 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-armada-3700.txt

diff --git a/Documentation/devicetree/bindings/spi/spi-armada-3700.txt b/Documentation/devicetree/bindings/spi/spi-armada-3700.txt
new file mode 100644
index 0000000..1564aa8
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/spi-armada-3700.txt
@@ -0,0 +1,25 @@
+* Marvell Armada 3700 SPI Controller
+
+Required Properties:
+
+- compatible: should be "marvell,armada-3700-spi"
+- reg: physical base address of the controller and length of memory mapped
+       region.
+- interrupts: The interrupt number. The interrupt specifier format depends on
+	      the interrupt controller and of its driver.
+- clocks: Must contain the clock source, usually from the North Bridge clocks.
+- num-cs: The number of chip selects that is supported by this SPI Controller
+- #address-cells: should be 1.
+- #size-cells: should be 0.
+
+Example:
+
+	spi0: spi at 10600 {
+		compatible = "marvell,armada-3700-spi";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <0x10600 0x5d>;
+		clocks = <&nb_perih_clk 7>;
+		interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>;
+		num-cs = <4>;
+	};
-- 
2.9.3
