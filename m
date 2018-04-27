From: jan.tuerk@emtrion.com (jan.tuerk at emtrion.com)
Date: Fri, 27 Apr 2018 15:24:37 +0200
Subject: [PATCH v4 2/7] drm/panel: Add support for the EDT ETM0700G0BDH6
In-Reply-To: <20180427132445.3458-1-jan.tuerk@emtrion.com>
References: <20180420125108.14197-1-jan.tuerk@emtrion.com>
 <20180427132445.3458-1-jan.tuerk@emtrion.com>
Message-ID: <20180427132445.3458-3-jan.tuerk@emtrion.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jan Tuerk <jan.tuerk@emtrion.com>

The Emerging Display Technology ETM0700G0BDH6 is exactly
the same display as the ETM0700G0DH6, exept the pixelclock
polarity. Therefore re-use the ETM0700G0DH6 modes. It is
used by default on emtrion Avari based development kits.

Signed-off-by: Jan Tuerk <jan.tuerk@emtrion.com>
---
Changes for v4:
  - re-arrange the Patch-series to match the DT-submitting-patches
  - Additional patch for the Documentation of the new DT-bindings
  - no change (re-arranged 1/6 => 2/7)

 drivers/gpu/drm/panel/panel-simple.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index cbf1ab404ee7..8b7feb2888f2 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -909,6 +909,18 @@ static const struct panel_desc edt_etm0700g0dh6 = {
 	.bus_flags = DRM_BUS_FLAG_DE_HIGH | DRM_BUS_FLAG_PIXDATA_NEGEDGE,
 };
 
+static const struct panel_desc edt_etm0700g0bdh6 = {
+	.modes = &edt_etm0700g0dh6_mode,
+	.num_modes = 1,
+	.bpc = 6,
+	.size = {
+		.width = 152,
+		.height = 91,
+	},
+	.bus_format = MEDIA_BUS_FMT_RGB666_1X18,
+	.bus_flags = DRM_BUS_FLAG_DE_HIGH | DRM_BUS_FLAG_PIXDATA_POSEDGE,
+};
+
 static const struct drm_display_mode foxlink_fl500wvr00_a0t_mode = {
 	.clock = 32260,
 	.hdisplay = 800,
@@ -2134,6 +2146,9 @@ static const struct of_device_id platform_of_match[] = {
 		.compatible = "edt,etm0700g0dh6",
 		.data = &edt_etm0700g0dh6,
 	}, {
+		.compatible = "edt,etm0700g0bdh6",
+		.data = &edt_etm0700g0bdh6,
+	}, {
 		.compatible = "foxlink,fl500wvr00-a0t",
 		.data = &foxlink_fl500wvr00_a0t,
 	}, {
-- 
2.11.0
