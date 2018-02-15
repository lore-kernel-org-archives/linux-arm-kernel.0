From: philippe.cornu@st.com (Philippe Cornu)
Date: Thu, 15 Feb 2018 09:20:12 +0100
Subject: [PATCH 1/3] ARM: dts: stm32: Add dt-bindings gpio.h include on
 stm32f469-disco
In-Reply-To: <20180215082014.30383-1-philippe.cornu@st.com>
References: <20180215082014.30383-1-philippe.cornu@st.com>
Message-ID: <20180215082014.30383-2-philippe.cornu@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add dt-bindings/gpio/gpio.h include and use it on vcc5v_otg.

Signed-off-by: Philippe Cornu <philippe.cornu@st.com>
---
 arch/arm/boot/dts/stm32f469-disco.dts | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/stm32f469-disco.dts b/arch/arm/boot/dts/stm32f469-disco.dts
index bdd03ac7a4b5..7d53b794d27b 100644
--- a/arch/arm/boot/dts/stm32f469-disco.dts
+++ b/arch/arm/boot/dts/stm32f469-disco.dts
@@ -48,6 +48,7 @@
 /dts-v1/;
 #include "stm32f429.dtsi"
 #include "stm32f469-pinctrl.dtsi"
+#include <dt-bindings/gpio/gpio.h>
 
 / {
 	model = "STMicroelectronics STM32F469i-DISCO board";
@@ -74,7 +75,7 @@
 	vcc5v_otg: vcc5v-otg-regulator {
 		compatible = "regulator-fixed";
 		enable-active-high;
-		gpio = <&gpiob 2 0>;
+		gpio = <&gpiob 2 GPIO_ACTIVE_HIGH>;
 		regulator-name = "vcc5_host1";
 		regulator-always-on;
 	};
-- 
2.15.1
