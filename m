From: fabrice.gasnier@st.com (Fabrice Gasnier)
Date: Wed, 18 Apr 2018 09:47:45 +0200
Subject: [PATCH] ARM: dts: stm32: Add vrefbuf support to stm32mp157c
Message-ID: <1524037665-26178-1-git-send-email-fabrice.gasnier@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

stm32mp157c has vrefbuf regulator that can provide analog reference
voltage from 1500mV to 2500mV.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 arch/arm/boot/dts/stm32mp157c.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/stm32mp157c.dtsi b/arch/arm/boot/dts/stm32mp157c.dtsi
index bc3eddc..7df3c99 100644
--- a/arch/arm/boot/dts/stm32mp157c.dtsi
+++ b/arch/arm/boot/dts/stm32mp157c.dtsi
@@ -167,6 +167,15 @@
 			#reset-cells = <1>;
 		};
 
+		vrefbuf: vrefbuf at 50025000 {
+			compatible = "st,stm32-vrefbuf";
+			reg = <0x50025000 0x8>;
+			regulator-min-microvolt = <1500000>;
+			regulator-max-microvolt = <2500000>;
+			clocks = <&rcc VREF>;
+			status = "disabled";
+		};
+
 		usart1: serial at 5c000000 {
 			compatible = "st,stm32h7-uart";
 			reg = <0x5c000000 0x400>;
-- 
1.9.1
