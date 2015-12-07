From: lee.jones@linaro.org (Lee Jones)
Date: Mon,  7 Dec 2015 11:50:31 +0000
Subject: [PATCH 18/19] mfd: da9052-irq: Fix trivial 'space before comma' error
In-Reply-To: <1449489032-14374-1-git-send-email-lee.jones@linaro.org>
References: <1449489032-14374-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1449489032-14374-19-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ERROR: space prohibited before that ',' (ctx:WxW)
+       da9052_free_irq(da9052, DA9052_IRQ_ADC_EOM , da9052);

total: 1 errors, 0 warnings, 290 lines checked

Cc: Support Opensource <support.opensource@diasemi.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/da9052-irq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/da9052-irq.c b/drivers/mfd/da9052-irq.c
index f4cb461..cd4ca84 100644
--- a/drivers/mfd/da9052-irq.c
+++ b/drivers/mfd/da9052-irq.c
@@ -283,7 +283,7 @@ regmap_err:
 
 int da9052_irq_exit(struct da9052 *da9052)
 {
-	da9052_free_irq(da9052, DA9052_IRQ_ADC_EOM , da9052);
+	da9052_free_irq(da9052, DA9052_IRQ_ADC_EOM, da9052);
 	regmap_del_irq_chip(da9052->chip_irq, da9052->irq_data);
 
 	return 0;
-- 
1.9.1
