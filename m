From: myungjoo.ham@samsung.com (MyungJoo Ham)
Date: Thu, 30 Jun 2011 10:52:29 +0900
Subject: [PATCH 1/2] Samsung SoC: Allow to enable wakeup with IRQs.
Message-ID: <1309398750-25859-1-git-send-email-myungjoo.ham@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

s3c_irq_wake is required by some external .c files to setup WAKEUP-MASK
bits based on IRQ numbers.

Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/plat-samsung/include/plat/pm.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-samsung/include/plat/pm.h b/arch/arm/plat-samsung/include/plat/pm.h
index 7fb6f6b..1279bc7 100644
--- a/arch/arm/plat-samsung/include/plat/pm.h
+++ b/arch/arm/plat-samsung/include/plat/pm.h
@@ -105,10 +105,12 @@ extern void s3c_pm_do_restore_core(struct sleep_save *ptr, int count);
 extern int s3c_irqext_wake(struct irq_data *data, unsigned int state);
 extern int s3c24xx_irq_suspend(void);
 extern void s3c24xx_irq_resume(void);
+extern int s3c_irq_wake(struct irq_data *data, unsigned int state);
 #else
 #define s3c_irqext_wake NULL
 #define s3c24xx_irq_suspend NULL
 #define s3c24xx_irq_resume  NULL
+#define s3c_irq_wake NULL
 #endif
 
 extern struct syscore_ops s3c24xx_irq_syscore_ops;
-- 
1.7.4.1
