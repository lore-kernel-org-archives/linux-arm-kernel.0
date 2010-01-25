From: haojian.zhuang@marvell.com (Haojian Zhuang)
Date: Mon, 25 Jan 2010 05:07:11 -0500
Subject: [PATCH] mmp2: add mask function in irq
Message-ID: <mailman.163.1264417378.2170.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
---
 arch/arm/mach-mmp/irq-mmp2.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mmp/irq-mmp2.c b/arch/arm/mach-mmp/irq-mmp2.c
index dcd36f4..ddebde8 100644
--- a/arch/arm/mach-mmp/irq-mmp2.c
+++ b/arch/arm/mach-mmp/irq-mmp2.c
@@ -37,6 +37,7 @@ static void icu_unmask_irq(unsigned int irq)

 static struct irq_chip icu_irq_chip = {
 	.name		= "icu_irq",
+	.mask		= icu_mask_irq,
 	.mask_ack	= icu_mask_irq,
 	.unmask		= icu_unmask_irq,
 };
@@ -80,6 +81,7 @@ SECOND_IRQ_UNMASK(_name_, irq_base, prefix)				\
 SECOND_IRQ_DEMUX(_name_, irq_base, prefix)				\
 static struct irq_chip _name_##_irq_chip = {				\
 	.name		= #_name_,					\
+	.mask		= _name_##_mask_irq,				\
 	.mask_ack	= _name_##_mask_irq,				\
 	.unmask		= _name_##_unmask_irq,				\
 }
-- 
1.5.6.5
