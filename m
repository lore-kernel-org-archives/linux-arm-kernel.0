From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 22 Jul 2014 12:11:16 +0100
Subject: [PATCH 10/19] mfd: lp8788-irq: Fix 'missing blank line after
 declarations' warning
In-Reply-To: <1406027485-15657-1-git-send-email-lee.jones@linaro.org>
References: <1406027485-15657-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1406027485-15657-11-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is part of an effort to clean-up the MFD subsystem.

WARNING: Missing a blank line after declarations
+       struct lp8788_irq_data *irqd = irq_data_get_irq_chip_data(data);
+       irqd->enabled[data->hwirq] = 1;

WARNING: Missing a blank line after declarations
+       struct lp8788_irq_data *irqd = irq_data_get_irq_chip_data(data);
+       irqd->enabled[data->hwirq] = 0;

total: 0 errors, 2 warnings, 198 lines checked

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/lp8788-irq.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mfd/lp8788-irq.c b/drivers/mfd/lp8788-irq.c
index c84ded5..23982db 100644
--- a/drivers/mfd/lp8788-irq.c
+++ b/drivers/mfd/lp8788-irq.c
@@ -66,12 +66,14 @@ static inline u8 _irq_to_val(enum lp8788_int_id id, int enable)
 static void lp8788_irq_enable(struct irq_data *data)
 {
 	struct lp8788_irq_data *irqd = irq_data_get_irq_chip_data(data);
+
 	irqd->enabled[data->hwirq] = 1;
 }
 
 static void lp8788_irq_disable(struct irq_data *data)
 {
 	struct lp8788_irq_data *irqd = irq_data_get_irq_chip_data(data);
+
 	irqd->enabled[data->hwirq] = 0;
 }
 
-- 
1.8.3.2
