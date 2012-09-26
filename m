From: wenyou.yang@atmel.com (Wenyou Yang)
Date: Wed, 26 Sep 2012 14:50:59 +0800
Subject: [PATCH 4/6] ARM: dts: add spi nodes for atmel SoCs
In-Reply-To: <1348642261-27554-1-git-send-email-wenyou.yang@atmel.com>
References: <1348642261-27554-1-git-send-email-wenyou.yang@atmel.com>
Message-ID: <1348642261-27554-5-git-send-email-wenyou.yang@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
---
 arch/arm/boot/dts/at91sam9260.dtsi |   34 ++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/at91sam9263.dtsi |   34 ++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/at91sam9g45.dtsi |   34 ++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/at91sam9n12.dtsi |   34 ++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/at91sam9x5.dtsi  |   34 ++++++++++++++++++++++++++++++++++
 5 files changed, 170 insertions(+)

diff --git a/arch/arm/boot/dts/at91sam9260.dtsi b/arch/arm/boot/dts/at91sam9260.dtsi
index 7c95f76..36be91f 100644
--- a/arch/arm/boot/dts/at91sam9260.dtsi
+++ b/arch/arm/boot/dts/at91sam9260.dtsi
@@ -236,6 +236,40 @@
 					trigger-external;
 				};
 			};
+
+			spi0: spi at fffc8000 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "atmel,at91rm9200-spi";
+				reg = <0xfffc8000 0x100>;
+				interrupts = <12 4 3>;
+				cs-gpios = <&pioA 3 0
+					    &pioC 11 0
+					    &pioC 16 0
+					    &pioC 17 0
+					   >;
+				has_dma_support = <0>;
+				has_pdc_support = <1>;
+				is_ver2 = <1>;
+				status = "disabled";
+			};
+
+			spi1: spi at fffcc000 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "atmel,at91rm9200-spi";
+				reg = <0xfffcc000 0x100>;
+				interrupts = <13 4 3>;
+				cs-gpios = <&pioB 3 0
+					    &pioC 5 0
+					    &pioC 4 0
+					    &pioC 3 0
+					   >;
+				has_dma_support = <0>;
+				has_pdc_support = <1>;
+				is_ver2 = <1>;
+				status = "disabled";
+			};
 		};
 
 		nand0: nand at 40000000 {
diff --git a/arch/arm/boot/dts/at91sam9263.dtsi b/arch/arm/boot/dts/at91sam9263.dtsi
index 195019b..bb375e4 100644
--- a/arch/arm/boot/dts/at91sam9263.dtsi
+++ b/arch/arm/boot/dts/at91sam9263.dtsi
@@ -185,6 +185,40 @@
 				interrupts = <24 4 2>;
 				status = "disabled";
 			};
+
+			spi0: spi at fffa4000 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "atmel,at91rm9200-spi";
+				reg = <0xfffa4000 0x100>;
+				interrupts = <14 4 3>;
+				cs-gpios = <&pioA 5 0
+					    &pioA 3 0
+					    &pioA 4 0
+					    &pioB 11 0
+					   >;
+				has_dma_support = <0>;
+				has_pdc_support = <1>;
+				is_ver2 = <1>;
+				status = "disabled";
+			};
+
+			spi1: spi at fffa8000 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "atmel,at91rm9200-spi";
+				reg = <0xfffa8000 0x100>;
+				interrupts = <15 4 3>;
+				cs-gpios = <&pioB 15 0
+					    &pioB 16 0
+					    &pioB 17 0
+					    &pioB 18 0
+					   >;
+				has_dma_support = <0>;
+				has_pdc_support = <1>;
+				is_ver2 = <1>;
+				status = "disabled";
+			};
 		};
 
 		nand0: nand at 40000000 {
diff --git a/arch/arm/boot/dts/at91sam9g45.dtsi b/arch/arm/boot/dts/at91sam9g45.dtsi
index 63751b1..1d96d32 100644
--- a/arch/arm/boot/dts/at91sam9g45.dtsi
+++ b/arch/arm/boot/dts/at91sam9g45.dtsi
@@ -242,6 +242,40 @@
 					trigger-value = <0x6>;
 				};
 			};
+
+			spi0: spi at fffa4000 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "atmel,at91rm9200-spi";
+				reg = <0xfffa4000 0x100>;
+				interrupts = <14 4 3>;
+				cs-gpios = <&pioB 3 0
+					    &pioB 18 0
+					    &pioB 19 0
+					    &pioD 27 0
+					   >;
+				has_dma_support = <0>;
+				has_pdc_support = <1>;
+				is_ver2 = <1>;
+				status = "disabled";
+			};
+
+			spi1: spi at fffa8000 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "atmel,at91rm9200-spi";
+				reg = <0xfffa8000 0x100>;
+				interrupts = <15 4 3>;
+				cs-gpios = <&pioB 17 0
+					    &pioD 28 0
+					    &pioD 18 0
+					    &pioD 19 0
+					   >;
+				has_dma_support = <0>;
+				has_pdc_support = <1>;
+				is_ver2 = <1>;
+				status = "disabled";
+			};
 		};
 
 		nand0: nand at 40000000 {
diff --git a/arch/arm/boot/dts/at91sam9n12.dtsi b/arch/arm/boot/dts/at91sam9n12.dtsi
index ef9336a..c6868a2 100644
--- a/arch/arm/boot/dts/at91sam9n12.dtsi
+++ b/arch/arm/boot/dts/at91sam9n12.dtsi
@@ -182,6 +182,40 @@
 				atmel,use-dma-tx;
 				status = "disabled";
 			};
+
+			spi0: spi at f0000000 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "atmel,at91rm9200-spi";
+				reg = <0xf0000000 0x100>;
+				interrupts = <13 4 3>;
+				cs-gpios = <&pioA 14 0
+					    &pioA 7 0
+					    &pioA 1 0
+					    &pioB 3 0
+					   >;
+				has_dma_support = <1>;
+				has_pdc_support = <0>;
+				is_ver2 = <1>;
+				status = "disabled";
+			};
+
+			spi1: spi at f0004000 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "atmel,at91rm9200-spi";
+				reg = <0xf0004000 0x100>;
+				interrupts = <14 4 3>;
+				cs-gpios = <&pioA 8 0
+					    &pioA 0 0
+					    &pioA 31 0
+					    &pioA 30 0
+					   >;
+				has_dma_support = <1>;
+				has_pdc_support = <0>;
+				is_ver2 = <1>;
+				status = "disabled";
+			};
 		};
 
 		nand0: nand at 40000000 {
diff --git a/arch/arm/boot/dts/at91sam9x5.dtsi b/arch/arm/boot/dts/at91sam9x5.dtsi
index 8a387a8..f124473 100644
--- a/arch/arm/boot/dts/at91sam9x5.dtsi
+++ b/arch/arm/boot/dts/at91sam9x5.dtsi
@@ -233,6 +233,40 @@
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
+				has_dma_support = <1>;
+				has_pdc_support = <0>;
+				is_ver2 = <1>;
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
+				has_dma_support = <1>;
+				has_pdc_support = <0>;
+				is_ver2 = <1>;
+				status = "disabled";
+			};
 		};
 
 		nand0: nand at 40000000 {
-- 
1.7.9.5
