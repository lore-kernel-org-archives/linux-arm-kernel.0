From: fabrice.gasnier@st.com (Fabrice Gasnier)
Date: Wed, 14 Feb 2018 11:04:32 +0100
Subject: [RESEND PATCH v2 1/8] pwm: stm32: fix, remove unused struct device
In-Reply-To: <1518602679-3064-1-git-send-email-fabrice.gasnier@st.com>
References: <1518602679-3064-1-git-send-email-fabrice.gasnier@st.com>
Message-ID: <1518602679-3064-2-git-send-email-fabrice.gasnier@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

dev is never assigned nor used. remove it.

Fixes: 7edf7369205b ("pwm: Add driver for STM32 plaftorm")

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
Reviewed-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
---
 drivers/pwm/pwm-stm32.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pwm/pwm-stm32.c b/drivers/pwm/pwm-stm32.c
index 6139512..59524f9 100644
--- a/drivers/pwm/pwm-stm32.c
+++ b/drivers/pwm/pwm-stm32.c
@@ -21,7 +21,6 @@
 
 struct stm32_pwm {
 	struct pwm_chip chip;
-	struct device *dev;
 	struct clk *clk;
 	struct regmap *regmap;
 	u32 max_arr;
-- 
1.9.1
