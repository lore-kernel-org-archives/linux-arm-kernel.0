From: fabf@skynet.be (Fabian Frederick)
Date: Mon, 16 Mar 2015 20:54:39 +0100
Subject: [PATCH 29/35 linux-next] gpu: constify of_device_id array
In-Reply-To: <1426535685-25996-1-git-send-email-fabf@skynet.be>
References: <1426533469-25458-1-git-send-email-fabf@skynet.be>
 <1426535685-25996-1-git-send-email-fabf@skynet.be>
Message-ID: <1426535685-25996-8-git-send-email-fabf@skynet.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

of_device_id is always used as const.
(See driver.of_match_table and open firmware functions)

Signed-off-by: Fabian Frederick <fabf@skynet.be>
---
 drivers/gpu/drm/armada/armada_crtc.c    | 2 +-
 drivers/gpu/drm/exynos/exynos_drm_dsi.c | 2 +-
 drivers/gpu/drm/exynos/exynos_hdmi.c    | 2 +-
 drivers/gpu/drm/exynos/exynos_mixer.c   | 2 +-
 drivers/gpu/drm/panel/panel-ld9040.c    | 2 +-
 drivers/gpu/drm/panel/panel-s6e8aa0.c   | 2 +-
 drivers/gpu/drm/sti/sti_dvo.c           | 2 +-
 drivers/gpu/drm/sti/sti_hqvdp.c         | 2 +-
 drivers/gpu/drm/tilcdc/tilcdc_drv.c     | 4 ++--
 drivers/gpu/drm/tilcdc/tilcdc_panel.c   | 2 +-
 drivers/gpu/drm/tilcdc/tilcdc_slave.c   | 4 ++--
 drivers/gpu/drm/tilcdc/tilcdc_tfp410.c  | 4 ++--
 drivers/gpu/host1x/dev.c                | 2 +-
 drivers/gpu/host1x/mipi.c               | 2 +-
 14 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/armada/armada_crtc.c b/drivers/gpu/drm/armada/armada_crtc.c
index 42d2ffa..517542f 100644
--- a/drivers/gpu/drm/armada/armada_crtc.c
+++ b/drivers/gpu/drm/armada/armada_crtc.c
@@ -1201,7 +1201,7 @@ static int armada_lcd_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static struct of_device_id armada_lcd_of_match[] = {
+static const struct of_device_id armada_lcd_of_match[] = {
 	{
 		.compatible	= "marvell,dove-lcd",
 		.data		= &armada510_ops,
diff --git a/drivers/gpu/drm/exynos/exynos_drm_dsi.c b/drivers/gpu/drm/exynos/exynos_drm_dsi.c
index 05fe93d..78afb45 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_dsi.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_dsi.c
@@ -330,7 +330,7 @@ static struct exynos_dsi_driver_data exynos5_dsi_driver_data = {
 	.plltmr_reg = 0x58,
 };
 
-static struct of_device_id exynos_dsi_of_match[] = {
+static const struct of_device_id exynos_dsi_of_match[] = {
 	{ .compatible = "samsung,exynos3250-mipi-dsi",
 	  .data = &exynos3_dsi_driver_data },
 	{ .compatible = "samsung,exynos4210-mipi-dsi",
diff --git a/drivers/gpu/drm/exynos/exynos_hdmi.c b/drivers/gpu/drm/exynos/exynos_hdmi.c
index 229b361..0294402 100644
--- a/drivers/gpu/drm/exynos/exynos_hdmi.c
+++ b/drivers/gpu/drm/exynos/exynos_hdmi.c
@@ -2274,7 +2274,7 @@ err_data:
 	return NULL;
 }
 
-static struct of_device_id hdmi_match_types[] = {
+static const struct of_device_id hdmi_match_types[] = {
 	{
 		.compatible = "samsung,exynos5-hdmi",
 		.data = &exynos5_hdmi_driver_data,
diff --git a/drivers/gpu/drm/exynos/exynos_mixer.c b/drivers/gpu/drm/exynos/exynos_mixer.c
index 3518bc4..6297105 100644
--- a/drivers/gpu/drm/exynos/exynos_mixer.c
+++ b/drivers/gpu/drm/exynos/exynos_mixer.c
@@ -1224,7 +1224,7 @@ static struct platform_device_id mixer_driver_types[] = {
 	}
 };
 
-static struct of_device_id mixer_match_types[] = {
+static const struct of_device_id mixer_match_types[] = {
 	{
 		.compatible = "samsung,exynos4210-mixer",
 		.data	= &exynos4210_mxr_drv_data,
diff --git a/drivers/gpu/drm/panel/panel-ld9040.c b/drivers/gpu/drm/panel/panel-ld9040.c
index 08cf2c5..0ab5b69 100644
--- a/drivers/gpu/drm/panel/panel-ld9040.c
+++ b/drivers/gpu/drm/panel/panel-ld9040.c
@@ -367,7 +367,7 @@ static int ld9040_remove(struct spi_device *spi)
 	return 0;
 }
 
-static struct of_device_id ld9040_of_match[] = {
+static const struct of_device_id ld9040_of_match[] = {
 	{ .compatible = "samsung,ld9040" },
 	{ }
 };
diff --git a/drivers/gpu/drm/panel/panel-s6e8aa0.c b/drivers/gpu/drm/panel/panel-s6e8aa0.c
index 144b273..3005110 100644
--- a/drivers/gpu/drm/panel/panel-s6e8aa0.c
+++ b/drivers/gpu/drm/panel/panel-s6e8aa0.c
@@ -1041,7 +1041,7 @@ static int s6e8aa0_remove(struct mipi_dsi_device *dsi)
 	return 0;
 }
 
-static struct of_device_id s6e8aa0_of_match[] = {
+static const struct of_device_id s6e8aa0_of_match[] = {
 	{ .compatible = "samsung,s6e8aa0" },
 	{ }
 };
diff --git a/drivers/gpu/drm/sti/sti_dvo.c b/drivers/gpu/drm/sti/sti_dvo.c
index aeb5070..f619ae2 100644
--- a/drivers/gpu/drm/sti/sti_dvo.c
+++ b/drivers/gpu/drm/sti/sti_dvo.c
@@ -537,7 +537,7 @@ static int sti_dvo_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static struct of_device_id dvo_of_match[] = {
+static const struct of_device_id dvo_of_match[] = {
 	{ .compatible = "st,stih407-dvo", },
 	{ /* end node */ }
 };
diff --git a/drivers/gpu/drm/sti/sti_hqvdp.c b/drivers/gpu/drm/sti/sti_hqvdp.c
index b0eb62d..d4324f1 100644
--- a/drivers/gpu/drm/sti/sti_hqvdp.c
+++ b/drivers/gpu/drm/sti/sti_hqvdp.c
@@ -1050,7 +1050,7 @@ static int sti_hqvdp_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static struct of_device_id hqvdp_of_match[] = {
+static const struct of_device_id hqvdp_of_match[] = {
 	{ .compatible = "st,stih407-hqvdp", },
 	{ /* end node */ }
 };
diff --git a/drivers/gpu/drm/tilcdc/tilcdc_drv.c b/drivers/gpu/drm/tilcdc/tilcdc_drv.c
index 095fca9..5f7e602 100644
--- a/drivers/gpu/drm/tilcdc/tilcdc_drv.c
+++ b/drivers/gpu/drm/tilcdc/tilcdc_drv.c
@@ -47,7 +47,7 @@ void tilcdc_slave_probedefer(bool defered)
 	slave_probing = defered;
 }
 
-static struct of_device_id tilcdc_of_match[];
+static const struct of_device_id tilcdc_of_match[];
 
 static struct drm_framebuffer *tilcdc_fb_create(struct drm_device *dev,
 		struct drm_file *file_priv, struct drm_mode_fb_cmd2 *mode_cmd)
@@ -634,7 +634,7 @@ static int tilcdc_pdev_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static struct of_device_id tilcdc_of_match[] = {
+static const struct of_device_id tilcdc_of_match[] = {
 		{ .compatible = "ti,am33xx-tilcdc", },
 		{ },
 };
diff --git a/drivers/gpu/drm/tilcdc/tilcdc_panel.c b/drivers/gpu/drm/tilcdc/tilcdc_panel.c
index 7a03158..8a374c7 100644
--- a/drivers/gpu/drm/tilcdc/tilcdc_panel.c
+++ b/drivers/gpu/drm/tilcdc/tilcdc_panel.c
@@ -450,7 +450,7 @@ static int panel_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static struct of_device_id panel_of_match[] = {
+static const struct of_device_id panel_of_match[] = {
 		{ .compatible = "ti,tilcdc,panel", },
 		{ },
 };
diff --git a/drivers/gpu/drm/tilcdc/tilcdc_slave.c b/drivers/gpu/drm/tilcdc/tilcdc_slave.c
index 3775fd4..1cab937 100644
--- a/drivers/gpu/drm/tilcdc/tilcdc_slave.c
+++ b/drivers/gpu/drm/tilcdc/tilcdc_slave.c
@@ -304,7 +304,7 @@ static const struct tilcdc_module_ops slave_module_ops = {
  * Device:
  */
 
-static struct of_device_id slave_of_match[];
+static const struct of_device_id slave_of_match[];
 
 static int slave_probe(struct platform_device *pdev)
 {
@@ -385,7 +385,7 @@ static int slave_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static struct of_device_id slave_of_match[] = {
+static const struct of_device_id slave_of_match[] = {
 		{ .compatible = "ti,tilcdc,slave", },
 		{ },
 };
diff --git a/drivers/gpu/drm/tilcdc/tilcdc_tfp410.c b/drivers/gpu/drm/tilcdc/tilcdc_tfp410.c
index 354c47c..1bd8e81 100644
--- a/drivers/gpu/drm/tilcdc/tilcdc_tfp410.c
+++ b/drivers/gpu/drm/tilcdc/tilcdc_tfp410.c
@@ -304,7 +304,7 @@ static const struct tilcdc_module_ops tfp410_module_ops = {
  * Device:
  */
 
-static struct of_device_id tfp410_of_match[];
+static const struct of_device_id tfp410_of_match[];
 
 static int tfp410_probe(struct platform_device *pdev)
 {
@@ -394,7 +394,7 @@ static int tfp410_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static struct of_device_id tfp410_of_match[] = {
+static const struct of_device_id tfp410_of_match[] = {
 		{ .compatible = "ti,tilcdc,tfp410", },
 		{ },
 };
diff --git a/drivers/gpu/host1x/dev.c b/drivers/gpu/host1x/dev.c
index 53d3d1d..f33fd77 100644
--- a/drivers/gpu/host1x/dev.c
+++ b/drivers/gpu/host1x/dev.c
@@ -87,7 +87,7 @@ static const struct host1x_info host1x04_info = {
 	.sync_offset = 0x2100,
 };
 
-static struct of_device_id host1x_of_match[] = {
+static const struct of_device_id host1x_of_match[] = {
 	{ .compatible = "nvidia,tegra124-host1x", .data = &host1x04_info, },
 	{ .compatible = "nvidia,tegra114-host1x", .data = &host1x02_info, },
 	{ .compatible = "nvidia,tegra30-host1x", .data = &host1x01_info, },
diff --git a/drivers/gpu/host1x/mipi.c b/drivers/gpu/host1x/mipi.c
index fbc6ee6..ba54db4 100644
--- a/drivers/gpu/host1x/mipi.c
+++ b/drivers/gpu/host1x/mipi.c
@@ -277,7 +277,7 @@ static const struct tegra_mipi_soc tegra124_mipi_soc = {
 	.num_pads = ARRAY_SIZE(tegra124_mipi_pads),
 };
 
-static struct of_device_id tegra_mipi_of_match[] = {
+static const struct of_device_id tegra_mipi_of_match[] = {
 	{ .compatible = "nvidia,tegra114-mipi", .data = &tegra114_mipi_soc },
 	{ .compatible = "nvidia,tegra124-mipi", .data = &tegra124_mipi_soc },
 	{ },
-- 
2.1.0
