From: hayashibara.keiji@socionext.com (Keiji Hayashibara)
Date: Fri, 26 Oct 2018 14:58:45 +0900
Subject: [PATCH v2 2/2] spi: uniphier: re-add addressing properties
In-Reply-To: <1540533525-1816-1-git-send-email-hayashibara.keiji@socionext.com>
References: <1540533525-1816-1-git-send-email-hayashibara.keiji@socionext.com>
Message-ID: <1540533525-1816-3-git-send-email-hayashibara.keiji@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In commit 7662d1dc17d4 ("spi: uniphier: fix incorrect property items")
addressing properties of #address-cells and #size-cells were removed.
Since it is not necessary to remove them, they are back again.

Signed-off-by: Keiji Hayashibara <hayashibara.keiji@socionext.com>
---
 Documentation/devicetree/bindings/spi/spi-uniphier.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/spi-uniphier.txt b/Documentation/devicetree/bindings/spi/spi-uniphier.txt
index b04e66a..e120157 100644
--- a/Documentation/devicetree/bindings/spi/spi-uniphier.txt
+++ b/Documentation/devicetree/bindings/spi/spi-uniphier.txt
@@ -5,6 +5,8 @@ UniPhier SoCs have SCSSI which supports SPI single channel.
 Required properties:
  - compatible: should be "socionext,uniphier-scssi"
  - reg: address and length of the spi master registers
+ - #address-cells: must be <1>, see spi-bus.txt
+ - #size-cells: must be <0>, see spi-bus.txt
  - interrupts: a single interrupt specifier
  - pinctrl-names: should be "default"
  - pinctrl-0: pin control state for the default mode
@@ -16,6 +18,8 @@ Example:
 spi0: spi at 54006000 {
 	compatible = "socionext,uniphier-scssi";
 	reg = <0x54006000 0x100>;
+	#address-cells = <1>;
+	#size-cells = <0>;
 	interrupts = <0 39 4>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_spi0>;
-- 
2.7.4
