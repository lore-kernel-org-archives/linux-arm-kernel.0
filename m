From: heiko@sntech.de (Heiko =?utf-8?q?St=C3=BCbner?=)
Date: Wed, 16 Oct 2013 01:08:11 +0200
Subject: [PATCH v2 3/5] pinctrl: rockchip: remove redundant check
In-Reply-To: <201310160106.42329.heiko@sntech.de>
References: <201310160106.42329.heiko@sntech.de>
Message-ID: <201310160108.12261.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The check limiting bias options to supported ones is already
done thru rockchip_pinconf_pull_valid. Therefore this check is
redundant and can be removed.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/pinctrl/pinctrl-rockchip.c |    6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-rockchip.c b/drivers/pinctrl/pinctrl-rockchip.c
index efca116..91027dd 100644
--- a/drivers/pinctrl/pinctrl-rockchip.c
+++ b/drivers/pinctrl/pinctrl-rockchip.c
@@ -424,12 +424,6 @@ static int rockchip_set_pull(struct rockchip_pin_bank *bank,
 
 	switch (ctrl->type) {
 	case RK2928:
-		if (pull != PIN_CONFIG_BIAS_PULL_PIN_DEFAULT &&
-					pull != PIN_CONFIG_BIAS_DISABLE) {
-			dev_err(info->dev, "only PIN_DEFAULT and DISABLE allowed\n");
-			return -EINVAL;
-		}
-
 		ctrl->pull_calc_reg(bank, pin_num, &reg, &bit);
 
 		spin_lock_irqsave(&bank->slock, flags);
-- 
1.7.10.4
