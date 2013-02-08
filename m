From: manabian@gmail.com (Joachim Eastwood)
Date: Fri,  8 Feb 2013 02:25:55 +0100
Subject: [PATCH 2/3] ARM: at91: add pinctrl nodes to i2c-gpio on RM92000 DT
In-Reply-To: <1360286756-29705-1-git-send-email-manabian@gmail.com>
References: <1360286756-29705-1-git-send-email-manabian@gmail.com>
Message-ID: <1360286756-29705-3-git-send-email-manabian@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

GPIO pins used by i2c-gpio must be set to multi drive
(open drain) to work properly.

Signed-off-by: Joachim Eastwood <manabian@gmail.com>
---
 arch/arm/boot/dts/at91rm9200.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/at91rm9200.dtsi b/arch/arm/boot/dts/at91rm9200.dtsi
index a7031c6..5d3ed5a 100644
--- a/arch/arm/boot/dts/at91rm9200.dtsi
+++ b/arch/arm/boot/dts/at91rm9200.dtsi
@@ -383,6 +383,12 @@
 							<0 25 0x1 0x2	/* PA25 periph A with multi drive */
 							 0 26 0x1 0x2>;	/* PA26 periph A with multi drive */
 					};
+
+					pinctrl_twi_gpio: twi_gpio-0 {
+						atmel,pins =
+							<0 25 0x0 0x2	/* PA25 GPIO with multi drive */
+							 0 26 0x0 0x2>;	/* PA26 GPIO with multi drive */
+					};
 				};
 
 				pioA: gpio at fffff400 {
@@ -520,6 +526,8 @@
 		i2c-gpio,sda-open-drain;
 		i2c-gpio,scl-open-drain;
 		i2c-gpio,delay-us = <2>;	/* ~100 kHz */
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_twi_gpio>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 		status = "disabled";
-- 
1.8.0
