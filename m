From: antoine.tenart@free-electrons.com (=?UTF-8?q?Antoine=20T=C3=A9nart?=)
Date: Mon,  7 Jul 2014 12:16:10 +0200
Subject: [PATCH v9 4/7] ata: ahci_platform: add a generic AHCI compatible
In-Reply-To: <1404728173-20263-1-git-send-email-antoine.tenart@free-electrons.com>
References: <1404728173-20263-1-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <1404728173-20263-5-git-send-email-antoine.tenart@free-electrons.com>
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
index ebe505c17763..a30cecd68609 100644
--- a/drivers/ata/ahci_platform.c
+++ b/drivers/ata/ahci_platform.c
@@ -78,6 +78,8 @@ static SIMPLE_DEV_PM_OPS(ahci_pm_ops, ahci_platform_suspend,
 			 ahci_platform_resume);
 
 static const struct of_device_id ahci_of_match[] = {
+	{ .compatible = "generic-ahci", },
+	/* Keep the following compatibles for device tree compatibility */
 	{ .compatible = "snps,spear-ahci", },
 	{ .compatible = "snps,exynos5440-ahci", },
 	{ .compatible = "ibm,476gtr-ahci", },
-- 
1.9.1
