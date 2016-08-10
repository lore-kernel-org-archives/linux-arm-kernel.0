From: patrice.chotard@st.com (patrice.chotard at st.com)
Date: Wed, 10 Aug 2016 15:13:01 +0200
Subject: [PATCH 4/4] ARM: dts: STiH41x-b2020: Update gpio specifier
In-Reply-To: <1470834781-23232-1-git-send-email-patrice.chotard@st.com>
References: <1470834781-23232-1-git-send-email-patrice.chotard@st.com>
Message-ID: <1470834781-23232-5-git-send-email-patrice.chotard@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Patrice Chotard <patrice.chotard@st.com>

- Remove useless gpio-cells
- Update second parameter by using GPIO_ACTIVE_HIGH/LOW
  instead of hardcoded value

Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
---
 arch/arm/boot/dts/stih41x-b2020.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/stih41x-b2020.dtsi b/arch/arm/boot/dts/stih41x-b2020.dtsi
index 487d7d8..322e0e9 100644
--- a/arch/arm/boot/dts/stih41x-b2020.dtsi
+++ b/arch/arm/boot/dts/stih41x-b2020.dtsi
@@ -7,6 +7,7 @@
  * publishhed by the Free Software Foundation.
  */
 #include "stih41x-b2020x.dtsi"
+#include <dt-bindings/gpio/gpio.h>
 / {
 	memory{
 		device_type = "memory";
@@ -30,13 +31,12 @@
 		leds {
 			compatible	= "gpio-leds";
 			red {
-				#gpio-cells = <1>;
 				label	= "Front Panel LED";
-				gpios	= <&pio4 1>;
+				gpios	= <&pio4 1 GPIO_ACTIVE_HIGH>;
 				linux,default-trigger	= "heartbeat";
 			};
 			green {
-				gpios	= <&pio4 7>;
+				gpios	= <&pio4 7 GPIO_ACTIVE_HIGH>;
 				default-state = "off";
 			};
 		};
-- 
1.9.1
