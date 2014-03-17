From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Mon, 17 Mar 2014 14:06:57 +0100
Subject: [PATCH] ata: ahci_sunxi: make ahci_sunxi_resume() static
Message-ID: <1725454.bVvdm9zQru@amdc1032>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/ata/ahci_sunxi.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: b/drivers/ata/ahci_sunxi.c
===================================================================
--- a/drivers/ata/ahci_sunxi.c	2014-03-17 13:59:05.556474489 +0100
+++ b/drivers/ata/ahci_sunxi.c	2014-03-17 13:59:06.220474478 +0100
@@ -209,7 +209,7 @@ disable_resources:
 }
 
 #ifdef CONFIG_PM_SLEEP
-int ahci_sunxi_resume(struct device *dev)
+static int ahci_sunxi_resume(struct device *dev)
 {
 	struct ata_host *host = dev_get_drvdata(dev);
 	struct ahci_host_priv *hpriv = host->private_data;
