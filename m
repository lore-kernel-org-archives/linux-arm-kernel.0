From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 11 May 2012 15:35:38 +0200
Subject: [PATCH 7/9] ARM: AT91: Add ADC driver to the at91sam9g45 dtsi
In-Reply-To: <1336743340-4578-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1336743340-4578-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1336743340-4578-8-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/boot/dts/at91sam9g45.dtsi |   37 ++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/arch/arm/boot/dts/at91sam9g45.dtsi b/arch/arm/boot/dts/at91sam9g45.dtsi
index c804214..7dbccaf 100644
--- a/arch/arm/boot/dts/at91sam9g45.dtsi
+++ b/arch/arm/boot/dts/at91sam9g45.dtsi
@@ -199,6 +199,43 @@
 				interrupts = <25 4>;
 				status = "disabled";
 			};
+
+			adc0: adc at fffb0000 {
+				compatible = "atmel,at91sam9260-adc";
+				reg = <0xfffb0000 0x100>;
+				interrupts = <20 4>;
+				atmel,adc-use-external-triggers;
+				atmel,adc-channels-used = <0xff>;
+				atmel,adc-vref = <3300>;
+				atmel,adc-num-channels = <8>;
+				atmel,adc-startup-time = <40>;
+				atmel,adc-channel-base = <0x30>;
+				atmel,adc-drdy-mask = <0x10000>;
+				atmel,adc-status-register = <0x1c>;
+				atmel,adc-trigger-register = <0x08>;
+
+				trigger at 0 {
+					trigger-name = "external-rising";
+					trigger-value = <0x1>;
+					trigger-external;
+				};
+				trigger at 1 {
+					trigger-name = "external-falling";
+					trigger-value = <0x2>;
+					trigger-external;
+				};
+
+				trigger at 2 {
+					trigger-name = "external-any";
+					trigger-value = <0x3>;
+					trigger-external;
+				};
+
+				trigger at 3 {
+					trigger-name = "continuous";
+					trigger-value = <0x6>;
+				};
+			};
 		};
 
 		nand0: nand at 40000000 {
-- 
1.7.9.5
