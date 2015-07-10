From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Fri, 10 Jul 2015 15:38:26 +0900
Subject: [PATCH] pci: Drop owner assignment from platform_driver
Message-ID: <1436510306-5788-1-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

platform_driver does not need to set an owner because
platform_driver_register() will set it.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

---

The coccinelle script which generated the patch was sent here:
http://www.spinics.net/lists/kernel/msg2029903.html
---
 drivers/pci/host/pci-xgene-msi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/host/pci-xgene-msi.c b/drivers/pci/host/pci-xgene-msi.c
index 2d31d4d6fd08..9e1889e6aec7 100644
--- a/drivers/pci/host/pci-xgene-msi.c
+++ b/drivers/pci/host/pci-xgene-msi.c
@@ -582,7 +582,6 @@ error:
 static struct platform_driver xgene_msi_driver = {
 	.driver = {
 		.name = "xgene-msi",
-		.owner = THIS_MODULE,
 		.of_match_table = xgene_msi_match_table,
 	},
 	.probe = xgene_msi_probe,
-- 
1.9.1
