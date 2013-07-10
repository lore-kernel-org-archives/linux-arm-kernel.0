From: voice.shen@atmel.com (Bo Shen)
Date: Wed, 10 Jul 2013 17:51:07 +0800
Subject: [PATCH 1/3] arm: atmel: at91sam9n12: add pinctrl of TWI
In-Reply-To: <1373449869-5083-1-git-send-email-voice.shen@atmel.com>
References: <1373449869-5083-1-git-send-email-voice.shen@atmel.com>
Message-ID: <1373449869-5083-2-git-send-email-voice.shen@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

add pinctrl of TWI for at91sam9n12 SoC

Signed-off-by: Bo Shen <voice.shen@atmel.com>
---
 arch/arm/boot/dts/at91sam9n12.dtsi |   20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/at91sam9n12.dtsi b/arch/arm/boot/dts/at91sam9n12.dtsi
index bb7f564..3db62f6 100644
--- a/arch/arm/boot/dts/at91sam9n12.dtsi
+++ b/arch/arm/boot/dts/at91sam9n12.dtsi
@@ -291,6 +291,22 @@
 					};
 				};
 
+				i2c0 {
+					pinctrl_i2c0: i2c0-0 {
+						atmel,pins =
+							<AT91_PIOA 30 AT91_PERIPH_A AT91_PINCTRL_NONE	/* PA30 periph A I2C0 data */
+							 AT91_PIOA 31 AT91_PERIPH_A AT91_PINCTRL_NONE>;	/* PA31 periph A I2C0 clock */
+					};
+				};
+
+				i2c1 {
+					pinctrl_i2c1: i2c1-0 {
+						atmel,pins =
+							<AT91_PIOC 0 AT91_PERIPH_C AT91_PINCTRL_NONE	/* PC0 periph C I2C1 data */
+							 AT91_PIOC 1 AT91_PERIPH_C AT91_PINCTRL_NONE>;	/* PC1 periph C I2C1 clock */
+					};
+				};
+
 				tcb0 {
 					pinctrl_tcb0_tclk0: tcb0_tclk0-0 {
 						atmel,pins = <AT91_PIOA 24 AT91_PERIPH_A AT91_PINCTRL_NONE>;
@@ -471,6 +487,8 @@
 				dma-names = "tx", "rx";
 				#address-cells = <1>;
 				#size-cells = <0>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_i2c0>;
 				status = "disabled";
 			};
 
@@ -483,6 +501,8 @@
 				dma-names = "tx", "rx";
 				#address-cells = <1>;
 				#size-cells = <0>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_i2c1>;
 				status = "disabled";
 			};
 
-- 
1.7.9.5
