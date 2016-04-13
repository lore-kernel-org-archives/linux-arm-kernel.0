From: mbrugger@suse.com (Matthias Brugger)
Date: Wed, 13 Apr 2016 12:30:55 +0200
Subject: [PATCH 5/6] staging: fsl-mc: Clean up of irq_chip callbacks
In-Reply-To: <1460543456-11345-1-git-send-email-mbrugger@suse.com>
References: <1460543456-11345-1-git-send-email-mbrugger@suse.com>
Message-ID: <1460543456-11345-6-git-send-email-mbrugger@suse.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

platform_msi_create_irq_domain already sets the irq_chip callbacks accordingly.
We don't need to define them explicitly in the driver.

Signed-off-by: Matthias Brugger <mbrugger@suse.com>
---
 drivers/staging/fsl-mc/bus/irq-gic-v3-its-fsl-mc-msi.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/staging/fsl-mc/bus/irq-gic-v3-its-fsl-mc-msi.c b/drivers/staging/fsl-mc/bus/irq-gic-v3-its-fsl-mc-msi.c
index 0eecb7e..c787090 100644
--- a/drivers/staging/fsl-mc/bus/irq-gic-v3-its-fsl-mc-msi.c
+++ b/drivers/staging/fsl-mc/bus/irq-gic-v3-its-fsl-mc-msi.c
@@ -22,9 +22,6 @@
 
 static struct irq_chip its_msi_irq_chip = {
 	.name = "fsl-mc-bus-msi",
-	.irq_mask = irq_chip_mask_parent,
-	.irq_unmask = irq_chip_unmask_parent,
-	.irq_eoi = irq_chip_eoi_parent,
 };
 
 static int its_fsl_mc_msi_prepare(struct irq_domain *msi_domain,
-- 
2.6.6
