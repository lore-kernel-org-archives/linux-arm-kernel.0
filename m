From: richard.genoud@gmail.com (Richard Genoud)
Date: Tue, 14 Aug 2012 15:49:33 +0200
Subject: [PATCH 19/23] spi-atmel: add sam9x5 SPI in device tree
In-Reply-To: <1344952177-18385-1-git-send-email-richard.genoud@gmail.com>
References: <1344952177-18385-1-git-send-email-richard.genoud@gmail.com>
Message-ID: <1344952177-18385-20-git-send-email-richard.genoud@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Richard Genoud <richard.genoud@gmail.com>
---
 arch/arm/boot/dts/at91sam9x5.dtsi |   30 ++++++++++++++++++++++++++++++
 1 files changed, 30 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/at91sam9x5.dtsi b/arch/arm/boot/dts/at91sam9x5.dtsi
index e58965d6..8cb8b0d 100644
--- a/arch/arm/boot/dts/at91sam9x5.dtsi
+++ b/arch/arm/boot/dts/at91sam9x5.dtsi
@@ -344,6 +344,36 @@
 					trigger-value = <0x6>;
 				};
 			};
+
+			spi0: spi at f0000000 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "atmel,at91rm9200-spi";
+				reg = <0xf0000000 0x100>;
+				interrupts = <13 4 3>;
+				cs-gpios = <&pioA 14 0
+					    &pioA 7 0 /* conflicts with TXD2 */
+					    &pioA 1 0 /* conflicts with RXD0 */
+					    &pioB 3 0 /* conflicts with ERXDV */
+					   >;
+				dma-mask = <0xffffffff>;
+				status = "disabled";
+			};
+
+			spi1: spi at f0004000 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "atmel,at91rm9200-spi";
+				reg = <0xf0004000 0x100>;
+				interrupts = <14 4 3>;
+				cs-gpios = <&pioA 8 0 /* conflitcs with RXD2 */
+					    &pioA 0 0 /* conflitcs with TXD0 */
+					    &pioA 31 0 /* conflitcs with TWCK0 */
+					    &pioA 30 0 /* conflitcs with TWD0 */
+					   >;
+				dma-mask = <0xffffffff>;
+				status = "disabled";
+			};
 		};
 
 		nand0: nand at 40000000 {
-- 
1.7.2.5
