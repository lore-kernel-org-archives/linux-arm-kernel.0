From: eric@anholt.net (Eric Anholt)
Date: Fri, 29 May 2015 14:06:11 -0700
Subject: [PATCH v2 1/2] mmc: sdhci-bcm2835: Clean up platform allocations if
 sdhci init fails.
Message-ID: <1432933572-8695-1-git-send-email-eric@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Eric Anholt <eric@anholt.net>
---
 drivers/mmc/host/sdhci-bcm2835.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-bcm2835.c b/drivers/mmc/host/sdhci-bcm2835.c
index 0ef0343..32f4046 100644
--- a/drivers/mmc/host/sdhci-bcm2835.c
+++ b/drivers/mmc/host/sdhci-bcm2835.c
@@ -173,8 +173,11 @@ static int bcm2835_sdhci_probe(struct platform_device *pdev)
 		goto err;
 	}
 
-	return sdhci_add_host(host);
+	ret = sdhci_add_host(host);
+	if (ret)
+		goto err;
 
+	return 0;
 err:
 	sdhci_pltfm_free(pdev);
 	return ret;
-- 
2.1.4
