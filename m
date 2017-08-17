From: mperttunen@nvidia.com (Mikko Perttunen)
Date: Thu, 17 Aug 2017 21:54:13 +0300
Subject: [PATCH 6/6] drm/tegra: Add Tegra186 support for VIC
In-Reply-To: <20170817185413.6324-1-mperttunen@nvidia.com>
References: <20170817185413.6324-1-mperttunen@nvidia.com>
Message-ID: <20170817185413.6324-7-mperttunen@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add Tegra186 support for VIC - no changes are required except for new
firmware and compatibility string.

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 drivers/gpu/drm/tegra/drm.c |  1 +
 drivers/gpu/drm/tegra/vic.c | 10 ++++++++++
 2 files changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/tegra/drm.c b/drivers/gpu/drm/tegra/drm.c
index 3ba659a5940d..e3331a2bc082 100644
--- a/drivers/gpu/drm/tegra/drm.c
+++ b/drivers/gpu/drm/tegra/drm.c
@@ -1281,6 +1281,7 @@ static const struct of_device_id host1x_drm_subdevs[] = {
 	{ .compatible = "nvidia,tegra210-sor", },
 	{ .compatible = "nvidia,tegra210-sor1", },
 	{ .compatible = "nvidia,tegra210-vic", },
+	{ .compatible = "nvidia,tegra186-vic", },
 	{ /* sentinel */ }
 };
 
diff --git a/drivers/gpu/drm/tegra/vic.c b/drivers/gpu/drm/tegra/vic.c
index 2448229fa653..6697a21a250d 100644
--- a/drivers/gpu/drm/tegra/vic.c
+++ b/drivers/gpu/drm/tegra/vic.c
@@ -270,9 +270,16 @@ static const struct vic_config vic_t210_config = {
 	.firmware = NVIDIA_TEGRA_210_VIC_FIRMWARE,
 };
 
+#define NVIDIA_TEGRA_186_VIC_FIRMWARE "nvidia/tegra186/vic04_ucode.bin"
+
+static const struct vic_config vic_t186_config = {
+	.firmware = NVIDIA_TEGRA_186_VIC_FIRMWARE,
+};
+
 static const struct of_device_id vic_match[] = {
 	{ .compatible = "nvidia,tegra124-vic", .data = &vic_t124_config },
 	{ .compatible = "nvidia,tegra210-vic", .data = &vic_t210_config },
+	{ .compatible = "nvidia,tegra186-vic", .data = &vic_t186_config },
 	{ },
 };
 
@@ -405,3 +412,6 @@ MODULE_FIRMWARE(NVIDIA_TEGRA_124_VIC_FIRMWARE);
 #if IS_ENABLED(CONFIG_ARCH_TEGRA_210_SOC)
 MODULE_FIRMWARE(NVIDIA_TEGRA_210_VIC_FIRMWARE);
 #endif
+#if IS_ENABLED(CONFIG_ARCH_TEGRA_186_SOC)
+MODULE_FIRMWARE(NVIDIA_TEGRA_186_VIC_FIRMWARE);
+#endif
-- 
2.14.1
