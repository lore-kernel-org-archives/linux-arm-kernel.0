From: peda@axentia.se (Peter Rosin)
Date: Fri, 31 Aug 2018 22:44:03 +0200
Subject: [PATCH 2/2] ARM: dts: at91: tse850: drop three indentation levels
In-Reply-To: <20180831204403.14653-1-peda@axentia.se>
References: <20180831204403.14653-1-peda@axentia.se>
Message-ID: <20180831204403.14653-3-peda@axentia.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make use of the recently added &pinctrl and &watchdog labels. This
makes the whole file consistent and knowledge of the ahb/apb structure
is hidden.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 arch/arm/boot/dts/at91-tse850-3.dts | 32 +++++++++++++-------------------
 1 file changed, 13 insertions(+), 19 deletions(-)

diff --git a/arch/arm/boot/dts/at91-tse850-3.dts b/arch/arm/boot/dts/at91-tse850-3.dts
index 2fbec69d9cd6..fe8876eaf917 100644
--- a/arch/arm/boot/dts/at91-tse850-3.dts
+++ b/arch/arm/boot/dts/at91-tse850-3.dts
@@ -16,25 +16,6 @@
 	compatible = "axentia,tse850v3", "axentia,linea",
 		     "atmel,sama5d31", "atmel,sama5d3", "atmel,sama5";
 
-	ahb {
-		apb {
-			pinctrl at fffff200 {
-				tse850 {
-					pinctrl_usba_vbus: usba-vbus {
-						atmel,pins =
-							<AT91_PIOC 31
-							 AT91_PERIPH_GPIO
-							 AT91_PINCTRL_DEGLITCH>;
-					};
-				};
-			};
-
-			watchdog at fffffe40 {
-				status = "okay";
-			};
-		};
-	};
-
 	sck: oscillator {
 		compatible = "fixed-clock";
 
@@ -253,6 +234,19 @@
 	};
 };
 
+&pinctrl {
+	tse850 {
+		pinctrl_usba_vbus: usba-vbus {
+			atmel,pins = <AT91_PIOC 31 AT91_PERIPH_GPIO
+				      AT91_PINCTRL_DEGLITCH>;
+		};
+	};
+};
+
+&watchdog {
+	status = "okay";
+};
+
 &usart0 {
 	status = "okay";
 
-- 
2.11.0
