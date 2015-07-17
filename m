From: jianwei.wang@freescale.com (Jianwei Wang)
Date: Fri, 17 Jul 2015 18:39:01 +0800
Subject: [PATCH v10 3/5] drm/panel: simple: Add support for NEC NL4827HC19-05B
 480x272 panel
In-Reply-To: <1437129543-8037-1-git-send-email-jianwei.wang@freescale.com>
References: <1437129543-8037-1-git-send-email-jianwei.wang@freescale.com>
Message-ID: <1437129543-8037-3-git-send-email-jianwei.wang@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jianwei Wang <jianwei.wang.chn@gmail.com>

This adds support for the NEC NL4827HC19-05B 480x272 panel to the DRM
simple panel driver.

Signed-off-by: Alison Wang <b18965@freescale.com>
Signed-off-by: Xiubo Li <lixiubo@cmss.chinamobile.com>
Signed-off-by: Jianwei Wang <jianwei.wang.chn@gmail.com>
Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
---
 .../bindings/panel/nec,nl4827hc19_05b.txt          |  7 ++++++
 MAINTAINERS                                        |  1 +
 drivers/gpu/drm/panel/panel-simple.c               | 26 ++++++++++++++++++++++
 3 files changed, 34 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/panel/nec,nl4827hc19_05b.txt

diff --git a/Documentation/devicetree/bindings/panel/nec,nl4827hc19_05b.txt b/Documentation/devicetree/bindings/panel/nec,nl4827hc19_05b.txt
new file mode 100644
index 0000000..20e9473
--- /dev/null
+++ b/Documentation/devicetree/bindings/panel/nec,nl4827hc19_05b.txt
@@ -0,0 +1,7 @@
+NEC LCD Technologies,Ltd. WQVGA TFT LCD panel
+
+Required properties:
+- compatible: should be "nec,nl4827hc19_05b"
+
+This binding is compatible with the simple-panel binding, which is specified
+in simple-panel.txt in this directory.
diff --git a/MAINTAINERS b/MAINTAINERS
index d4dfe14..387a84a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3404,6 +3404,7 @@ L:	dri-devel at lists.freedesktop.org
 S:	Supported
 F:	drivers/gpu/drm/fsl-dcu/
 F:	Documentation/devicetree/bindings/video/fsl,dcu.txt
+F:	Documentation/devicetree/bindings/panel/nec,nl4827hc19_05b.txt
 
 DRM DRIVERS FOR FREESCALE IMX
 M:	Philipp Zabel <p.zabel@pengutronix.de>
diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index f94201b..db61dd1 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -943,6 +943,29 @@ static const struct panel_desc lg_lp129qe = {
 	},
 };
 
+static const struct drm_display_mode nec_nl4827hc19_05b_mode = {
+	.clock = 10870,
+	.hdisplay = 480,
+	.hsync_start = 480 + 2,
+	.hsync_end = 480 + 2 + 41,
+	.htotal = 480 + 2 + 41 + 2,
+	.vdisplay = 272,
+	.vsync_start = 272 + 2,
+	.vsync_end = 272 + 2 + 4,
+	.vtotal = 272 + 2 + 4 + 2,
+	.vrefresh = 74,
+};
+
+static const struct panel_desc nec_nl4827hc19_05b = {
+	.modes = &nec_nl4827hc19_05b_mode,
+	.num_modes = 1,
+	.size = {
+		.width = 95,
+		.height = 54,
+	},
+	.bus_format = MEDIA_BUS_FMT_RGB888_1X24
+};
+
 static const struct drm_display_mode ortustech_com43h4m85ulc_mode  = {
 	.clock = 25000,
 	.hdisplay = 480,
@@ -1113,6 +1136,9 @@ static const struct of_device_id platform_of_match[] = {
 		.compatible = "lg,lp129qe",
 		.data = &lg_lp129qe,
 	}, {
+		.compatible = "nec,nl4827hc19_05b",
+		.data = &nec_nl4827hc19_05b,
+	}, {
 		.compatible = "ortustech,com43h4m85ulc",
 		.data = &ortustech_com43h4m85ulc,
 	}, {
-- 
2.1.0.27.g96db324
