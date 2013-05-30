From: ludovic.desroches@atmel.com (ludovic.desroches at atmel.com)
Date: Thu, 30 May 2013 18:08:22 +0200
Subject: [PATCH 2/3] ARM: at91: dt: switch DMA DT bindings to pre-processor
In-Reply-To: <1369930103-11963-1-git-send-email-ludovic.desroches@atmel.com>
References: <1369930103-11963-1-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <1369930103-11963-3-git-send-email-ludovic.desroches@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ludovic Desroches <ludovic.desroches@atmel.com>

Acked-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
---
 arch/arm/boot/dts/at91sam9g45.dtsi |  5 +++--
 arch/arm/boot/dts/at91sam9n12.dtsi | 11 ++++++-----
 arch/arm/boot/dts/at91sam9x5.dtsi  | 17 +++++++++--------
 arch/arm/boot/dts/sama5d3.dtsi     | 19 ++++++++++---------
 4 files changed, 28 insertions(+), 24 deletions(-)

diff --git a/arch/arm/boot/dts/at91sam9g45.dtsi b/arch/arm/boot/dts/at91sam9g45.dtsi
index f0091af..fe84404 100644
--- a/arch/arm/boot/dts/at91sam9g45.dtsi
+++ b/arch/arm/boot/dts/at91sam9g45.dtsi
@@ -10,6 +10,7 @@
  */
 
 #include "skeleton.dtsi"
+#include <dt-bindings/dma/at91.h>
 #include <dt-bindings/pinctrl/at91.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/gpio/gpio.h>
@@ -537,7 +538,7 @@
 				compatible = "atmel,hsmci";
 				reg = <0xfff80000 0x600>;
 				interrupts = <11 IRQ_TYPE_LEVEL_HIGH 0>;
-				dmas = <&dma 1 0>;
+				dmas = <&dma 1 AT91_DMA_CFG_PER_ID(0)>;
 				dma-names = "rxtx";
 				#address-cells = <1>;
 				#size-cells = <0>;
@@ -548,7 +549,7 @@
 				compatible = "atmel,hsmci";
 				reg = <0xfffd0000 0x600>;
 				interrupts = <29 IRQ_TYPE_LEVEL_HIGH 0>;
-				dmas = <&dma 1 13>;
+				dmas = <&dma 1 AT91_DMA_CFG_PER_ID(13)>;
 				dma-names = "rxtx";
 				#address-cells = <1>;
 				#size-cells = <0>;
diff --git a/arch/arm/boot/dts/at91sam9n12.dtsi b/arch/arm/boot/dts/at91sam9n12.dtsi
index 566af32..3076693 100644
--- a/arch/arm/boot/dts/at91sam9n12.dtsi
+++ b/arch/arm/boot/dts/at91sam9n12.dtsi
@@ -8,6 +8,7 @@
  */
 
 #include "skeleton.dtsi"
+#include <dt-bindings/dma/at91.h>
 #include <dt-bindings/pinctrl/at91.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/gpio/gpio.h>
@@ -92,7 +93,7 @@
 				compatible = "atmel,hsmci";
 				reg = <0xf0008000 0x600>;
 				interrupts = <12 IRQ_TYPE_LEVEL_HIGH 0>;
-				dmas = <&dma 1 0>;
+				dmas = <&dma 1 AT91_DMA_CFG_PER_ID(0)>;
 				dma-names = "rxtx";
 				#address-cells = <1>;
 				#size-cells = <0>;
@@ -384,8 +385,8 @@
 				compatible = "atmel,at91sam9x5-i2c";
 				reg = <0xf8010000 0x100>;
 				interrupts = <9 IRQ_TYPE_LEVEL_HIGH 6>;
-				dmas = <&dma 1 13>,
-				       <&dma 1 14>;
+				dmas = <&dma 1 AT91_DMA_CFG_PER_ID(13)>,
+				       <&dma 1 AT91_DMA_CFG_PER_ID(14)>;
 				dma-names = "tx", "rx";
 				#address-cells = <1>;
 				#size-cells = <0>;
@@ -396,8 +397,8 @@
 				compatible = "atmel,at91sam9x5-i2c";
 				reg = <0xf8014000 0x100>;
 				interrupts = <10 IRQ_TYPE_LEVEL_HIGH 6>;
-				dmas = <&dma 1 15>,
-				       <&dma 1 16>;
+				dmas = <&dma 1 AT91_DMA_CFG_PER_ID(15)>,
+				       <&dma 1 AT91_DMA_CFG_PER_ID(16)>;
 				dma-names = "tx", "rx";
 				#address-cells = <1>;
 				#size-cells = <0>;
diff --git a/arch/arm/boot/dts/at91sam9x5.dtsi b/arch/arm/boot/dts/at91sam9x5.dtsi
index af91599..a08bf77 100644
--- a/arch/arm/boot/dts/at91sam9x5.dtsi
+++ b/arch/arm/boot/dts/at91sam9x5.dtsi
@@ -10,6 +10,7 @@
  */
 
 #include "skeleton.dtsi"
+#include <dt-bindings/dma/at91.h>
 #include <dt-bindings/pinctrl/at91.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/gpio/gpio.h>
@@ -470,7 +471,7 @@
 				compatible = "atmel,hsmci";
 				reg = <0xf0008000 0x600>;
 				interrupts = <12 IRQ_TYPE_LEVEL_HIGH 0>;
-				dmas = <&dma0 1 0>;
+				dmas = <&dma0 1 AT91_DMA_CFG_PER_ID(0)>;
 				dma-names = "rxtx";
 				#address-cells = <1>;
 				#size-cells = <0>;
@@ -481,7 +482,7 @@
 				compatible = "atmel,hsmci";
 				reg = <0xf000c000 0x600>;
 				interrupts = <26 IRQ_TYPE_LEVEL_HIGH 0>;
-				dmas = <&dma1 1 0>;
+				dmas = <&dma1 1 AT91_DMA_CFG_PER_ID(0)>;
 				dma-names = "rxtx";
 				#address-cells = <1>;
 				#size-cells = <0>;
@@ -544,8 +545,8 @@
 				compatible = "atmel,at91sam9x5-i2c";
 				reg = <0xf8010000 0x100>;
 				interrupts = <9 IRQ_TYPE_LEVEL_HIGH 6>;
-				dmas = <&dma0 1 7>,
-				       <&dma0 1 8>;
+				dmas = <&dma0 1 AT91_DMA_CFG_PER_ID(7)>,
+				       <&dma0 1 AT91_DMA_CFG_PER_ID(8)>;
 				dma-names = "tx", "rx";
 				#address-cells = <1>;
 				#size-cells = <0>;
@@ -558,8 +559,8 @@
 				compatible = "atmel,at91sam9x5-i2c";
 				reg = <0xf8014000 0x100>;
 				interrupts = <10 IRQ_TYPE_LEVEL_HIGH 6>;
-				dmas = <&dma1 1 5>,
-				       <&dma1 1 6>;
+				dmas = <&dma1 1 AT91_DMA_CFG_PER_ID(5)>,
+				       <&dma1 1 AT91_DMA_CFG_PER_ID(6)>;
 				dma-names = "tx", "rx";
 				#address-cells = <1>;
 				#size-cells = <0>;
@@ -572,8 +573,8 @@
 				compatible = "atmel,at91sam9x5-i2c";
 				reg = <0xf8018000 0x100>;
 				interrupts = <11 IRQ_TYPE_LEVEL_HIGH 6>;
-				dmas = <&dma0 1 9>,
-				       <&dma0 1 10>;
+				dmas = <&dma0 1 AT91_DMA_CFG_PER_ID(9)>,
+				       <&dma0 1 AT91_DMA_CFG_PER_ID(10)>;
 				dma-names = "tx", "rx";
 				#address-cells = <1>;
 				#size-cells = <0>;
diff --git a/arch/arm/boot/dts/sama5d3.dtsi b/arch/arm/boot/dts/sama5d3.dtsi
index c00e158..03b8c02 100644
--- a/arch/arm/boot/dts/sama5d3.dtsi
+++ b/arch/arm/boot/dts/sama5d3.dtsi
@@ -9,6 +9,7 @@
  */
 
 #include "skeleton.dtsi"
+#include <dt-bindings/dma/at91.h>
 #include <dt-bindings/pinctrl/at91.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/gpio/gpio.h>
@@ -63,7 +64,7 @@
 				compatible = "atmel,hsmci";
 				reg = <0xf0000000 0x600>;
 				interrupts = <21 IRQ_TYPE_LEVEL_HIGH 0>;
-				dmas = <&dma0 2 0>;
+				dmas = <&dma0 2 AT91_DMA_CFG_PER_ID(0)>;
 				dma-names = "rxtx";
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_mmc0_clk_cmd_dat0 &pinctrl_mmc0_dat1_3 &pinctrl_mmc0_dat4_7>;
@@ -116,8 +117,8 @@
 				compatible = "atmel,at91sam9x5-i2c";
 				reg = <0xf0014000 0x4000>;
 				interrupts = <18 IRQ_TYPE_LEVEL_HIGH 6>;
-				dmas = <&dma0 2 7>,
-				       <&dma0 2 8>;
+				dmas = <&dma0 2 AT91_DMA_CFG_PER_ID(7)>,
+				       <&dma0 2 AT91_DMA_CFG_PER_ID(8)>;
 				dma-names = "tx", "rx";
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_i2c0>;
@@ -130,8 +131,8 @@
 				compatible = "atmel,at91sam9x5-i2c";
 				reg = <0xf0018000 0x4000>;
 				interrupts = <19 IRQ_TYPE_LEVEL_HIGH 6>;
-				dmas = <&dma0 2 9>,
-				       <&dma0 2 10>;
+				dmas = <&dma0 2 AT91_DMA_CFG_PER_ID(9)>,
+				       <&dma0 2 AT91_DMA_CFG_PER_ID(10)>;
 				dma-names = "tx", "rx";
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_i2c1>;
@@ -178,7 +179,7 @@
 				compatible = "atmel,hsmci";
 				reg = <0xf8000000 0x600>;
 				interrupts = <22 IRQ_TYPE_LEVEL_HIGH 0>;
-				dmas = <&dma1 2 0>;
+				dmas = <&dma1 2 AT91_DMA_CFG_PER_ID(0)>;
 				dma-names = "rxtx";
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_mmc1_clk_cmd_dat0 &pinctrl_mmc1_dat1_3>;
@@ -191,7 +192,7 @@
 				compatible = "atmel,hsmci";
 				reg = <0xf8004000 0x600>;
 				interrupts = <23 IRQ_TYPE_LEVEL_HIGH 0>;
-				dmas = <&dma1 2 1>;
+				dmas = <&dma1 2 AT91_DMA_CFG_PER_ID(1)>;
 				dma-names = "rxtx";
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_mmc2_clk_cmd_dat0 &pinctrl_mmc2_dat1_3>;
@@ -309,8 +310,8 @@
 				compatible = "atmel,at91sam9x5-i2c";
 				reg = <0xf801c000 0x4000>;
 				interrupts = <20 IRQ_TYPE_LEVEL_HIGH 6>;
-				dmas = <&dma1 2 11>,
-				       <&dma1 2 12>;
+				dmas = <&dma1 2 AT91_DMA_CFG_PER_ID(11)>,
+				       <&dma1 2 AT91_DMA_CFG_PER_ID(12)>;
 				dma-names = "tx", "rx";
 				#address-cells = <1>;
 				#size-cells = <0>;
-- 
1.7.11.3
