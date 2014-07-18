From: antoine.tenart@free-electrons.com (=?UTF-8?q?Antoine=20T=C3=A9nart?=)
Date: Fri, 18 Jul 2014 14:30:04 +0200
Subject: [PATCH v10 5/8] ata: ahci_platform: add a generic AHCI compatible
In-Reply-To: <1405686607-8126-1-git-send-email-antoine.tenart@free-electrons.com>
References: <1405686607-8126-1-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <1405686607-8126-6-git-send-email-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ahci_platform driver is a generic driver using the libahci_platform
functions. Add a generic compatible to avoid having an endless list of
compatibles with no differences for the same driver.

Signed-off-by: Antoine T?nart <antoine.tenart@free-electrons.com>
---
 drivers/ata/ahci_platform.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/ata/ahci_platform.c b/drivers/ata/ahci_platform.c
index 95f9ca82082a..61b15e784020 100644
--- a/drivers/ata/ahci_platform.c
+++ b/drivers/ata/ahci_platform.c
@@ -77,6 +77,8 @@ static SIMPLE_DEV_PM_OPS(ahci_pm_ops, ahci_platform_suspend,
 			 ahci_platform_resume);
 
 static const struct of_device_id ahci_of_match[] = {
+	{ .compatible = "generic-ahci", },
+	/* Keep the following compatibles for device tree compatibility */
 	{ .compatible = "snps,spear-ahci", },
 	{ .compatible = "snps,exynos5440-ahci", },
 	{ .compatible = "ibm,476gtr-ahci", },
-- 
1.9.1
