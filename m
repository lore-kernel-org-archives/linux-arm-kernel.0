From: gabriel.fernandez@st.com (gabriel.fernandez at st.com)
Date: Mon, 9 Jan 2017 10:07:12 +0100
Subject: [PATCH v2 2/3] dt-bindings: mfd: stm32f4: Add missing binding
 definition
In-Reply-To: <1483952833-14704-1-git-send-email-gabriel.fernandez@st.com>
References: <1483952833-14704-1-git-send-email-gabriel.fernandez@st.com>
Message-ID: <1483952833-14704-3-git-send-email-gabriel.fernandez@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Gabriel Fernandez <gabriel.fernandez@st.com>

This patch adds missing binding definition (backupram, ethernet, otg,
qspi, adc & dsi)

Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
---
 include/dt-bindings/mfd/stm32f4-rcc.h | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/include/dt-bindings/mfd/stm32f4-rcc.h b/include/dt-bindings/mfd/stm32f4-rcc.h
index f662b19..082a81c 100644
--- a/include/dt-bindings/mfd/stm32f4-rcc.h
+++ b/include/dt-bindings/mfd/stm32f4-rcc.h
@@ -18,11 +18,17 @@
 #define STM32F4_RCC_AHB1_GPIOJ	9
 #define STM32F4_RCC_AHB1_GPIOK	10
 #define STM32F4_RCC_AHB1_CRC	12
+#define STM32F4_RCC_AHB1_BKPSRAM	18
+#define STM32F4_RCC_AHB1_CCMDATARAM	20
 #define STM32F4_RCC_AHB1_DMA1	21
 #define STM32F4_RCC_AHB1_DMA2	22
 #define STM32F4_RCC_AHB1_DMA2D	23
 #define STM32F4_RCC_AHB1_ETHMAC	25
-#define STM32F4_RCC_AHB1_OTGHS	29
+#define STM32F4_RCC_AHB1_ETHMACTX	26
+#define STM32F4_RCC_AHB1_ETHMACRX	27
+#define STM32F4_RCC_AHB1_ETHMACPTP	28
+#define STM32F4_RCC_AHB1_OTGHS		29
+#define STM32F4_RCC_AHB1_OTGHSULPI	30
 
 #define STM32F4_AHB1_RESET(bit) (STM32F4_RCC_AHB1_##bit + (0x10 * 8))
 #define STM32F4_AHB1_CLOCK(bit) (STM32F4_RCC_AHB1_##bit)
@@ -40,6 +46,7 @@
 
 /* AHB3 */
 #define STM32F4_RCC_AHB3_FMC	0
+#define STM32F4_RCC_AHB3_QSPI	1
 
 #define STM32F4_AHB3_RESET(bit)	(STM32F4_RCC_AHB3_##bit + (0x18 * 8))
 #define STM32F4_AHB3_CLOCK(bit)	(STM32F4_RCC_AHB3_##bit + 0x40)
@@ -79,7 +86,9 @@
 #define STM32F4_RCC_APB2_TIM8	1
 #define STM32F4_RCC_APB2_USART1	4
 #define STM32F4_RCC_APB2_USART6	5
-#define STM32F4_RCC_APB2_ADC	8
+#define STM32F4_RCC_APB2_ADC1	8
+#define STM32F4_RCC_APB2_ADC2	9
+#define STM32F4_RCC_APB2_ADC3	10
 #define STM32F4_RCC_APB2_SDIO	11
 #define STM32F4_RCC_APB2_SPI1	12
 #define STM32F4_RCC_APB2_SPI4	13
@@ -91,6 +100,7 @@
 #define STM32F4_RCC_APB2_SPI6	21
 #define STM32F4_RCC_APB2_SAI1	22
 #define STM32F4_RCC_APB2_LTDC	26
+#define STM32F4_RCC_APB2_DSI	27
 
 #define STM32F4_APB2_RESET(bit)	(STM32F4_RCC_APB2_##bit + (0x24 * 8))
 #define STM32F4_APB2_CLOCK(bit)	(STM32F4_RCC_APB2_##bit + 0xA0)
-- 
1.9.1
