From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed,  9 May 2012 15:02:07 +0200
Subject: [PATCH 8/9] ARM: AT91: Add ADC driver to the at91sam9x5 dtsi
In-Reply-To: <1336568528-29877-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1336568528-29877-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1336568528-29877-9-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/boot/dts/at91sam9x5.dtsi |   38 +++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/arch/arm/boot/dts/at91sam9x5.dtsi b/arch/arm/boot/dts/at91sam9x5.dtsi
index dd4ed74..6b3ef43 100644
--- a/arch/arm/boot/dts/at91sam9x5.dtsi
+++ b/arch/arm/boot/dts/at91sam9x5.dtsi
@@ -190,6 +190,44 @@
 				interrupts = <27 4>;
 				status = "disabled";
 			};
+
+			adc0: adc at f804c000 {
+				compatible = "atmel,at91sam9260-adc";
+				reg = <0xf804c000 0x100>;
+				interrupts = <19 4>;
+				atmel,adc-use-external;
+				atmel,adc-channels-used = <0xffff>;
+				atmel,adc-vref = <3300>;
+				atmel,adc-num-channels = <12>;
+				atmel,adc-startup-time = <40>;
+				atmel,adc-channel-base = <0x50>;
+				atmel,adc-drdy-mask = <0x1000000>;
+				atmel,adc-status-register = <0x30>;
+				atmel,adc-trigger-register = <0xc0>;
+
+				trigger at 0 {
+					trigger-name = "external-rising";
+					trigger-value = <0x1>;
+					trigger-external;
+				};
+
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
