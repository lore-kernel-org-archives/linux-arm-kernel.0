From: bgolaszewski@baylibre.com (Bartosz Golaszewski)
Date: Fri, 20 Jan 2017 12:21:58 +0100
Subject: [PATCH v5 07/14] sata: ahci-da850: add device tree match table
In-Reply-To: <1484911325-23425-1-git-send-email-bgolaszewski@baylibre.com>
References: <1484911325-23425-1-git-send-email-bgolaszewski@baylibre.com>
Message-ID: <1484911325-23425-8-git-send-email-bgolaszewski@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We're using device tree for da850-lcdk. Add the match table to allow
to probe the driver.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/ata/ahci_da850.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/ata/ahci_da850.c b/drivers/ata/ahci_da850.c
index 8cfdc86..7f5328f 100644
--- a/drivers/ata/ahci_da850.c
+++ b/drivers/ata/ahci_da850.c
@@ -121,11 +121,18 @@ static int ahci_da850_probe(struct platform_device *pdev)
 static SIMPLE_DEV_PM_OPS(ahci_da850_pm_ops, ahci_platform_suspend,
 			 ahci_platform_resume);
 
+static const struct of_device_id ahci_da850_of_match[] = {
+	{ .compatible = "ti,da850-ahci", },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, ahci_da850_of_match);
+
 static struct platform_driver ahci_da850_driver = {
 	.probe = ahci_da850_probe,
 	.remove = ata_platform_remove_one,
 	.driver = {
 		.name = DRV_NAME,
+		.of_match_table = ahci_da850_of_match,
 		.pm = &ahci_da850_pm_ops,
 	},
 };
-- 
2.9.3
