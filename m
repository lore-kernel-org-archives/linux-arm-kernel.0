From: yangyingliang@huawei.com (Yang Yingliang)
Date: Wed, 16 Sep 2015 11:58:26 +0800
Subject: [RFC PATCH v3 2/3] ia64: rename migrate_irqs() to avoid compiling
 error
In-Reply-To: <1442375907-11496-1-git-send-email-yangyingliang@huawei.com>
References: <1442375907-11496-1-git-send-email-yangyingliang@huawei.com>
Message-ID: <1442375907-11496-3-git-send-email-yangyingliang@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To avoid multi-declaration error after adding migrate_irqs into
kernel/irq/migration.c, rename migrate_irqs() to move_irqs().

Cc: Jiang Liu <jiang.liu@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Hanjun Guo <hanjun.guo@linaro.org>
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 arch/ia64/kernel/irq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/ia64/kernel/irq.c b/arch/ia64/kernel/irq.c
index de4fc00..005f339 100644
--- a/arch/ia64/kernel/irq.c
+++ b/arch/ia64/kernel/irq.c
@@ -98,7 +98,7 @@ unsigned int vectors_in_migration[NR_IRQS];
  * Since cpu_online_mask is already updated, we just need to check for
  * affinity that has zeros
  */
-static void migrate_irqs(void)
+static void move_irqs(void)
 {
 	int 		irq, new_cpu;
 
@@ -167,7 +167,7 @@ void fixup_irqs(void)
 	 * Phase 1: Locate IRQs bound to this cpu and
 	 * relocate them for cpu removal.
 	 */
-	migrate_irqs();
+	move_irqs();
 
 	/*
 	 * Phase 2: Perform interrupt processing for all entries reported in
-- 
2.5.0
