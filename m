From: lionel.debieve@st.com (Lionel Debieve)
Date: Mon, 23 Apr 2018 17:19:44 +0200
Subject: [PATCH 1/4] ARM: dts: stm32: Add RNG support on stm32mp157c
In-Reply-To: <20180423151947.2526-1-lionel.debieve@st.com>
References: <20180423151947.2526-1-lionel.debieve@st.com>
Message-ID: <20180423151947.2526-2-lionel.debieve@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch add RNG instance of the stm32mp157c SoC

Signed-off-by: Lionel Debieve <lionel.debieve@st.com>
---
 arch/arm/boot/dts/stm32mp157c.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/stm32mp157c.dtsi b/arch/arm/boot/dts/stm32mp157c.dtsi
index bc3eddc3eda6..bf00885971b3 100644
--- a/arch/arm/boot/dts/stm32mp157c.dtsi
+++ b/arch/arm/boot/dts/stm32mp157c.dtsi
@@ -5,6 +5,7 @@
  */
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/clock/stm32mp1-clks.h>
+#include <dt-bindings/reset/stm32mp1-resets.h>
 
 / {
 	#address-cells = <1>;
@@ -167,6 +168,14 @@
 			#reset-cells = <1>;
 		};
 
+		rng1: rng at 54003000 {
+			compatible = "st,stm32-rng";
+			reg = <0x54003000 0x400>;
+			clocks = <&rcc RNG1_K>;
+			resets = <&rcc RNG1_R>;
+			status = "disabled";
+		};
+
 		usart1: serial at 5c000000 {
 			compatible = "st,stm32h7-uart";
 			reg = <0x5c000000 0x400>;
-- 
2.15.1
