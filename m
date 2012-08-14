From: richard.genoud@gmail.com (Richard Genoud)
Date: Tue, 14 Aug 2012 15:49:35 +0200
Subject: [PATCH 21/23] spi-atmel OF: complete documentation
In-Reply-To: <1344952177-18385-1-git-send-email-richard.genoud@gmail.com>
References: <1344952177-18385-1-git-send-email-richard.genoud@gmail.com>
Message-ID: <1344952177-18385-22-git-send-email-richard.genoud@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Richard Genoud <richard.genoud@gmail.com>
---
 .../devicetree/bindings/spi/spi_atmel.txt          |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/spi_atmel.txt b/Documentation/devicetree/bindings/spi/spi_atmel.txt
index 7ec3d8d..6d2e5e1 100644
--- a/Documentation/devicetree/bindings/spi/spi_atmel.txt
+++ b/Documentation/devicetree/bindings/spi/spi_atmel.txt
@@ -4,3 +4,18 @@ Required properties:
 - compatible : should be "atmel,at91rm9200-spi".
 - reg: Address and length of the register set for the device
 - interrupts: Should contain macb interrupt
+- cs-gpio: Should contain the GPIOs used for chipselect.
+
+spi0: spi at f0000000 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	compatible = "atmel,at91rm9200-spi";
+	reg = <0xf0000000 0x100>;
+	interrupts = <13 4>;
+	cs-gpios = <&pioA 14 0
+		    &pioA 7 0 /* conflicts with TXD2 */
+		    &pioA 1 0 /* conflicts with RXD0 */
+		    &pioB 3 0 /* conflicts with ERXDV */
+		   >;
+	status = "disabled";
+};
-- 
1.7.2.5
