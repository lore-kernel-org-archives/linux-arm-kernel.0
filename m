From: b.brezillon@overkiz.com (Boris BREZILLON)
Date: Tue, 17 Dec 2013 12:01:34 +0100
Subject: [PATCH] spi/atmel: document clock properties
Message-ID: <1387278095-5118-1-git-send-email-b.brezillon@overkiz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Document the clock properties required by the spi-atmel driver.

Signed-off-by: Boris BREZILLON <b.brezillon@overkiz.com>
---
 .../devicetree/bindings/spi/spi_atmel.txt          |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/spi_atmel.txt b/Documentation/devicetree/bindings/spi/spi_atmel.txt
index 07e04cd..4f8184d 100644
--- a/Documentation/devicetree/bindings/spi/spi_atmel.txt
+++ b/Documentation/devicetree/bindings/spi/spi_atmel.txt
@@ -5,6 +5,9 @@ Required properties:
 - reg: Address and length of the register set for the device
 - interrupts: Should contain spi interrupt
 - cs-gpios: chipselects
+- clock-names: tuple listing input clock names.
+	Required elements: "spi_clk"
+- clocks: phandles to input clocks.
 
 Example:
 
@@ -14,6 +17,8 @@ spi1: spi at fffcc000 {
 	interrupts = <13 4 5>;
 	#address-cells = <1>;
 	#size-cells = <0>;
+	clocks = <&spi1_clk>;
+	clock-names = "spi_clk";
 	cs-gpios = <&pioB 3 0>;
 	status = "okay";
 
-- 
1.7.9.5
