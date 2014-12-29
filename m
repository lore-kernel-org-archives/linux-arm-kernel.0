From: alexanders83@web.de (Alexander Stein)
Date: Mon, 29 Dec 2014 13:08:41 +0100
Subject: [PATCH v3] ARM: at91/dt: sam9263: Add ac97 device node
In-Reply-To: <1419854922-29338-1-git-send-email-alexanders83@web.de>
References: <1419854922-29338-1-git-send-email-alexanders83@web.de>
Message-ID: <1419854922-29338-3-git-send-email-alexanders83@web.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the device node for the ac97 controller.

Signed-off-by: Alexander Stein <alexanders83@web.de>
Acked-By Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
Changes in v3:
* Renamed the compatible string to atmel,at91sam9263-ac97c
* Added 'Acked-By Alexandre Belloni <alexandre.belloni@free-electrons.com>'

 arch/arm/boot/dts/at91sam9263.dtsi | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm/boot/dts/at91sam9263.dtsi b/arch/arm/boot/dts/at91sam9263.dtsi
index 6283785..2e67e38 100644
--- a/arch/arm/boot/dts/at91sam9263.dtsi
+++ b/arch/arm/boot/dts/at91sam9263.dtsi
@@ -700,6 +700,16 @@
 					};
 				};
 
+				ac97 {
+					pinctrl_ac97: ac97-0 {
+						atmel,pins =
+							<AT91_PIOB 0 AT91_PERIPH_A AT91_PINCTRL_NONE	/* PB12 periph A AC97FS pin */
+							 AT91_PIOB 1 AT91_PERIPH_A AT91_PINCTRL_NONE	/* PB13 periph A AC97CK pin */
+							 AT91_PIOB 2 AT91_PERIPH_A AT91_PINCTRL_NONE	/* PB14 periph A AC97TX pin */
+							 AT91_PIOB 3 AT91_PERIPH_A AT91_PINCTRL_NONE>;	/* PB14 periph A AC97RX pin */
+					};
+				};
+
 				pioA: gpio at fffff200 {
 					compatible = "atmel,at91rm9200-gpio";
 					reg = <0xfffff200 0x200>;
@@ -828,6 +838,17 @@
 				status = "disabled";
 			};
 
+			ac97: sound at fffa0000 {
+				compatible = "atmel,at91sam9263-ac97c";
+				reg = <0xfffa0000 0x4000>;
+				interrupts = <18 IRQ_TYPE_LEVEL_HIGH 5>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_ac97>;
+				clocks = <&ac97_clk>;
+				clock-names = "ac97_clk";
+				status = "disabled";
+			};
+
 			macb0: ethernet at fffbc000 {
 				compatible = "cdns,at32ap7000-macb", "cdns,macb";
 				reg = <0xfffbc000 0x100>;
-- 
2.2.1
