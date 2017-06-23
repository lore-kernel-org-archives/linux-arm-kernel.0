From: zhi.mao@mediatek.com (Zhi Mao)
Date: Fri, 23 Jun 2017 13:08:21 +0800
Subject: [PATCH v2 2/6] pwm: mediatek: fix pwm source clock selection
In-Reply-To: <1498194505-30930-1-git-send-email-zhi.mao@mediatek.com>
References: <1498194505-30930-1-git-send-email-zhi.mao@mediatek.com>
Message-ID: <1498194505-30930-3-git-send-email-zhi.mao@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In original code, the pwm output frequency is not correct
when set bit<3>=1 to PWMCON register.

Signed-off-by: Zhi Mao <zhi.mao@mediatek.com>
---
 drivers/pwm/pwm-mediatek.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-mediatek.c b/drivers/pwm/pwm-mediatek.c
index 5c11bc7..d08b5b3 100644
--- a/drivers/pwm/pwm-mediatek.c
+++ b/drivers/pwm/pwm-mediatek.c
@@ -91,7 +91,7 @@ static int mtk_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	if (clkdiv > 7)
 		return -EINVAL;
 
-	mtk_pwm_writel(pc, pwm->hwpwm, PWMCON, BIT(15) | BIT(3) | clkdiv);
+	mtk_pwm_writel(pc, pwm->hwpwm, PWMCON, BIT(15) | clkdiv);
 	mtk_pwm_writel(pc, pwm->hwpwm, PWMDWIDTH, period_ns / resolution);
 	mtk_pwm_writel(pc, pwm->hwpwm, PWMTHRES, duty_ns / resolution);
 
-- 
1.7.9.5
