From: yannick.fertre@st.com (Yannick Fertre)
Date: Thu, 30 Mar 2017 17:15:24 +0200
Subject: [PATCH v4 3/5] ARM: dts: stm32: Add watchdog support for STM32F429 SoC
In-Reply-To: <1490886926-20585-1-git-send-email-yannick.fertre@st.com>
References: <1490886926-20585-1-git-send-email-yannick.fertre@st.com>
Message-ID: <1490886926-20585-4-git-send-email-yannick.fertre@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add watchdog into DT for stm32f429 family.

Signed-off-by: Yannick FERTRE <yannick.fertre@st.com>
---
 arch/arm/boot/dts/stm32f429.dtsi | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/stm32f429.dtsi b/arch/arm/boot/dts/stm32f429.dtsi
index 89327d6..d84dd44 100644
--- a/arch/arm/boot/dts/stm32f429.dtsi
+++ b/arch/arm/boot/dts/stm32f429.dtsi
@@ -64,7 +64,7 @@
 			clock-frequency = <32768>;
 		};
 
-		clk-lsi {
+		clk_lsi: clk-lsi {
 			#clock-cells = <0>;
 			compatible = "fixed-clock";
 			clock-frequency = <32000>;
@@ -306,6 +306,13 @@
 			status = "disabled";
 		};
 
+		iwdg: watchdog at 40003000 {
+			compatible = "st,stm32-iwdg";
+			reg = <0x40003000 0x400>;
+			clocks = <&clk_lsi>;
+			status = "disabled";
+		};
+
 		usart2: serial at 40004400 {
 			compatible = "st,stm32-usart", "st,stm32-uart";
 			reg = <0x40004400 0x400>;
-- 
1.9.1
