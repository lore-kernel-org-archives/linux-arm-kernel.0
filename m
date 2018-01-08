From: mperttunen@nvidia.com (Mikko Perttunen)
Date: Mon, 8 Jan 2018 06:54:35 +0200
Subject: [PATCH 3/6] soc/tegra: pmc: Add Tegra194 compatibility string
In-Reply-To: <1515387278-29777-1-git-send-email-mperttunen@nvidia.com>
References: <1515387278-29777-1-git-send-email-mperttunen@nvidia.com>
Message-ID: <1515387278-29777-4-git-send-email-mperttunen@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Tegra194 PMC is mostly compatible with Tegra186, including in all
currently supported features. As such, add a new compatibility string
but point to the existing Tegra186 SoC data for now.

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 drivers/soc/tegra/pmc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
index ce62a47a6647..a2df230bf51a 100644
--- a/drivers/soc/tegra/pmc.c
+++ b/drivers/soc/tegra/pmc.c
@@ -1920,6 +1920,7 @@ static const struct tegra_pmc_soc tegra186_pmc_soc = {
 };
 
 static const struct of_device_id tegra_pmc_match[] = {
+	{ .compatible = "nvidia,tegra194-pmc", .data = &tegra186_pmc_soc },
 	{ .compatible = "nvidia,tegra186-pmc", .data = &tegra186_pmc_soc },
 	{ .compatible = "nvidia,tegra210-pmc", .data = &tegra210_pmc_soc },
 	{ .compatible = "nvidia,tegra132-pmc", .data = &tegra124_pmc_soc },
-- 
2.1.4
