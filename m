From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Mon,  6 Aug 2018 18:33:40 +0200
Subject: [PATCH] pinctrl: samsung: Remove duplicated "wakeup" in printk
Message-ID: <20180806163340.27276-1-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Double "wakeup" appears in printed message.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/pinctrl/samsung/pinctrl-exynos.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/samsung/pinctrl-exynos.c b/drivers/pinctrl/samsung/pinctrl-exynos.c
index 40ef14956876..f49ea3d92aa1 100644
--- a/drivers/pinctrl/samsung/pinctrl-exynos.c
+++ b/drivers/pinctrl/samsung/pinctrl-exynos.c
@@ -588,7 +588,7 @@ exynos_pinctrl_set_eint_wakeup_mask(struct samsung_pinctrl_drv_data *drvdata,
 
 	pmu_regs = drvdata->retention_ctrl->priv;
 	dev_info(drvdata->dev,
-		 "Setting external wakeup interrupt wakeup mask: 0x%x\n",
+		 "Setting external wakeup interrupt mask: 0x%x\n",
 		 irq_chip->eint_wake_mask_value);
 
 	regmap_write(pmu_regs, irq_chip->eint_wake_mask_reg,
-- 
2.14.1
