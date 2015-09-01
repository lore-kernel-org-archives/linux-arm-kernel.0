From: vaibhav.hiremath@linaro.org (Vaibhav Hiremath)
Date: Wed,  2 Sep 2015 00:54:14 +0530
Subject: [PATCH 2/2] mmc: sdhci-pxav3: Print ret value on error from
 sdhci_add_host() fn
In-Reply-To: <1441135454-6902-1-git-send-email-vaibhav.hiremath@linaro.org>
References: <1441135454-6902-1-git-send-email-vaibhav.hiremath@linaro.org>
Message-ID: <1441135454-6902-3-git-send-email-vaibhav.hiremath@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Return value would give clear information about the actual root-cause
of the failure.

Signed-off-by: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
---
 drivers/mmc/host/sdhci-pxav3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-pxav3.c b/drivers/mmc/host/sdhci-pxav3.c
index d02bc37..5d26fe0 100644
--- a/drivers/mmc/host/sdhci-pxav3.c
+++ b/drivers/mmc/host/sdhci-pxav3.c
@@ -455,7 +455,7 @@ static int sdhci_pxav3_probe(struct platform_device *pdev)
 
 	ret = sdhci_add_host(host);
 	if (ret) {
-		dev_err(&pdev->dev, "failed to add host\n");
+		dev_err(&pdev->dev, "failed to add host ret - %d\n", ret);
 		goto err_add_host;
 	}
 
-- 
1.9.1
