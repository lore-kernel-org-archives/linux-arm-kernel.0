From: rsahu@apm.com (Rameshwar Prasad Sahu)
Date: Tue, 22 Dec 2015 18:50:51 +0530
Subject: [PATCH] mmc: host: arasan: sdhci-of-arasan: Remove no-hispd and
 no-cmd23 quirks for sdhci-arasan4.9a
Message-ID: <1450790451-20735-1-git-send-email-rsahu@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Arason SD host controller supports set block count command (cmd23)
and high speed mode. This patch re-enable both of these features that
was disabled. For device that doesn't support high speed, it should
configure its capability register accordingly instead disables it
explicitly.

Signed-off-by: Rameshwar Prasad Sahu <rsahu@apm.com>
---
 drivers/mmc/host/sdhci-of-arasan.c |    5 -----
 1 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
index 75379cb..5d9fdb3 100644
--- a/drivers/mmc/host/sdhci-of-arasan.c
+++ b/drivers/mmc/host/sdhci-of-arasan.c
@@ -172,11 +172,6 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
 		goto clk_disable_all;
 	}

-	if (of_device_is_compatible(pdev->dev.of_node, "arasan,sdhci-4.9a")) {
-		host->quirks |= SDHCI_QUIRK_NO_HISPD_BIT;
-		host->quirks2 |= SDHCI_QUIRK2_HOST_NO_CMD23;
-	}
-
 	sdhci_get_of_property(pdev);
 	pltfm_host = sdhci_priv(host);
 	pltfm_host->priv = sdhci_arasan;
--
1.7.1
