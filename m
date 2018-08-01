From: hayashibara.keiji@socionext.com (Keiji Hayashibara)
Date: Wed,  1 Aug 2018 16:29:11 +0900
Subject: [PATCH v3 1/2] dt-bindings: spi: add DT bindings for UniPhier SPI
 controller
In-Reply-To: <1533108552-19878-1-git-send-email-hayashibara.keiji@socionext.com>
References: <1533108552-19878-1-git-send-email-hayashibara.keiji@socionext.com>
Message-ID: <1533108552-19878-2-git-send-email-hayashibara.keiji@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>

Add DT bindings for SPI controller implemented in UniPhier SoCs.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Signed-off-by: Keiji Hayashibara <hayashibara.keiji@socionext.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/spi/spi-uniphier.txt       | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-uniphier.txt

diff --git a/Documentation/devicetree/bindings/spi/spi-uniphier.txt b/Documentation/devicetree/bindings/spi/spi-uniphier.txt
new file mode 100644
index 0000000..504a4ec
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/spi-uniphier.txt
@@ -0,0 +1,22 @@
+Socionext UniPhier SPI controller driver
+
+UniPhier SoCs have SCSSI which supports SPI single channel.
+
+Required properties:
+ - compatible: should be "socionext,uniphier-scssi"
+ - reg: address and length of the spi master registers
+ - #address-cells: must be <1>, see spi-bus.txt
+ - #size-cells: must be <0>, see spi-bus.txt
+ - clocks: A phandle to the clock for the device.
+ - resets: A phandle to the reset control for the device.
+
+Example:
+
+spi0: spi at 54006000 {
+	compatible = "socionext,uniphier-scssi";
+	reg = <0x54006000 0x100>;
+	#address-cells = <1>;
+	#size-cells = <0>;
+	clocks = <&peri_clk 11>;
+	resets = <&peri_rst 11>;
+};
-- 
2.7.4
