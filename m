From: swarren@nvidia.com (Stephen Warren)
Date: Tue,  5 Jul 2011 14:29:20 -0600
Subject: [PATCH 1/3] mmc/tegra: Use engineering names in DT compatible property
In-Reply-To: <1309897762-23564-1-git-send-email-swarren@nvidia.com>
References: <1309897762-23564-1-git-send-email-swarren@nvidia.com>
Message-ID: <1309897762-23564-2-git-send-email-swarren@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Engineering names are more stable than marketing names. Hence, use them
for Device Tree compatible properties instead.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 drivers/mmc/host/sdhci-pltfm.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltfm.c
index 9cc92b0..0cf16bb 100644
--- a/drivers/mmc/host/sdhci-pltfm.c
+++ b/drivers/mmc/host/sdhci-pltfm.c
@@ -52,7 +52,7 @@ static struct sdhci_ops sdhci_pltfm_ops = {
 #if defined(CONFIG_OF)
 #include <linux/of_device.h>
 static const struct of_device_id sdhci_dt_ids[] = {
-	{ .compatible = "nvidia,tegra250-sdhci", .data = &sdhci_tegra_dt_pdata },
+	{ .compatible = "nvidia,tegra20-sdhci", .data = &sdhci_tegra_dt_pdata },
 	{ }
 };
 MODULE_DEVICE_TABLE(platform, sdhci_dt_ids);
-- 
1.7.0.4
