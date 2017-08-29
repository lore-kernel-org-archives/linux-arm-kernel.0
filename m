From: mirq-linux@rere.qmqm.pl (=?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?=)
Date: Tue, 29 Aug 2017 22:08:53 +0200
Subject: [PATCH 1/2] arm: AT91: enable ac97 controller for at91sam9g45
In-Reply-To: <cover.1504037038.git.mirq-linux@rere.qmqm.pl>
References: <cover.1504037038.git.mirq-linux@rere.qmqm.pl>
Message-ID: <e789197b91251657a45c7a9c1c59c35d163ef85a.1504037038.git.mirq-linux@rere.qmqm.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add AC97 controller node as present on AT91SAM9G45-EKES board.

Signed-off-by: Micha? Miros?aw <mirq-linux@rere.qmqm.pl>
---
 arch/arm/boot/dts/at91sam9g45.dtsi     | 21 +++++++++++++++++++++
 arch/arm/boot/dts/at91sam9m10g45ek.dts |  4 ++++
 2 files changed, 25 insertions(+)

diff --git a/arch/arm/boot/dts/at91sam9g45.dtsi b/arch/arm/boot/dts/at91sam9g45.dtsi
index e567d5fd3f9d..0e69a97695cd 100644
--- a/arch/arm/boot/dts/at91sam9g45.dtsi
+++ b/arch/arm/boot/dts/at91sam9g45.dtsi
@@ -846,6 +846,16 @@
 					};
 				};
 
+				ac97 {
+					pinctrl_ac97: ac97-0 {
+						atmel,pins =
+							<AT91_PIOD 8 AT91_PERIPH_A AT91_PINCTRL_NONE	/* PD8 periph A AC97FS pin */
+							 AT91_PIOD 9 AT91_PERIPH_A AT91_PINCTRL_NONE	/* PD9 periph A AC97CK pin */
+							 AT91_PIOD 7 AT91_PERIPH_A AT91_PINCTRL_NONE	/* PD7 periph A AC97TX pin */
+							 AT91_PIOD 6 AT91_PERIPH_A AT91_PINCTRL_NONE>;	/* PD6 periph A AC97RX pin */
+					};
+				};
+
 				pioA: gpio at fffff200 {
 					compatible = "atmel,at91rm9200-gpio";
 					reg = <0xfffff200 0x200>;
@@ -965,6 +975,17 @@
 				status = "disabled";
 			};
 
+			ac97: sound at fffac000 {
+				compatible = "atmel,at91sam9263-ac97c";
+				reg = <0xfffac000 0x4000>;
+				interrupts = <24 IRQ_TYPE_LEVEL_HIGH 5>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_ac97>;
+				clocks = <&ac97_clk>;
+				clock-names = "ac97_clk";
+				status = "disabled";
+			};
+
 			macb0: ethernet at fffbc000 {
 				compatible = "cdns,at91sam9260-macb", "cdns,macb";
 				reg = <0xfffbc000 0x100>;
diff --git a/arch/arm/boot/dts/at91sam9m10g45ek.dts b/arch/arm/boot/dts/at91sam9m10g45ek.dts
index 2400c99134f7..9cf1f5163fbd 100644
--- a/arch/arm/boot/dts/at91sam9m10g45ek.dts
+++ b/arch/arm/boot/dts/at91sam9m10g45ek.dts
@@ -47,6 +47,10 @@
 				status = "okay";
 			};
 
+			ac97: sound at fffac000 {
+				status = "okay";
+			};
+
 			macb0: ethernet at fffbc000 {
 				phy-mode = "rmii";
 				status = "okay";
-- 
2.11.0
