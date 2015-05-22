From: ykk@rock-chips.com (Yakir Yang)
Date: Fri, 22 May 2015 10:14:44 -0500
Subject: [RESEND PATCH v1 1/2] drm: bridge/dw_hdmi: rename dw_hdmi-ahb-audio.h
 to dw_hdmi-audio.h
In-Reply-To: <1432307631-7667-1-git-send-email-ykk@rock-chips.com>
References: <1432307631-7667-1-git-send-email-ykk@rock-chips.com>
Message-ID: <1432307684-7757-1-git-send-email-ykk@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

First step to make ahb audio driver and i2s audio driver code exist,
share the audio data struct in dw_hdmi-audio.h

Signed-off-by: Yakir Yang <ykk@rock-chips.com>
---
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
index dc0aed1..7b70619 100644
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
