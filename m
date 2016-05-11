From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 11 May 2016 18:01:46 +0200
Subject: [PATCH 2/3] drm/omap: include linux/of.h where needed
In-Reply-To: <1462982509-342936-1-git-send-email-arnd@arndb.de>
References: <1462982509-342936-1-git-send-email-arnd@arndb.de>
Message-ID: <1462982509-342936-3-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some parts of the OMAP drm driver rely on implicit inclusion of
linux/of.h but fail in some configurations:

drivers/gpu/drm/omapdrm/dss/hdmi4.c: In function 'hdmi_probe_of':
drivers/gpu/drm/omapdrm/dss/hdmi4.c:564:2: error: implicit declaration of function 'of_node_put' [-Werror=implicit-function-declaration]
drivers/gpu/drm/omapdrm/dss/hdmi5.c: In function 'hdmi_probe_of':
drivers/gpu/drm/omapdrm/dss/hdmi5.c:590:2: error: implicit declaration of function 'of_node_put' [-Werror=implicit-function-declaration]

This adds an explicit #include statement to those files.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/omapdrm/dss/hdmi4.c | 1 +
 drivers/gpu/drm/omapdrm/dss/hdmi5.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/omapdrm/dss/hdmi4.c b/drivers/gpu/drm/omapdrm/dss/hdmi4.c
index f892ae157ff3..079bcfcbc8ef 100644
--- a/drivers/gpu/drm/omapdrm/dss/hdmi4.c
+++ b/drivers/gpu/drm/omapdrm/dss/hdmi4.c
@@ -25,6 +25,7 @@
 #include <linux/io.h>
 #include <linux/interrupt.h>
 #include <linux/mutex.h>
+#include <linux/of.h>
 #include <linux/delay.h>
 #include <linux/string.h>
 #include <linux/platform_device.h>
diff --git a/drivers/gpu/drm/omapdrm/dss/hdmi5.c b/drivers/gpu/drm/omapdrm/dss/hdmi5.c
index a43f7b10e113..68ac2491d4b1 100644
--- a/drivers/gpu/drm/omapdrm/dss/hdmi5.c
+++ b/drivers/gpu/drm/omapdrm/dss/hdmi5.c
@@ -31,6 +31,7 @@
 #include <linux/interrupt.h>
 #include <linux/mutex.h>
 #include <linux/delay.h>
+#include <linux/of.h>
 #include <linux/string.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
-- 
2.7.0
