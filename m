From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Thu,  5 Mar 2015 13:11:21 +0100
Subject: [PATCH v2 4/9] ARM: at91/dt: introduce atmel,<chip>-dbgu
In-Reply-To: <1425557486-3534-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1425557486-3534-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1425557486-3534-5-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The DBGU is not a simple UART and we need to be able to distinguish it from the
other UARTs, in particular to get its address and check the chip id.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 Documentation/devicetree/bindings/serial/atmel-usart.txt | 3 ++-
 arch/arm/boot/dts/at91rm9200.dtsi                        | 2 +-
 arch/arm/boot/dts/at91sam9260.dtsi                       | 2 +-
 arch/arm/boot/dts/at91sam9261.dtsi                       | 2 +-
 arch/arm/boot/dts/at91sam9263.dtsi                       | 2 +-
 arch/arm/boot/dts/at91sam9g45.dtsi                       | 2 +-
 arch/arm/boot/dts/at91sam9n12.dtsi                       | 2 +-
 arch/arm/boot/dts/at91sam9rl.dtsi                        | 2 +-
 arch/arm/boot/dts/at91sam9x5.dtsi                        | 2 +-
 arch/arm/boot/dts/sama5d3.dtsi                           | 2 +-
 arch/arm/boot/dts/sama5d4.dtsi                           | 2 +-
 11 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/Documentation/devicetree/bindings/serial/atmel-usart.txt b/Documentation/devicetree/bindings/serial/atmel-usart.txt
index a6391e70a8fd..90787aa2e648 100644
--- a/Documentation/devicetree/bindings/serial/atmel-usart.txt
+++ b/Documentation/devicetree/bindings/serial/atmel-usart.txt
@@ -1,9 +1,10 @@
 * Atmel Universal Synchronous Asynchronous Receiver/Transmitter (USART)
 
 Required properties:
-- compatible: Should be "atmel,<chip>-usart"
+- compatible: Should be "atmel,<chip>-usart" or "atmel,<chip>-dbgu"
   The compatible <chip> indicated will be the first SoC to support an
   additional mode or an USART new feature.
+  For the dbgu UART, use "atmel,<chip>-dbgu", "atmel,<chip>-usart"
 - reg: Should contain registers location and length
 - interrupts: Should contain interrupt
 - clock-names: tuple listing input clock names.
diff --git a/arch/arm/boot/dts/at91rm9200.dtsi b/arch/arm/boot/dts/at91rm9200.dtsi
index 21c2b504f977..c515e4b160be 100644
--- a/arch/arm/boot/dts/at91rm9200.dtsi
+++ b/arch/arm/boot/dts/at91rm9200.dtsi
@@ -830,7 +830,7 @@
 			};
 
 			dbgu: serial at fffff200 {
-				compatible = "atmel,at91rm9200-usart";
+				compatible = "atmel,at91rm9200-dbgu", "atmel,at91rm9200-usart";
 				reg = <0xfffff200 0x200>;
 				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
 				pinctrl-names = "default";
diff --git a/arch/arm/boot/dts/at91sam9260.dtsi b/arch/arm/boot/dts/at91sam9260.dtsi
index fff0ee69aab4..9ea347eff3a7 100644
--- a/arch/arm/boot/dts/at91sam9260.dtsi
+++ b/arch/arm/boot/dts/at91sam9260.dtsi
@@ -753,7 +753,7 @@
 			};
 
 			dbgu: serial at fffff200 {
-				compatible = "atmel,at91sam9260-usart";
+				compatible = "atmel,at91sam9260-dbgu", "atmel,at91sam9260-usart";
 				reg = <0xfffff200 0x200>;
 				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
 				pinctrl-names = "default";
diff --git a/arch/arm/boot/dts/at91sam9261.dtsi b/arch/arm/boot/dts/at91sam9261.dtsi
index e247b0b5fdab..45973554f229 100644
--- a/arch/arm/boot/dts/at91sam9261.dtsi
+++ b/arch/arm/boot/dts/at91sam9261.dtsi
@@ -275,7 +275,7 @@
 			};
 
 			dbgu: serial at fffff200 {
-				compatible = "atmel,at91sam9260-usart";
+				compatible = "atmel,at91sam9260-dbgu", "atmel,at91sam9260-usart";
 				reg = <0xfffff200 0x200>;
 				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
 				pinctrl-names = "default";
diff --git a/arch/arm/boot/dts/at91sam9263.dtsi b/arch/arm/boot/dts/at91sam9263.dtsi
index 1f67bb4c144e..111a4e029cca 100644
--- a/arch/arm/boot/dts/at91sam9263.dtsi
+++ b/arch/arm/boot/dts/at91sam9263.dtsi
@@ -762,7 +762,7 @@
 			};
 
 			dbgu: serial at ffffee00 {
-				compatible = "atmel,at91sam9260-usart";
+				compatible = "atmel,at91sam9260-dbgu", "atmel,at91sam9260-usart";
 				reg = <0xffffee00 0x200>;
 				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
 				pinctrl-names = "default";
diff --git a/arch/arm/boot/dts/at91sam9g45.dtsi b/arch/arm/boot/dts/at91sam9g45.dtsi
index ee80aa9c0759..d5ec0fb935fb 100644
--- a/arch/arm/boot/dts/at91sam9g45.dtsi
+++ b/arch/arm/boot/dts/at91sam9g45.dtsi
@@ -893,7 +893,7 @@
 			};
 
 			dbgu: serial at ffffee00 {
-				compatible = "atmel,at91sam9260-usart";
+				compatible = "atmel,at91sam9260-dbgu", "atmel,at91sam9260-usart";
 				reg = <0xffffee00 0x200>;
 				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
 				pinctrl-names = "default";
diff --git a/arch/arm/boot/dts/at91sam9n12.dtsi b/arch/arm/boot/dts/at91sam9n12.dtsi
index c2666a7cb5b1..00934c005ff9 100644
--- a/arch/arm/boot/dts/at91sam9n12.dtsi
+++ b/arch/arm/boot/dts/at91sam9n12.dtsi
@@ -757,7 +757,7 @@
 			};
 
 			dbgu: serial at fffff200 {
-				compatible = "atmel,at91sam9260-usart";
+				compatible = "atmel,at91sam9260-dbgu", "atmel,at91sam9260-usart";
 				reg = <0xfffff200 0x200>;
 				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
 				pinctrl-names = "default";
diff --git a/arch/arm/boot/dts/at91sam9rl.dtsi b/arch/arm/boot/dts/at91sam9rl.dtsi
index 40f645b8fe25..ebfd5ce9cb38 100644
--- a/arch/arm/boot/dts/at91sam9rl.dtsi
+++ b/arch/arm/boot/dts/at91sam9rl.dtsi
@@ -377,7 +377,7 @@
 			};
 
 			dbgu: serial at fffff200 {
-				compatible = "atmel,at91sam9260-usart";
+				compatible = "atmel,at91sam9260-dbgu", "atmel,at91sam9260-usart";
 				reg = <0xfffff200 0x200>;
 				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
 				pinctrl-names = "default";
diff --git a/arch/arm/boot/dts/at91sam9x5.dtsi b/arch/arm/boot/dts/at91sam9x5.dtsi
index 818dabdd8c0e..ce1494622205 100644
--- a/arch/arm/boot/dts/at91sam9x5.dtsi
+++ b/arch/arm/boot/dts/at91sam9x5.dtsi
@@ -860,7 +860,7 @@
 			};
 
 			dbgu: serial at fffff200 {
-				compatible = "atmel,at91sam9260-usart";
+				compatible = "atmel,at91sam9260-dbgu", "atmel,at91sam9260-usart";
 				reg = <0xfffff200 0x200>;
 				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
 				pinctrl-names = "default";
diff --git a/arch/arm/boot/dts/sama5d3.dtsi b/arch/arm/boot/dts/sama5d3.dtsi
index 261311bdf65b..8e850d1bc588 100644
--- a/arch/arm/boot/dts/sama5d3.dtsi
+++ b/arch/arm/boot/dts/sama5d3.dtsi
@@ -439,7 +439,7 @@
 			};
 
 			dbgu: serial at ffffee00 {
-				compatible = "atmel,at91sam9260-usart";
+				compatible = "atmel,at91sam9260-dbgu", "atmel,at91sam9260-usart";
 				reg = <0xffffee00 0x200>;
 				interrupts = <2 IRQ_TYPE_LEVEL_HIGH 7>;
 				dmas = <&dma1 2 AT91_DMA_CFG_PER_ID(13)>,
diff --git a/arch/arm/boot/dts/sama5d4.dtsi b/arch/arm/boot/dts/sama5d4.dtsi
index d986b41b9654..d3627c4a58e0 100644
--- a/arch/arm/boot/dts/sama5d4.dtsi
+++ b/arch/arm/boot/dts/sama5d4.dtsi
@@ -1063,7 +1063,7 @@
 			};
 
 			dbgu: serial at fc069000 {
-				compatible = "atmel,at91sam9260-usart";
+				compatible = "atmel,at91sam9260-dbgu", "atmel,at91sam9260-usart";
 				reg = <0xfc069000 0x200>;
 				interrupts = <2 IRQ_TYPE_LEVEL_HIGH 7>;
 				pinctrl-names = "default";
-- 
2.1.0
