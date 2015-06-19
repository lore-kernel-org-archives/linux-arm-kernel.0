From: ykk@rock-chips.com (Yakir Yang)
Date: Sat, 20 Jun 2015 00:24:20 +0800
Subject: [PATCH v5 3/6] drm: bridge/dw_hdmi: rename dw_hdmi-ahb-audio.h to
 dw_hdmi-audio.h
In-Reply-To: <1434730417-10629-1-git-send-email-ykk@rock-chips.com>
References: <1434730417-10629-1-git-send-email-ykk@rock-chips.com>
Message-ID: <1434731060-10929-1-git-send-email-ykk@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

First step to make ahb audio driver and i2s audio driver code exist,
share the audio data struct in dw_hdmi-audio.h

Signed-off-by: Yakir Yang <ykk@rock-chips.com>
---
Changes in v5: None
Changes in v4: None
Changes in v3: None
Changes in v2: None

 drivers/gpu/drm/bridge/dw_hdmi-ahb-audio.c                      | 2 +-
 drivers/gpu/drm/bridge/{dw_hdmi-ahb-audio.h => dw_hdmi-audio.h} | 0
 drivers/gpu/drm/bridge/dw_hdmi.c                                | 2 +-
 3 files changed, 2 insertions(+), 2 deletions(-)
 rename drivers/gpu/drm/bridge/{dw_hdmi-ahb-audio.h => dw_hdmi-audio.h} (100%)

diff --git a/drivers/gpu/drm/bridge/dw_hdmi-ahb-audio.c b/drivers/gpu/drm/bridge/dw_hdmi-ahb-audio.c
index 2bb68bd..0a270ea 100644
--- a/drivers/gpu/drm/bridge/dw_hdmi-ahb-audio.c
+++ b/drivers/gpu/drm/bridge/dw_hdmi-ahb-audio.c
@@ -21,7 +21,7 @@
 #include <sound/pcm_drm_eld.h>
 #include <sound/pcm_iec958.h>
 
-#include "dw_hdmi-ahb-audio.h"
+#include "dw_hdmi-audio.h"
 
 #define DRIVER_NAME "dw-hdmi-ahb-audio"
 
diff --git a/drivers/gpu/drm/bridge/dw_hdmi-ahb-audio.h b/drivers/gpu/drm/bridge/dw_hdmi-audio.h
similarity index 100%
rename from drivers/gpu/drm/bridge/dw_hdmi-ahb-audio.h
rename to drivers/gpu/drm/bridge/dw_hdmi-audio.h
diff --git a/drivers/gpu/drm/bridge/dw_hdmi.c b/drivers/gpu/drm/bridge/dw_hdmi.c
index 417cc82..cbb55ae 100644
--- a/drivers/gpu/drm/bridge/dw_hdmi.c
+++ b/drivers/gpu/drm/bridge/dw_hdmi.c
@@ -28,7 +28,7 @@
 #include <drm/bridge/dw_hdmi.h>
 
 #include "dw_hdmi.h"
-#include "dw_hdmi-ahb-audio.h"
+#include "dw_hdmi-audio.h"
 
 #define HDMI_EDID_LEN		512
 
-- 
2.1.2
