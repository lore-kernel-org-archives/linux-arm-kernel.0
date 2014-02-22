From: hdegoede@redhat.com (Hans de Goede)
Date: Sat, 22 Feb 2014 16:53:38 +0100
Subject: [PATCH v7 09/15] ata: ahci_platform: Add DT compatible for Synopsis
 DWC AHCI controller
In-Reply-To: <1393084424-31099-1-git-send-email-hdegoede@redhat.com>
References: <1393084424-31099-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1393084424-31099-10-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Roger Quadros <rogerq@ti.com>

Add compatible string "snps,dwc-ahci", which should be used
for Synopsis Designware SATA cores. e.g. on TI OMAP5 and DRA7 platforms.

Signed-off-by: Roger Quadros <rogerq@ti.com>
Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/ata/ahci_platform.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ata/ahci_platform.c b/drivers/ata/ahci_platform.c
index bdadec1..d7e55ba 100644
--- a/drivers/ata/ahci_platform.c
+++ b/drivers/ata/ahci_platform.c
@@ -609,6 +609,7 @@ static const struct of_device_id ahci_of_match[] = {
 	{ .compatible = "snps,spear-ahci", },
 	{ .compatible = "snps,exynos5440-ahci", },
 	{ .compatible = "ibm,476gtr-ahci", },
+	{ .compatible = "snps,dwc-ahci", },
 	{},
 };
 MODULE_DEVICE_TABLE(of, ahci_of_match);
-- 
1.9.0
