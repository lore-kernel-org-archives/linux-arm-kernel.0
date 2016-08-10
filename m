From: patrice.chotard@st.com (patrice.chotard at st.com)
Date: Wed, 10 Aug 2016 15:13:00 +0200
Subject: [PATCH 3/4] ARM: dts: STiH418-B2199: Update gpio specifier
In-Reply-To: <1470834781-23232-1-git-send-email-patrice.chotard@st.com>
References: <1470834781-23232-1-git-send-email-patrice.chotard@st.com>
Message-ID: <1470834781-23232-4-git-send-email-patrice.chotard@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Patrice Chotard <patrice.chotard@st.com>

- Remove useless gpio-cells
- Update second parameter by using GPIO_ACTIVE_HIGH/LOW
  instead of hardcoded value

Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
---
 arch/arm/boot/dts/stih418-b2199.dts | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/stih418-b2199.dts b/arch/arm/boot/dts/stih418-b2199.dts
index 772d2bb..24e98a9 100644
--- a/arch/arm/boot/dts/stih418-b2199.dts
+++ b/arch/arm/boot/dts/stih418-b2199.dts
@@ -8,6 +8,7 @@
  */
 /dts-v1/;
 #include "stih418.dtsi"
+#include <dt-bindings/gpio/gpio.h>
 / {
 	model = "STiH418 B2199";
 	compatible = "st,stih418-b2199", "st,stih418";
@@ -35,14 +36,12 @@
 		leds {
 			compatible = "gpio-leds";
 			red {
-				#gpio-cells = <2>;
 				label = "Front Panel LED";
-				gpios = <&pio4 1 0>;
+				gpios = <&pio4 1 GPIO_ACTIVE_HIGH>;
 				linux,default-trigger = "heartbeat";
 			};
 			green {
-				#gpio-cells = <2>;
-				gpios = <&pio1 3 0>;
+				gpios = <&pio1 3 GPIO_ACTIVE_HIGH>;
 				default-state = "off";
 			};
 		};
-- 
1.9.1
