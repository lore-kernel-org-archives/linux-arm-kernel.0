From: voice.shen@atmel.com (Bo Shen)
Date: Thu, 11 Jul 2013 11:30:45 +0800
Subject: [PATCH v2 2/3] arm: atmel: at91sam9n12: add qt1070 support
In-Reply-To: <1373513446-18215-1-git-send-email-voice.shen@atmel.com>
References: <1373513446-18215-1-git-send-email-voice.shen@atmel.com>
Message-ID: <1373513446-18215-3-git-send-email-voice.shen@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

add qt1070 support on at91sam9n12ek board

Signed-off-by: Bo Shen <voice.shen@atmel.com>

---
Changes in v2:
  - using micro for interrupt trigger mode

 arch/arm/boot/dts/at91sam9n12ek.dts |   16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/at91sam9n12ek.dts b/arch/arm/boot/dts/at91sam9n12ek.dts
index d59b70c..7a95a28 100644
--- a/arch/arm/boot/dts/at91sam9n12ek.dts
+++ b/arch/arm/boot/dts/at91sam9n12ek.dts
@@ -40,6 +40,15 @@
 
 			i2c0: i2c at f8010000 {
 				status = "okay";
+
+				qt1070: keyboard at 1b {
+					compatible = "qt1070";
+					reg = <0x1b>;
+					interrupt-parent = <&pioA>;
+					interrupts = <2 IRQ_TYPE_EDGE_FALLING>;
+					pinctrl-names = "default";
+					pinctrl-0 = <&pinctrl_qt1070_irq>;
+				};
 			};
 
 			i2c1: i2c at f8014000 {
@@ -66,6 +75,13 @@
 							<AT91_PIOA 7 AT91_PERIPH_GPIO AT91_PINCTRL_PULL_UP_DEGLITCH>;	/* PA7 gpio CD pin pull up and deglitch */
 					};
 				};
+
+				qt1070 {
+					pinctrl_qt1070_irq: qt1070_irq {
+						atmel,pins =
+							<AT91_PIOA 2 AT91_PERIPH_GPIO AT91_PINCTRL_PULL_UP_DEGLITCH>;
+					};
+				};
 			};
 
 			spi0: spi at f0000000 {
-- 
1.7.9.5
