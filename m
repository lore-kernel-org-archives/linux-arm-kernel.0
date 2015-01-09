From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri,  9 Jan 2015 11:49:33 +0100
Subject: [PATCH v3 3/3] soc/tegra: fuse: Add Tegra132 support
In-Reply-To: <1420707308-6974-1-git-send-email-thierry.reding@gmail.com>
References: <1420707308-6974-1-git-send-email-thierry.reding@gmail.com>
Message-ID: <1420800573-16385-1-git-send-email-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thierry Reding <treding@nvidia.com>

Tegra132 is very similar to Tegra124 from a peripheral point of view and
uses the same fuse controller.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
Changes in v3:
- collapse TEGRA124 and TEGRA132 cases into a single one (Alex Courbot)

Changes in v2:
- add missing break in Tegra132 case for legacy fuse init (Vince Hsu)
---
 drivers/soc/tegra/fuse/fuse-tegra.c   | 1 +
 drivers/soc/tegra/fuse/fuse-tegra30.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/soc/tegra/fuse/fuse-tegra.c b/drivers/soc/tegra/fuse/fuse-tegra.c
index 011a3363c265..c0d660f1aaac 100644
--- a/drivers/soc/tegra/fuse/fuse-tegra.c
+++ b/drivers/soc/tegra/fuse/fuse-tegra.c
@@ -81,6 +81,7 @@ static const struct of_device_id car_match[] __initconst = {
 	{ .compatible = "nvidia,tegra30-car", },
 	{ .compatible = "nvidia,tegra114-car", },
 	{ .compatible = "nvidia,tegra124-car", },
+	{ .compatible = "nvidia,tegra132-car", },
 	{},
 };
 
diff --git a/drivers/soc/tegra/fuse/fuse-tegra30.c b/drivers/soc/tegra/fuse/fuse-tegra30.c
index d1a4290cda5c..4d2f71bf65c5 100644
--- a/drivers/soc/tegra/fuse/fuse-tegra30.c
+++ b/drivers/soc/tegra/fuse/fuse-tegra30.c
@@ -182,6 +182,7 @@ static void __init legacy_fuse_init(void)
 		fuse_info = &tegra114_info;
 		break;
 	case TEGRA124:
+	case TEGRA132:
 		fuse_info = &tegra124_info;
 		break;
 	default:
-- 
2.1.3
