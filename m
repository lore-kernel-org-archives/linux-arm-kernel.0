From: fabrice.gasnier@st.com (Fabrice Gasnier)
Date: Thu, 1 Feb 2018 14:44:37 +0100
Subject: [PATCH 2/3] pwm: stm32: LPTimer: use 3 cells xlate
In-Reply-To: <1517492678-767-1-git-send-email-fabrice.gasnier@st.com>
References: <1517492678-767-1-git-send-email-fabrice.gasnier@st.com>
Message-ID: <1517492678-767-3-git-send-email-fabrice.gasnier@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Gerald Baeza <gerald.baeza@st.com>

STM32 Low-Power Timer supports generic 3 cells pwm to encode
PWM number, period and polarity.

Signed-off-by: Gerald Baeza <gerald.baeza@st.com>
Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 drivers/pwm/pwm-stm32-lp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pwm/pwm-stm32-lp.c b/drivers/pwm/pwm-stm32-lp.c
index 1ac9e43..346b7bd 100644
--- a/drivers/pwm/pwm-stm32-lp.c
+++ b/drivers/pwm/pwm-stm32-lp.c
@@ -203,6 +203,8 @@ static int stm32_pwm_lp_probe(struct platform_device *pdev)
 	priv->chip.dev = &pdev->dev;
 	priv->chip.ops = &stm32_pwm_lp_ops;
 	priv->chip.npwm = 1;
+	priv->chip.of_xlate = of_pwm_xlate_with_flags;
+	priv->chip.of_pwm_n_cells = 3;
 
 	ret = pwmchip_add(&priv->chip);
 	if (ret < 0)
-- 
1.9.1
