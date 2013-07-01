From: broonie@kernel.org (Mark Brown)
Date: Mon,  1 Jul 2013 13:55:55 +0100
Subject: [PATCH] drm/exynos: Add missing includes
Message-ID: <1372683355-27460-1-git-send-email-broonie@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mark Brown <broonie@linaro.org>

Ensure that all externally accessed functions are correctly prototyped
when defined in each file by making sure the headers with the protoypes
are included in the file with the definition.

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 drivers/gpu/drm/exynos/exynos_drm_connector.c | 1 +
 drivers/gpu/drm/exynos/exynos_drm_crtc.c      | 1 +
 drivers/gpu/drm/exynos/exynos_drm_dmabuf.c    | 1 +
 drivers/gpu/drm/exynos/exynos_drm_fbdev.c     | 1 +
 drivers/gpu/drm/exynos/exynos_drm_fimc.c      | 1 +
 drivers/gpu/drm/exynos/exynos_drm_g2d.c       | 1 +
 drivers/gpu/drm/exynos/exynos_drm_gsc.c       | 1 +
 drivers/gpu/drm/exynos/exynos_drm_plane.c     | 1 +
 drivers/gpu/drm/exynos/exynos_drm_rotator.c   | 1 +
 drivers/gpu/drm/exynos/exynos_drm_vidi.c      | 1 +
 10 files changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_connector.c b/drivers/gpu/drm/exynos/exynos_drm_connector.c
index 8bcc13a..ec80293 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_connector.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_connector.c
@@ -17,6 +17,7 @@
 #include <drm/exynos_drm.h>
 #include "exynos_drm_drv.h"
 #include "exynos_drm_encoder.h"
+#include "exynos_drm_connector.h"
 
 #define to_exynos_connector(x)	container_of(x, struct exynos_drm_connector,\
 				drm_connector)
diff --git a/drivers/gpu/drm/exynos/exynos_drm_crtc.c b/drivers/gpu/drm/exynos/exynos_drm_crtc.c
index 073c10a..6933ee9 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_crtc.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_crtc.c
@@ -15,6 +15,7 @@
 #include <drm/drmP.h>
 #include <drm/drm_crtc_helper.h>
 
+#include "exynos_drm_crtc.h"
 #include "exynos_drm_drv.h"
 #include "exynos_drm_encoder.h"
 #include "exynos_drm_plane.h"
diff --git a/drivers/gpu/drm/exynos/exynos_drm_dmabuf.c b/drivers/gpu/drm/exynos/exynos_drm_dmabuf.c
index ff7f2a8..8adafde 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_dmabuf.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_dmabuf.c
@@ -11,6 +11,7 @@
 
 #include <drm/drmP.h>
 #include <drm/exynos_drm.h>
+#include "exynos_drm_dmabuf.h"
 #include "exynos_drm_drv.h"
 #include "exynos_drm_gem.h"
 
diff --git a/drivers/gpu/drm/exynos/exynos_drm_fbdev.c b/drivers/gpu/drm/exynos/exynos_drm_fbdev.c
index 8f007aa..45b6cb3 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_fbdev.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_fbdev.c
@@ -19,6 +19,7 @@
 
 #include "exynos_drm_drv.h"
 #include "exynos_drm_fb.h"
+#include "exynos_drm_fbdev.h"
 #include "exynos_drm_gem.h"
 #include "exynos_drm_iommu.h"
 
diff --git a/drivers/gpu/drm/exynos/exynos_drm_fimc.c b/drivers/gpu/drm/exynos/exynos_drm_fimc.c
index 4a1616a..a83e664 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_fimc.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_fimc.c
@@ -22,6 +22,7 @@
 #include <drm/drmP.h>
 #include <drm/exynos_drm.h>
 #include "regs-fimc.h"
+#include "exynos_drm_drv.h"
 #include "exynos_drm_ipp.h"
 #include "exynos_drm_fimc.h"
 
diff --git a/drivers/gpu/drm/exynos/exynos_drm_g2d.c b/drivers/gpu/drm/exynos/exynos_drm_g2d.c
index af75434..03ba897 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_g2d.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_g2d.c
@@ -24,6 +24,7 @@
 #include <drm/drmP.h>
 #include <drm/exynos_drm.h>
 #include "exynos_drm_drv.h"
+#include "exynos_drm_g2d.h"
 #include "exynos_drm_gem.h"
 #include "exynos_drm_iommu.h"
 
diff --git a/drivers/gpu/drm/exynos/exynos_drm_gsc.c b/drivers/gpu/drm/exynos/exynos_drm_gsc.c
index 762f40d..4683251 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_gsc.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_gsc.c
@@ -21,6 +21,7 @@
 #include <drm/drmP.h>
 #include <drm/exynos_drm.h>
 #include "regs-gsc.h"
+#include "exynos_drm_drv.h"
 #include "exynos_drm_ipp.h"
 #include "exynos_drm_gsc.h"
 
diff --git a/drivers/gpu/drm/exynos/exynos_drm_plane.c b/drivers/gpu/drm/exynos/exynos_drm_plane.c
index 83efc66..63ebeeb 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_plane.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_plane.c
@@ -16,6 +16,7 @@
 #include "exynos_drm_encoder.h"
 #include "exynos_drm_fb.h"
 #include "exynos_drm_gem.h"
+#include "exynos_drm_plane.h"
 
 #define to_exynos_plane(x)	container_of(x, struct exynos_plane, base)
 
diff --git a/drivers/gpu/drm/exynos/exynos_drm_rotator.c b/drivers/gpu/drm/exynos/exynos_drm_rotator.c
index 9b6c709..2e9eee2 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_rotator.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_rotator.c
@@ -22,6 +22,7 @@
 #include <drm/exynos_drm.h>
 #include "regs-rotator.h"
 #include "exynos_drm.h"
+#include "exynos_drm_drv.h"
 #include "exynos_drm_ipp.h"
 
 /*
diff --git a/drivers/gpu/drm/exynos/exynos_drm_vidi.c b/drivers/gpu/drm/exynos/exynos_drm_vidi.c
index 24376c1..498647a 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_vidi.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_vidi.c
@@ -24,6 +24,7 @@
 #include "exynos_drm_drv.h"
 #include "exynos_drm_crtc.h"
 #include "exynos_drm_encoder.h"
+#include "exynos_drm_vidi.h"
 
 /* vidi has totally three virtual windows. */
 #define WINDOWS_NR		3
-- 
1.8.3.1
