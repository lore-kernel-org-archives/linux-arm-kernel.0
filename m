From: gabriel.fernandez@st.com (gabriel.fernandez at st.com)
Date: Fri, 9 Mar 2018 07:57:30 +0100
Subject: [PATCH RESEND 1/2] clk: stm32: END_PRIMARY_CLK should be declare
 after CLK_SYSCLK
In-Reply-To: <1520578651-28849-1-git-send-email-gabriel.fernandez@st.com>
References: <1520578651-28849-1-git-send-email-gabriel.fernandez@st.com>
Message-ID: <1520578651-28849-2-git-send-email-gabriel.fernandez@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Gabriel Fernandez <gabriel.fernandez@st.com>

Update of END_PRIMARY_CLK was missed, it should be after CLK_SYSCLK
hsi and sysclk are overwritten by gpioa and gpiob.

Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
Tested-by: Philippe Cornu <philippe.cornu@st.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 include/dt-bindings/clock/stm32fx-clock.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/dt-bindings/clock/stm32fx-clock.h b/include/dt-bindings/clock/stm32fx-clock.h
index 49bb3c2..4d523b0 100644
--- a/include/dt-bindings/clock/stm32fx-clock.h
+++ b/include/dt-bindings/clock/stm32fx-clock.h
@@ -33,11 +33,11 @@
 #define CLK_SAI2		11
 #define CLK_I2SQ_PDIV		12
 #define CLK_SAIQ_PDIV		13
-
-#define END_PRIMARY_CLK		14
-
 #define CLK_HSI			14
 #define CLK_SYSCLK		15
+
+#define END_PRIMARY_CLK		16
+
 #define CLK_HDMI_CEC		16
 #define CLK_SPDIF		17
 #define CLK_USART1		18
-- 
1.9.1
