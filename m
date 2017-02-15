From: fabrice.gasnier@st.com (Fabrice Gasnier)
Date: Wed, 15 Feb 2017 09:04:32 +0100
Subject: [PATCH] mfd: stm32-timers: fix max register
Message-ID: <1487145872-1212-1-git-send-email-fabrice.gasnier@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

STM32 timers register bank size is 0x400. Fix regmap max_register.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 drivers/mfd/stm32-timers.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/stm32-timers.c b/drivers/mfd/stm32-timers.c
index 192cbb6..2182f00 100644
--- a/drivers/mfd/stm32-timers.c
+++ b/drivers/mfd/stm32-timers.c
@@ -15,7 +15,7 @@
 	.reg_bits = 32,
 	.val_bits = 32,
 	.reg_stride = sizeof(u32),
-	.max_register = 0x400,
+	.max_register = 0x3fc,
 };
 
 static void stm32_timers_get_arr_size(struct stm32_timers *ddata)
-- 
1.9.1
