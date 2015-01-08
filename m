From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu,  8 Jan 2015 08:24:46 +0100
Subject: [PATCH 2/3] soc/tegra: fuse: Constify tegra_fuse_info structures
In-Reply-To: <1420701887-1465-1-git-send-email-thierry.reding@gmail.com>
References: <1420701887-1465-1-git-send-email-thierry.reding@gmail.com>
Message-ID: <1420701887-1465-2-git-send-email-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thierry Reding <treding@nvidia.com>

These structures contain read-only data and are never modified, so they
can be const.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/soc/tegra/fuse/fuse-tegra30.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/soc/tegra/fuse/fuse-tegra30.c b/drivers/soc/tegra/fuse/fuse-tegra30.c
index 8646fa920d8d..d1a4290cda5c 100644
--- a/drivers/soc/tegra/fuse/fuse-tegra30.c
+++ b/drivers/soc/tegra/fuse/fuse-tegra30.c
@@ -56,7 +56,7 @@ struct tegra_fuse_info {
 
 static void __iomem *fuse_base;
 static struct clk *fuse_clk;
-static struct tegra_fuse_info *fuse_info;
+static const struct tegra_fuse_info *fuse_info;
 
 u32 tegra30_fuse_readl(const unsigned int offset)
 {
@@ -78,18 +78,18 @@ u32 tegra30_fuse_readl(const unsigned int offset)
 	return val;
 }
 
-static struct tegra_fuse_info tegra30_info = {
+static const struct tegra_fuse_info tegra30_info = {
 	.size			= 0x2a4,
 	.spare_bit		= 0x144,
 	.speedo_idx		= SPEEDO_TEGRA30,
 };
 
-static struct tegra_fuse_info tegra114_info = {
+static const struct tegra_fuse_info tegra114_info = {
 	.size			= 0x2a0,
 	.speedo_idx		= SPEEDO_TEGRA114,
 };
 
-static struct tegra_fuse_info tegra124_info = {
+static const struct tegra_fuse_info tegra124_info = {
 	.size			= 0x300,
 	.speedo_idx		= SPEEDO_TEGRA124,
 };
-- 
2.1.3
