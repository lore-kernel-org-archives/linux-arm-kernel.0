From: gabriel.fernandez@st.com (gabriel.fernandez at st.com)
Date: Fri, 6 Jan 2017 14:59:22 +0100
Subject: [PATCH 1/4] clk: stm32f7: Add stm32f7 clock DT bindings for STM32F746
 boards
In-Reply-To: <1483711165-17149-1-git-send-email-gabriel.fernandez@st.com>
References: <1483711165-17149-1-git-send-email-gabriel.fernandez@st.com>
Message-ID: <1483711165-17149-2-git-send-email-gabriel.fernandez@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Gabriel Fernandez <gabriel.fernandez@st.com>

This patch introduces the stm32f7 clock DT bindings.

Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
---
 .../devicetree/bindings/clock/st,stm32-rcc.txt       | 20 ++++++++++++++++++++
 include/dt-bindings/clock/stm32fx-clock.h            | 20 ++++++++++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/st,stm32-rcc.txt b/Documentation/devicetree/bindings/clock/st,stm32-rcc.txt
index 8f19d87..b240121 100644
--- a/Documentation/devicetree/bindings/clock/st,stm32-rcc.txt
+++ b/Documentation/devicetree/bindings/clock/st,stm32-rcc.txt
@@ -10,6 +10,7 @@ Required properties:
 - compatible: Should be:
   "st,stm32f42xx-rcc"
   "st,stm32f469-rcc"
+  "st,stm32f746-rcc"
 - reg: should be register base and length as documented in the
   datasheet
 - #reset-cells: 1, see below
@@ -84,6 +85,25 @@ The secondary index is bound with the following magic numbers:
 	12	CLK_I2SQ_PDIV	(post divisor of pll i2s q divisor)
 	13	CLK_SAIQ_PDIV	(post divisor of pll sai q divisor)
 
+	14	CLK_HSI		(Internal ocscillator clock)
+	15	CLK_SYSCLK	(System Clock)
+	16	CLK_HDMI_CEC	(HDMI-CEC clock)
+	17	CLK_SPDIF	(SPDIF-Rx clock)
+	18	CLK_USART1	(U(s)arts clocks)
+	19	CLK_USART2
+	20	CLK_USART3
+	21	CLK_UART4
+	22	CLK_UART5
+	23	CLK_USART6
+	24	CLK_UART7
+	25	CLK_UART8
+	26	CLK_I2C1	(I2S clocks)
+	27	CLK_I2C2
+	28	CLK_I2C3
+	29	CLK_I2C4
+	30	CLK_LPTIMER	(LPTimer1 clock)
+)
+
 Example:
 
 	/* Misc clock, FCLK */
diff --git a/include/dt-bindings/clock/stm32fx-clock.h b/include/dt-bindings/clock/stm32fx-clock.h
index 08bcab6..49bb3c2 100644
--- a/include/dt-bindings/clock/stm32fx-clock.h
+++ b/include/dt-bindings/clock/stm32fx-clock.h
@@ -36,4 +36,24 @@
 
 #define END_PRIMARY_CLK		14
 
+#define CLK_HSI			14
+#define CLK_SYSCLK		15
+#define CLK_HDMI_CEC		16
+#define CLK_SPDIF		17
+#define CLK_USART1		18
+#define CLK_USART2		19
+#define CLK_USART3		20
+#define CLK_UART4		21
+#define CLK_UART5		22
+#define CLK_USART6		23
+#define CLK_UART7		24
+#define CLK_UART8		25
+#define CLK_I2C1		26
+#define CLK_I2C2		27
+#define CLK_I2C3		28
+#define CLK_I2C4		29
+#define CLK_LPTIMER		30
+
+#define END_PRIMARY_CLK_F7	31
+
 #endif
-- 
1.9.1
