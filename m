From: okaya@codeaurora.org (Sinan Kaya)
Date: Sat, 19 Nov 2016 14:28:37 -0500
Subject: [PATCH] dmaengine: qcom_hidma: autoload while probing ACPI
Message-ID: <1479583718-2716-1-git-send-email-okaya@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

MODULE_DEVICE_TABLE is used by the kernel to determine which device driver
should be loaded for which platform device. MODULE_DEVICE_TABLE has been
only defined for the device-tree based platforms in the current code.
Defining it also for ACPI based platforms.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/dma/qcom/hidma.c      | 1 +
 drivers/dma/qcom/hidma_mgmt.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/dma/qcom/hidma.c b/drivers/dma/qcom/hidma.c
index 248e74b..3c982c9 100644
--- a/drivers/dma/qcom/hidma.c
+++ b/drivers/dma/qcom/hidma.c
@@ -895,6 +895,7 @@ static int hidma_remove(struct platform_device *pdev)
 	{"QCOM8062"},
 	{},
 };
+MODULE_DEVICE_TABLE(acpi, hidma_acpi_ids);
 #endif
 
 static const struct of_device_id hidma_match[] = {
diff --git a/drivers/dma/qcom/hidma_mgmt.c b/drivers/dma/qcom/hidma_mgmt.c
index 985f5ac..f847d32 100644
--- a/drivers/dma/qcom/hidma_mgmt.c
+++ b/drivers/dma/qcom/hidma_mgmt.c
@@ -282,6 +282,7 @@ static int hidma_mgmt_probe(struct platform_device *pdev)
 	{"QCOM8060"},
 	{},
 };
+MODULE_DEVICE_TABLE(acpi, hidma_mgmt_acpi_ids);
 #endif
 
 static const struct of_device_id hidma_mgmt_match[] = {
-- 
1.9.1
