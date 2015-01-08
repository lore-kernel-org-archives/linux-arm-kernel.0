From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu,  8 Jan 2015 08:24:47 +0100
Subject: [PATCH 3/3] soc/tegra: fuse: Add Tegra132 support
In-Reply-To: <1420701887-1465-1-git-send-email-thierry.reding@gmail.com>
References: <1420701887-1465-1-git-send-email-thierry.reding@gmail.com>
Message-ID: <1420701887-1465-3-git-send-email-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thierry Reding <treding@nvidia.com>

Tegra132 is very similar to Tegra124 from a peripheral point of view and
uses the same fuse controller.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/soc/tegra/fuse/fuse-tegra.c   | 1 +
 drivers/soc/tegra/fuse/fuse-tegra30.c | 2 ++
 2 files changed, 3 insertions(+)

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
index d1a4290cda5c..11fe22e0de73 100644
--- a/drivers/soc/tegra/fuse/fuse-tegra30.c
+++ b/drivers/soc/tegra/fuse/fuse-tegra30.c
@@ -184,6 +184,8 @@ static void __init legacy_fuse_init(void)
 	case TEGRA124:
 		fuse_info = &tegra124_info;
 		break;
+	case TEGRA132:
+		fuse_info = &tegra124_info;
 	default:
 		return;
 	}
-- 
2.1.3
