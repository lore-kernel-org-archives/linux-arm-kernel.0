From: mperttunen@nvidia.com (Mikko Perttunen)
Date: Thu, 15 Feb 2018 16:52:02 +0200
Subject: [PATCH v3 3/7] soc/tegra: pmc: Add Tegra194 compatibility string
In-Reply-To: <20180215145206.24775-1-mperttunen@nvidia.com>
References: <20180215145206.24775-1-mperttunen@nvidia.com>
Message-ID: <20180215145206.24775-4-mperttunen@nvidia.com>
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
2.16.1
