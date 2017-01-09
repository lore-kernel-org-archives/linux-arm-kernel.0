From: gabriel.fernandez@st.com (gabriel.fernandez at st.com)
Date: Mon, 9 Jan 2017 10:07:11 +0100
Subject: [PATCH v2 1/3] dt-bindings: mfd: stm32f4: Fix STM32F4_X_CLOCK() macro
In-Reply-To: <1483952833-14704-1-git-send-email-gabriel.fernandez@st.com>
References: <1483952833-14704-1-git-send-email-gabriel.fernandez@st.com>
Message-ID: <1483952833-14704-2-git-send-email-gabriel.fernandez@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Gabriel Fernandez <gabriel.fernandez@st.com>

Macro to select a clock was not correct.

Offset of enable register starts at 0x30, then calculation to select a bit is:
(@enable_reg - 0x30) / 4 * 32 + bit_to_select

Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
Tested-by: M'boumba Cedric Madianga <cedric.madianga@gmail.com>
---
 include/dt-bindings/mfd/stm32f4-rcc.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/dt-bindings/mfd/stm32f4-rcc.h b/include/dt-bindings/mfd/stm32f4-rcc.h
index e98942d..f662b19 100644
--- a/include/dt-bindings/mfd/stm32f4-rcc.h
+++ b/include/dt-bindings/mfd/stm32f4-rcc.h
@@ -25,7 +25,7 @@
 #define STM32F4_RCC_AHB1_OTGHS	29
 
 #define STM32F4_AHB1_RESET(bit) (STM32F4_RCC_AHB1_##bit + (0x10 * 8))
-#define STM32F4_AHB1_CLOCK(bit) (STM32F4_RCC_AHB1_##bit + (0x30 * 8))
+#define STM32F4_AHB1_CLOCK(bit) (STM32F4_RCC_AHB1_##bit)
 
 
 /* AHB2 */
@@ -36,13 +36,13 @@
 #define STM32F4_RCC_AHB2_OTGFS	7
 
 #define STM32F4_AHB2_RESET(bit)	(STM32F4_RCC_AHB2_##bit + (0x14 * 8))
-#define STM32F4_AHB2_CLOCK(bit)	(STM32F4_RCC_AHB2_##bit + (0x34 * 8))
+#define STM32F4_AHB2_CLOCK(bit)	(STM32F4_RCC_AHB2_##bit + 0x20)
 
 /* AHB3 */
 #define STM32F4_RCC_AHB3_FMC	0
 
 #define STM32F4_AHB3_RESET(bit)	(STM32F4_RCC_AHB3_##bit + (0x18 * 8))
-#define STM32F4_AHB3_CLOCK(bit)	(STM32F4_RCC_AHB3_##bit + (0x38 * 8))
+#define STM32F4_AHB3_CLOCK(bit)	(STM32F4_RCC_AHB3_##bit + 0x40)
 
 /* APB1 */
 #define STM32F4_RCC_APB1_TIM2	0
@@ -72,7 +72,7 @@
 #define STM32F4_RCC_APB1_UART8	31
 
 #define STM32F4_APB1_RESET(bit)	(STM32F4_RCC_APB1_##bit + (0x20 * 8))
-#define STM32F4_APB1_CLOCK(bit)	(STM32F4_RCC_APB1_##bit + (0x40 * 8))
+#define STM32F4_APB1_CLOCK(bit)	(STM32F4_RCC_APB1_##bit + 0x80)
 
 /* APB2 */
 #define STM32F4_RCC_APB2_TIM1	0
@@ -93,6 +93,6 @@
 #define STM32F4_RCC_APB2_LTDC	26
 
 #define STM32F4_APB2_RESET(bit)	(STM32F4_RCC_APB2_##bit + (0x24 * 8))
-#define STM32F4_APB2_CLOCK(bit)	(STM32F4_RCC_APB2_##bit + (0x44 * 8))
+#define STM32F4_APB2_CLOCK(bit)	(STM32F4_RCC_APB2_##bit + 0xA0)
 
 #endif /* _DT_BINDINGS_MFD_STM32F4_RCC_H */
-- 
1.9.1
