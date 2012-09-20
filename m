From: t.figa@samsung.com (Tomasz Figa)
Date: Thu, 20 Sep 2012 10:51:40 +0200
Subject: [PATCH 2/6] pinctrl: exynos: Fix typos in gpio/wkup _irq_mask
In-Reply-To: <1348131104-24828-1-git-send-email-t.figa@samsung.com>
References: <1348131104-24828-1-git-send-email-t.figa@samsung.com>
Message-ID: <1348131104-24828-3-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To mask GPIO/wakeup IRQ, the corresponding bit in mask register has to
be set.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/pinctrl/pinctrl-exynos.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-exynos.c b/drivers/pinctrl/pinctrl-exynos.c
index c2fa85f..46cd637 100644
--- a/drivers/pinctrl/pinctrl-exynos.c
+++ b/drivers/pinctrl/pinctrl-exynos.c
@@ -58,7 +58,7 @@ static void exynos_gpio_irq_mask(struct irq_data *irqd)
 	unsigned long mask;
 
 	mask = readl(d->virt_base + reg_mask);
-	mask |= ~(1 << edata->pin);
+	mask |= 1 << edata->pin;
 	writel(mask, d->virt_base + reg_mask);
 }
 
@@ -290,7 +290,7 @@ static void exynos_wkup_irq_mask(struct irq_data *irqd)
 	unsigned long mask;
 
 	mask = readl(d->virt_base + reg_mask);
-	mask &= ~(1 << pin);
+	mask |= 1 << pin;
 	writel(mask, d->virt_base + reg_mask);
 }
 
-- 
1.7.12
