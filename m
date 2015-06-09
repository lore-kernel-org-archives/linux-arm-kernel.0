From: cyrille.pitchen@atmel.com (Cyrille Pitchen)
Date: Tue, 9 Jun 2015 13:53:53 +0200
Subject: [PATCH v3 2/3] spi: atmel: update DT bindings documentation
In-Reply-To: <cover.1433850255.git.cyrille.pitchen@atmel.com>
References: <cover.1433850255.git.cyrille.pitchen@atmel.com>
Message-ID: <ce7c16faafaa24f5bb711115c0eea1f8992d08c3.1433850255.git.cyrille.pitchen@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

- add new property "atmel,fifo-size"
- change "cs-gpios" to optional for SPI controller version >= 2.

Signed-off-by: Cyrille Pitchen <cyrille.pitchen@atmel.com>
---
 Documentation/devicetree/bindings/spi/spi_atmel.txt | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/spi/spi_atmel.txt b/Documentation/devicetree/bindings/spi/spi_atmel.txt
index 4f8184d..fb588b3 100644
--- a/Documentation/devicetree/bindings/spi/spi_atmel.txt
+++ b/Documentation/devicetree/bindings/spi/spi_atmel.txt
@@ -4,11 +4,16 @@ Required properties:
 - compatible : should be "atmel,at91rm9200-spi".
 - reg: Address and length of the register set for the device
 - interrupts: Should contain spi interrupt
-- cs-gpios: chipselects
+- cs-gpios: chipselects (optional for SPI controller version >= 2 with the
+  Chip Select Active After Transfer feature).
 - clock-names: tuple listing input clock names.
 	Required elements: "spi_clk"
 - clocks: phandles to input clocks.
 
+Optional properties:
+- atmel,fifo-size: maximum number of data the RX and TX FIFOs can store for FIFO
+  capable SPI controllers.
+
 Example:
 
 spi1: spi at fffcc000 {
@@ -20,6 +25,7 @@ spi1: spi at fffcc000 {
 	clocks = <&spi1_clk>;
 	clock-names = "spi_clk";
 	cs-gpios = <&pioB 3 0>;
+	atmel,fifo-size = <32>;
 	status = "okay";
 
 	mmc-slot at 0 {
-- 
1.8.2.2
