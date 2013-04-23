From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 23 Apr 2013 20:55:32 +0200
Subject: [PATCH 12/21] mmc: sdhci-tegra: fix MODULE_DEVICE_TABLE
In-Reply-To: <87bo95tctk.fsf@octavius.laptop.org>
References: <1366734653-488286-1-git-send-email-arnd@arndb.de>
 <1366734653-488286-13-git-send-email-arnd@arndb.de>
 <87bo95tctk.fsf@octavius.laptop.org>
Message-ID: <201304232055.32715.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The symbol referenced in MODULE_DEVICE_TABLE must match the actual
table, otherwise we get a build error like

sdhci-tegra.c:206:34: error: '__mod_of_device_table' aliased to undefined symbol 'sdhci_dt_ids'

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Stephen Warren <swarren@nvidia.com>
Cc: Chris Ball <cjb@laptop.org>
---
On Tuesday 23 April 2013, Chris Ball wrote:

> I was going to take this, but it doesn't apply to mmc-next or
> linux-next, because the #endif in your first line of context isn't
> present in those trees -- which tree is this based on?

I based it on 3.9-rc8.

> Sounds like it might make more sense for you to take this; if so:
> Acked-by: Chris Ball <cjb@laptop.org>

This is the rebased version on linux-next. I think it's better if you
take it, otherwise we just create a merge conflict for Linus.

diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index 45048d1..e0dba74 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -203,7 +203,7 @@ static const struct of_device_id sdhci_tegra_dt_match[] = {
 	{ .compatible = "nvidia,tegra20-sdhci", .data = &soc_data_tegra20 },
 	{}
 };
-MODULE_DEVICE_TABLE(of, sdhci_dt_ids);
+MODULE_DEVICE_TABLE(of, sdhci_tegra_dt_match);
 
 static void sdhci_tegra_parse_dt(struct device *dev)
 {
