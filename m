From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Wed, 09 Apr 2014 13:54:54 +0100
Subject: [PATCH 1/8] imx-drm: Move IPU_PIX_FMT_GBR24 definition into
 imx-ipu-v3.h
In-Reply-To: <20140409125354.GP16119@n2100.arm.linux.org.uk>
References: <20140409125354.GP16119@n2100.arm.linux.org.uk>
Message-ID: <E1WXs1m-0002ak-Ba@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Philipp Zabel <p.zabel@pengutronix.de>
To: linux-arm-kernel at lists.infradead.org

The IPU display controller supports a non-standard green-red-blue ordered
format that is used on the connection between IPU display interface 1 and
the TV encoder on i.MX53.
In preparation for the move of IPU core code out of staging, place the
IPU_PIX_FMT_GBR24 definition in imx-ipu-v3.h, so that both the IPU
display interface driver and the TVE encoder driver can access it.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/staging/imx-drm/imx-drm.h           | 4 ----
 drivers/staging/imx-drm/imx-tve.c           | 1 +
 drivers/staging/imx-drm/ipu-v3/imx-ipu-v3.h | 2 ++
 3 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/imx-drm/imx-drm.h b/drivers/staging/imx-drm/imx-drm.h
index a24d46ad3dce..a322bac55414 100644
--- a/drivers/staging/imx-drm/imx-drm.h
+++ b/drivers/staging/imx-drm/imx-drm.h
@@ -1,10 +1,6 @@
 #ifndef _IMX_DRM_H_
 #define _IMX_DRM_H_
 
-#include <linux/videodev2.h>
-
-#define IPU_PIX_FMT_GBR24	v4l2_fourcc('G', 'B', 'R', '3')
-
 struct device_node;
 struct drm_crtc;
 struct drm_connector;
diff --git a/drivers/staging/imx-drm/imx-tve.c b/drivers/staging/imx-drm/imx-tve.c
index 7002ae0a08ca..575533f4fd64 100644
--- a/drivers/staging/imx-drm/imx-tve.c
+++ b/drivers/staging/imx-drm/imx-tve.c
@@ -31,6 +31,7 @@
 #include <drm/drm_fb_helper.h>
 #include <drm/drm_crtc_helper.h>
 
+#include "ipu-v3/imx-ipu-v3.h"
 #include "imx-drm.h"
 
 #define TVE_COM_CONF_REG	0x00
diff --git a/drivers/staging/imx-drm/ipu-v3/imx-ipu-v3.h b/drivers/staging/imx-drm/ipu-v3/imx-ipu-v3.h
index 4826b5c0249d..c4d14ead5837 100644
--- a/drivers/staging/imx-drm/ipu-v3/imx-ipu-v3.h
+++ b/drivers/staging/imx-drm/ipu-v3/imx-ipu-v3.h
@@ -25,6 +25,8 @@ enum ipuv3_type {
 	IPUV3H,
 };
 
+#define IPU_PIX_FMT_GBR24	v4l2_fourcc('G', 'B', 'R', '3')
+
 /*
  * Bitfield of Display Interface signal polarities.
  */
-- 
1.8.3.1
