From: pavel@ucw.cz (Pavel Machek)
Date: Mon, 26 Feb 2018 14:00:07 +0100
Subject: v4.16-rc0: missing includes in framebuffers break N900 compilation
Message-ID: <20180226130007.GA5634@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I needed this to get -rc0 to compile.

Signed-off-by: Pavel Machek <pavel@ucw.cz>


diff --git a/drivers/video/fbdev/omap2/omapfb/dss/dss.c b/drivers/video/fbdev/omap2/omapfb/dss/dss.c
index 48c6500..990f1c9 100644
--- a/drivers/video/fbdev/omap2/omapfb/dss/dss.c
+++ b/drivers/video/fbdev/omap2/omapfb/dss/dss.c
@@ -38,6 +38,7 @@
 #include <linux/regmap.h>
 #include <linux/of.h>
 #include <linux/regulator/consumer.h>
+#include <linux/pinctrl/consumer.h>
 #include <linux/suspend.h>
 #include <linux/component.h>
 
diff --git a/drivers/video/fbdev/omap2/omapfb/dss/hdmi_phy.c b/drivers/video/fbdev/omap2/omapfb/dss/hdmi_phy.c
index 9a13c35..4862b12 100644
--- a/drivers/video/fbdev/omap2/omapfb/dss/hdmi_phy.c
+++ b/drivers/video/fbdev/omap2/omapfb/dss/hdmi_phy.c
@@ -12,6 +12,7 @@
 #include <linux/err.h>
 #include <linux/io.h>
 #include <linux/platform_device.h>
+#include <linux/seq_file.h>
 #include <linux/slab.h>
 #include <video/omapfb_dss.h>
 
diff --git a/drivers/video/fbdev/omap2/omapfb/dss/hdmi_pll.c b/drivers/video/fbdev/omap2/omapfb/dss/hdmi_pll.c
index eac3665..39014e2 100644
--- a/drivers/video/fbdev/omap2/omapfb/dss/hdmi_pll.c
+++ b/drivers/video/fbdev/omap2/omapfb/dss/hdmi_pll.c
@@ -15,6 +15,7 @@
 #include <linux/err.h>
 #include <linux/io.h>
 #include <linux/platform_device.h>
+#include <linux/seq_file.h>
 #include <linux/clk.h>
 
 #include <video/omapfb_dss.h>
diff --git a/drivers/video/fbdev/omap2/omapfb/dss/hdmi_wp.c b/drivers/video/fbdev/omap2/omapfb/dss/hdmi_wp.c
index 705373e..e93e7a7 100644
--- a/drivers/video/fbdev/omap2/omapfb/dss/hdmi_wp.c
+++ b/drivers/video/fbdev/omap2/omapfb/dss/hdmi_wp.c
@@ -15,6 +15,7 @@
 #include <linux/io.h>
 #include <linux/platform_device.h>
 #include <video/omapfb_dss.h>
+#include <linux/seq_file.h>
 
 #include "dss.h"
 #include "hdmi.h"

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180226/76cf8121/attachment.sig>
