From: jan.tuerk@emtrion.com (jan.tuerk at emtrion.com)
Date: Wed, 20 Dec 2017 14:47:01 +0100
Subject: [PATCH v2 1/5] drm/panel: Add support for the EDT ETM0700G0BDH6
In-Reply-To: <20171220134710.64479-1-jan.tuerk@emtrion.com>
References: <20171123125600.41562-1-jan.tuerk@emtrion.com>
 <20171220134710.64479-1-jan.tuerk@emtrion.com>
Message-ID: <20171220134710.64479-2-jan.tuerk@emtrion.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jan Tuerk <jan.tuerk@emtrion.com>

The Emerging Display Technology ETM0700G0BDH6 is exactly
the same display as the ETM0700G0DH6, exept the pixelclock
polarity. Therefore re-use the ETM0700G0DH6 modes. It is
used by default on emtrion Avari based development kits.

Signed-off-by: Jan Tuerk <jan.tuerk@emtrion.com>
---
 .../bindings/display/panel/edt,etm0700g0bdh6.txt          |  9 +++++++++
 drivers/gpu/drm/panel/panel-simple.c                      | 15 +++++++++++++++
 2 files changed, 24 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/edt,etm0700g0bdh6.txt

diff --git a/Documentation/devicetree/bindings/display/panel/edt,etm0700g0bdh6.txt b/Documentation/devicetree/bindings/display/panel/edt,etm0700g0bdh6.txt
new file mode 100644
index 000000000000..099e30bfa17f
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/edt,etm0700g0bdh6.txt
@@ -0,0 +1,9 @@
+Emerging Display Technology Corp. ETM0700G0BDH6 7.0" WVGA TFT LCD panel
+
+Required properties:
+	compatible: "edt,etm0700g0bdh6"
+
+This panel is exactly the same as ETM0700G0DH6 except the pixelclock polarity.
+
+This binding is compatible with the simple-panel binding, which is specified
+in simple-panel.txt in this directory.
diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index b7c4709f7b34..42442034b53e 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -886,6 +886,18 @@ static const struct panel_desc edt_etm0700g0dh6 = {
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
@@ -2029,6 +2041,9 @@ static const struct of_device_id platform_of_match[] = {
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
emtrion GmbH
Alter Schlachthof 45
76131 Karlsruhe
GERMANY
https://www.emtrion.de

Amtsgericht Mannheim
HRB 110 300
Gesch?ftsf?hrer: Dieter Baur, Ramona Maurer
