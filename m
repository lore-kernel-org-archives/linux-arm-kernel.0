From: t.figa@samsung.com (Tomasz Figa)
Date: Thu, 20 Sep 2012 16:53:33 +0200
Subject: [PATCH 7/6] pinctrl: exynos: Fix wakeup IRQ domain registration check
In-Reply-To: <1348131104-24828-1-git-send-email-t.figa@samsung.com>
References: <1348131104-24828-1-git-send-email-t.figa@samsung.com>
Message-ID: <2737662.uE6StcAj33@amdc1227>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Because of a typo, incorrect field of a structure was being checked.
This patch fixes the check to use correct field.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
---
 drivers/pinctrl/pinctrl-exynos.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/pinctrl-exynos.c b/drivers/pinctrl/pinctrl-exynos.c
index 0d01d19..21362f4 100644
--- a/drivers/pinctrl/pinctrl-exynos.c
+++ b/drivers/pinctrl/pinctrl-exynos.c
@@ -447,7 +447,7 @@ static int exynos_eint_wkup_init(struct samsung_pinctrl_drv_data *d)
 
 	d->wkup_irqd = irq_domain_add_linear(wkup_np, d->ctrl->nr_wint,
 				&exynos_wkup_irqd_ops, d);
-	if (!d->gpio_irqd) {
+	if (!d->wkup_irqd) {
 		dev_err(dev, "wakeup irq domain allocation failed\n");
 		return -ENXIO;
 	}
-- 
1.7.12
