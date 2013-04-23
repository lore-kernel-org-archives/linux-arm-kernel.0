From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 23 Apr 2013 18:30:44 +0200
Subject: [PATCH 12/21] mmc: sdhci-tegra: fix MODULE_DEVICE_TABLE
In-Reply-To: <1366734653-488286-1-git-send-email-arnd@arndb.de>
References: <1366734653-488286-1-git-send-email-arnd@arndb.de>
Message-ID: <1366734653-488286-13-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The symbol referenced in MODULE_DEVICE_TABLE must match the actual
table, otherwise we get a build error like

sdhci-tegra.c:206:34: error: '__mod_of_device_table' aliased to undefined symbol 'sdhci_dt_ids'

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Stephen Warren <swarren@nvidia.com>
Cc: Chris Ball <cjb@laptop.org>
---
 drivers/mmc/host/sdhci-tegra.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index 08b06e9..85052bf 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -214,7 +214,7 @@ static const struct of_device_id sdhci_tegra_dt_match[] = {
 #endif
 	{}
 };
-MODULE_DEVICE_TABLE(of, sdhci_dt_ids);
+MODULE_DEVICE_TABLE(of, sdhci_tegra_dt_match);
 
 static void sdhci_tegra_parse_dt(struct device *dev,
 					struct sdhci_tegra *tegra_host)
-- 
1.8.1.2
