From: okaya@codeaurora.org (Sinan Kaya)
Date: Wed, 28 Sep 2016 22:12:41 -0400
Subject: [PATCH V4 04/10] dmaengine: qcom_hidma: configure DMA and MSI for OF
In-Reply-To: <1475115167-5898-1-git-send-email-okaya@codeaurora.org>
References: <1475115167-5898-1-git-send-email-okaya@codeaurora.org>
Message-ID: <1475115167-5898-5-git-send-email-okaya@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Configure the DMA bindings for the device tree based firmware.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/dma/qcom/hidma_mgmt.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/qcom/hidma_mgmt.c b/drivers/dma/qcom/hidma_mgmt.c
index 82f36e4..e8f6b84 100644
--- a/drivers/dma/qcom/hidma_mgmt.c
+++ b/drivers/dma/qcom/hidma_mgmt.c
@@ -375,8 +375,11 @@ static int __init hidma_mgmt_of_populate_channels(struct device_node *np)
 			ret = PTR_ERR(new_pdev);
 			goto out;
 		}
+		of_node_get(child);
+		new_pdev->dev.of_node = child;
 		of_dma_configure(&new_pdev->dev, child);
-
+		of_msi_configure(&new_pdev->dev, child);
+		of_node_put(child);
 		kfree(res);
 		res = NULL;
 	}
-- 
1.9.1
