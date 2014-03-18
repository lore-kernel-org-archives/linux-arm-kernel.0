From: lho@apm.com (Loc Ho)
Date: Tue, 18 Mar 2014 12:14:37 -0600
Subject: [PATCH] ata: Fix compiler warning with APM X-Gene host controller
 driver
Message-ID: <1395166477-26408-1-git-send-email-lho@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes an compiler warning with APM X-Gene host controller
driver when compiled with DEBUG enabled.

Signed-off-by: Loc Ho <lho@apm.com>
---
 drivers/ata/ahci_xgene.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/ata/ahci_xgene.c b/drivers/ata/ahci_xgene.c
index fcf21f1..77c89bf 100644
--- a/drivers/ata/ahci_xgene.c
+++ b/drivers/ata/ahci_xgene.c
@@ -329,7 +329,7 @@ static int xgene_ahci_hw_init(struct ahci_host_priv *hpriv)
 	writel(0xffffffff, hpriv->mmio + HOST_IRQ_STAT);
 	readl(hpriv->mmio + HOST_IRQ_STAT); /* Force a barrier */
 	writel(0, ctx->csr_core + INTSTATUSMASK);
-	readl(ctx->csr_core + INTSTATUSMASK); /* Force a barrier */
+	val = readl(ctx->csr_core + INTSTATUSMASK); /* Force a barrier */
 	dev_dbg(ctx->dev, "top level interrupt mask 0x%X value 0x%08X\n",
 		INTSTATUSMASK, val);
 
-- 
1.5.5
