From: zyw@rock-chips.com (Chris Zhong)
Date: Mon, 20 Feb 2017 16:02:19 +0800
Subject: [RESEND PATCH v7 3/7] drm/rockchip/dsi: dw-mipi: correct the coding
 style
In-Reply-To: <1487577744-2855-1-git-send-email-zyw@rock-chips.com>
References: <1487577744-2855-1-git-send-email-zyw@rock-chips.com>
Message-ID: <1487577744-2855-4-git-send-email-zyw@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

correct the coding style, according the checkpatch scripts

Signed-off-by: Chris Zhong <zyw@rock-chips.com>
Reviewed-by: Sean Paul <seanpaul@chromium.org>
---

Changes in v6: None
Changes in v5: None
Changes in v4: None
Changes in v3: None

 drivers/gpu/drm/rockchip/dw-mipi-dsi.c | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/dw-mipi-dsi.c b/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
index 4e74681..836cb83 100644
--- a/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
+++ b/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
@@ -157,7 +157,6 @@
 #define LPRX_TO_CNT(p)			((p) & 0xffff)
 
 #define DSI_BTA_TO_CNT			0x8c
-
 #define DSI_LPCLK_CTRL			0x94
 #define AUTO_CLKLANE_CTRL		BIT(1)
 #define PHY_TXREQUESTCLKHS		BIT(0)
@@ -223,11 +222,11 @@
 
 #define HSFREQRANGE_SEL(val)	(((val) & 0x3f) << 1)
 
-#define INPUT_DIVIDER(val)	((val - 1) & 0x7f)
+#define INPUT_DIVIDER(val)	(((val) - 1) & 0x7f)
 #define LOW_PROGRAM_EN		0
 #define HIGH_PROGRAM_EN		BIT(7)
-#define LOOP_DIV_LOW_SEL(val)	((val - 1) & 0x1f)
-#define LOOP_DIV_HIGH_SEL(val)	(((val - 1) >> 5) & 0x1f)
+#define LOOP_DIV_LOW_SEL(val)	(((val) - 1) & 0x1f)
+#define LOOP_DIV_HIGH_SEL(val)	((((val) - 1) >> 5) & 0x1f)
 #define PLL_LOOP_DIV_EN		BIT(5)
 #define PLL_INPUT_DIV_EN	BIT(4)
 
@@ -369,6 +368,7 @@ static inline struct dw_mipi_dsi *encoder_to_dsi(struct drm_encoder *encoder)
 {
 	return container_of(encoder, struct dw_mipi_dsi, encoder);
 }
+
 static inline void dsi_write(struct dw_mipi_dsi *dsi, u32 reg, u32 val)
 {
 	writel(val, dsi->base + reg);
@@ -380,7 +380,7 @@ static inline u32 dsi_read(struct dw_mipi_dsi *dsi, u32 reg)
 }
 
 static void dw_mipi_dsi_phy_write(struct dw_mipi_dsi *dsi, u8 test_code,
-				 u8 test_data)
+				  u8 test_data)
 {
 	/*
 	 * With the falling edge on TESTCLK, the TESTDIN[7:0] signal content
@@ -496,7 +496,6 @@ static int dw_mipi_dsi_phy_init(struct dw_mipi_dsi *dsi)
 	dsi_write(dsi, DSI_PHY_RSTZ, PHY_ENFORCEPLL | PHY_ENABLECLK |
 				     PHY_UNRSTZ | PHY_UNSHUTDOWNZ);
 
-
 	ret = readl_poll_timeout(dsi->base + DSI_PHY_STATUS,
 				 val, val & LOCK, 1000, PHY_STATUS_TIMEOUT_US);
 	if (ret < 0) {
@@ -571,7 +570,7 @@ static int dw_mipi_dsi_host_attach(struct mipi_dsi_host *host,
 
 	if (device->lanes > dsi->pdata->max_data_lanes) {
 		dev_err(dsi->dev, "the number of data lanes(%u) is too many\n",
-				device->lanes);
+			device->lanes);
 		return -EINVAL;
 	}
 
@@ -1060,14 +1059,14 @@ dw_mipi_dsi_encoder_atomic_check(struct drm_encoder *encoder,
 	return 0;
 }
 
-static struct drm_encoder_helper_funcs
+static const struct drm_encoder_helper_funcs
 dw_mipi_dsi_encoder_helper_funcs = {
 	.enable = dw_mipi_dsi_encoder_enable,
 	.disable = dw_mipi_dsi_encoder_disable,
 	.atomic_check = dw_mipi_dsi_encoder_atomic_check,
 };
 
-static struct drm_encoder_funcs dw_mipi_dsi_encoder_funcs = {
+static const struct drm_encoder_funcs dw_mipi_dsi_encoder_funcs = {
 	.destroy = drm_encoder_cleanup,
 };
 
@@ -1103,7 +1102,7 @@ static void dw_mipi_dsi_drm_connector_destroy(struct drm_connector *connector)
 	drm_connector_cleanup(connector);
 }
 
-static struct drm_connector_funcs dw_mipi_dsi_atomic_connector_funcs = {
+static const struct drm_connector_funcs dw_mipi_dsi_atomic_connector_funcs = {
 	.dpms = drm_atomic_helper_connector_dpms,
 	.fill_modes = drm_helper_probe_single_connector_modes,
 	.destroy = dw_mipi_dsi_drm_connector_destroy,
@@ -1113,7 +1112,7 @@ static struct drm_connector_funcs dw_mipi_dsi_atomic_connector_funcs = {
 };
 
 static int dw_mipi_dsi_register(struct drm_device *drm,
-				      struct dw_mipi_dsi *dsi)
+				struct dw_mipi_dsi *dsi)
 {
 	struct drm_encoder *encoder = &dsi->encoder;
 	struct drm_connector *connector = &dsi->connector;
@@ -1134,14 +1133,14 @@ static int dw_mipi_dsi_register(struct drm_device *drm,
 	drm_encoder_helper_add(&dsi->encoder,
 			       &dw_mipi_dsi_encoder_helper_funcs);
 	ret = drm_encoder_init(drm, &dsi->encoder, &dw_mipi_dsi_encoder_funcs,
-			 DRM_MODE_ENCODER_DSI, NULL);
+			       DRM_MODE_ENCODER_DSI, NULL);
 	if (ret) {
 		dev_err(dev, "Failed to initialize encoder with drm\n");
 		return ret;
 	}
 
 	drm_connector_helper_add(connector,
-			&dw_mipi_dsi_connector_helper_funcs);
+				 &dw_mipi_dsi_connector_helper_funcs);
 
 	drm_connector_init(drm, &dsi->connector,
 			   &dw_mipi_dsi_atomic_connector_funcs,
@@ -1216,7 +1215,7 @@ static const struct of_device_id dw_mipi_dsi_dt_ids[] = {
 MODULE_DEVICE_TABLE(of, dw_mipi_dsi_dt_ids);
 
 static int dw_mipi_dsi_bind(struct device *dev, struct device *master,
-			     void *data)
+			    void *data)
 {
 	const struct of_device_id *of_id =
 			of_match_device(dw_mipi_dsi_dt_ids, dev);
@@ -1331,7 +1330,7 @@ static int dw_mipi_dsi_bind(struct device *dev, struct device *master,
 }
 
 static void dw_mipi_dsi_unbind(struct device *dev, struct device *master,
-	void *data)
+			       void *data)
 {
 	struct dw_mipi_dsi *dsi = dev_get_drvdata(dev);
 
-- 
2.6.3
