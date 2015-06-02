From: cyrille.pitchen@atmel.com (Cyrille Pitchen)
Date: Tue, 2 Jun 2015 18:57:18 +0200
Subject: [PATCH v2 1/2] clk: at91: add a new compatible string for Flexcom in
 the DT documentation
In-Reply-To: <cover.1433264017.git.cyrille.pitchen@atmel.com>
References: <cover.1433264017.git.cyrille.pitchen@atmel.com>
Message-ID: <359f6b85c3a8b51a0ea35bacdbdc0443b9fbedcc.1433264017.git.cyrille.pitchen@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patches documents the new bindings for the Flexcom clock, which will
be introduced by Atmel sama5d2x chips.

Signed-off-by: Cyrille Pitchen <cyrille.pitchen@atmel.com>
---
 .../devicetree/bindings/clock/at91-clock.txt         | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/at91-clock.txt b/Documentation/devicetree/bindings/clock/at91-clock.txt
index 7a4d492..df4f40b 100644
--- a/Documentation/devicetree/bindings/clock/at91-clock.txt
+++ b/Documentation/devicetree/bindings/clock/at91-clock.txt
@@ -77,6 +77,9 @@ Required properties:
 	"atmel,sama5d4-clk-h32mx":
 		at91 h32mx clock
 
+	"atmel,sama5d2-flexcom":
+		at91 flexcom clock
+
 Required properties for SCKC node:
 - reg : defines the IO memory reserved for the SCKC.
 - #size-cells : shall be 0 (reg is used to encode clk id).
@@ -461,3 +464,20 @@ For example:
 		compatible = "atmel,sama5d4-clk-h32mx";
 		clocks = <&mck>;
 	};
+
+Required properties for flexcom clock:
+- #clock-cells : from common clock binding; shall be set to 0.
+- clocks : shall be the Flexcom peripheral clock from PMC.
+- reg : shall be the range for Flexcom dedicated I/O registers (without USART,
+  TWI or SPI registers).
+- atmel,flexcom-mode : shall be a string value among { "spi", "usart", "i2c",
+  "twi" }. "i2c" and "twi" are synonymous.
+
+For example:
+	flx0: flexcom at f8034000 {
+		compatible = "atmel,sama5d2-flexcom";
+		#clock-cells = <0>;
+		reg = <0xf8034000 0x200>;
+		clocks = <&flx0_clk>;
+		atmel,flexcom-mode = "spi";
+	};
-- 
1.8.2.2
