From: chao.xie@marvell.com (Chao Xie)
Date: Fri,  9 Sep 2011 12:18:12 +0800
Subject: [PATCH 2/4] ARM: mmp: add irq_disable callback for icu chip
In-Reply-To: <1315541894-19504-1-git-send-email-chao.xie@marvell.com>
References: <1315541894-19504-1-git-send-email-chao.xie@marvell.com>
Message-ID: <1315541894-19504-2-git-send-email-chao.xie@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Chao Xie <chao.xie@marvell.com>
---
 arch/arm/mach-mmp/irq-mmp2.c   |    2 ++
 arch/arm/mach-mmp/irq-pxa168.c |    1 +
 2 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mmp/irq-mmp2.c b/arch/arm/mach-mmp/irq-mmp2.c
index d21c544..36530be 100644
--- a/arch/arm/mach-mmp/irq-mmp2.c
+++ b/arch/arm/mach-mmp/irq-mmp2.c
@@ -41,6 +41,7 @@ static struct irq_chip icu_irq_chip = {
 	.irq_mask	= icu_mask_irq,
 	.irq_mask_ack	= icu_mask_irq,
 	.irq_unmask	= icu_unmask_irq,
+	.irq_disable	= icu_mask_irq,
 };
 
 static void pmic_irq_ack(struct irq_data *d)
@@ -90,6 +91,7 @@ static struct irq_chip _name_##_irq_chip = {				\
 	.name		= #_name_,					\
 	.irq_mask	= _name_##_mask_irq,				\
 	.irq_unmask	= _name_##_unmask_irq,				\
+	.irq_disable	= _name_##_mask_irq,				\
 }
 
 SECOND_IRQ_CHIP(pmic, IRQ_MMP2_PMIC_BASE, MMP2_ICU_INT4);
diff --git a/arch/arm/mach-mmp/irq-pxa168.c b/arch/arm/mach-mmp/irq-pxa168.c
index 89706a0..7185157 100644
--- a/arch/arm/mach-mmp/irq-pxa168.c
+++ b/arch/arm/mach-mmp/irq-pxa168.c
@@ -40,6 +40,7 @@ static struct irq_chip icu_irq_chip = {
 	.irq_ack	= icu_mask_irq,
 	.irq_mask	= icu_mask_irq,
 	.irq_unmask	= icu_unmask_irq,
+	.irq_disable	= icu_mask_irq,
 };
 
 void __init icu_init_irq(void)
-- 
1.7.0.4
