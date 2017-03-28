From: yannick.fertre@st.com (Yannick Fertre)
Date: Tue, 28 Mar 2017 11:44:49 +0200
Subject: [PATCH v5 06/10] drm/panel: simple: Add support for Ampire
 AM-480272H3TMQW-T01H
In-Reply-To: <1490694293-18358-1-git-send-email-yannick.fertre@st.com>
References: <1490694293-18358-1-git-send-email-yannick.fertre@st.com>
Message-ID: <1490694293-18358-7-git-send-email-yannick.fertre@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add simple-panel support for the Ampire AM-480272H3TMQW-T01H,
which is a 4.3" WQVGA panel.

Signed-off-by: Yannick Fertre <yannick.fertre@st.com>
---
 drivers/gpu/drm/panel/panel-simple.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index 89eb042..7818755 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -386,6 +386,32 @@ static void panel_simple_shutdown(struct device *dev)
 	panel_simple_disable(&panel->base);
 }
 
+static const struct drm_display_mode ampire_am_480272h3tmqw_t01h_mode = {
+	.clock = 9000,
+	.hdisplay = 480,
+	.hsync_start = 480 + 2,
+	.hsync_end = 480 + 2 + 41,
+	.htotal = 480 + 2 + 41 + 2,
+	.vdisplay = 272,
+	.vsync_start = 272 + 2,
+	.vsync_end = 272 + 2 + 10,
+	.vtotal = 272 + 2 + 10 + 2,
+	.vrefresh = 60,
+	.flags = DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC,
+};
+
+static const struct panel_desc ampire_am_480272h3tmqw_t01h = {
+	.modes = &ampire_am_480272h3tmqw_t01h_mode,
+	.num_modes = 1,
+	.bpc = 8,
+
+	.size = {
+		.width = 105,
+		.height = 67,
+	},
+	.bus_format = MEDIA_BUS_FMT_RGB888_1X24,
+};
+
 static const struct drm_display_mode ampire_am800480r3tmqwa1h_mode = {
 	.clock = 33333,
 	.hdisplay = 800,
@@ -1808,6 +1834,9 @@ static void panel_simple_shutdown(struct device *dev)
 
 static const struct of_device_id platform_of_match[] = {
 	{
+		.compatible = "ampire,am-480272h3tmqw-t01h",
+		.data = &ampire_am_480272h3tmqw_t01h,
+	}, {
 		.compatible = "ampire,am800480r3tmqwa1h",
 		.data = &ampire_am800480r3tmqwa1h,
 	}, {
-- 
1.9.1
