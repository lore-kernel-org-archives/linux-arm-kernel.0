From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Fri, 28 Sep 2012 09:24:26 +0300
Subject: [PATCH 1/6] OMAPDSS: remove unnecessary plat/clock.h includes
In-Reply-To: <20120927163329.21755.34776.stgit@dusk.lan>
References: <20120927162800.21755.62891.stgit@dusk.lan>
 <20120927163329.21755.34776.stgit@dusk.lan>
Message-ID: <1348813466.2437.1.camel@deskari>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2012-09-27 at 10:33 -0600, Paul Walmsley wrote:
> The OMAP DSS video drivers include <plat/clock.h> but don't use any
> information from that file.  These includes are causing problems with
> ARM single image kernels - remove them.
> 
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
> ---
>  drivers/video/omap2/dss/dispc.c |    1 -
>  drivers/video/omap2/dss/dsi.c   |    1 -
>  drivers/video/omap2/dss/dss.c   |    1 -
>  3 files changed, 3 deletions(-)

Hi Paul. I already have the below patch in omapdss branch, and it's also
in linux-next.

 Tomi


commit fe6a466283cf1ced93360bd5f5055d6543021a6a
Author: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date:   Thu Aug 30 10:52:47 2012 +0300

    OMAPDSS: remove unnecessary includes
    
    Remove unnecessary includes from omapdss.
    
    Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index 0de9a7e..e934abb 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -37,8 +37,6 @@
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 
-#include <plat/clock.h>
-
 #include <video/omapdss.h>
 
 #include "dss.h"
diff --git a/drivers/video/omap2/dss/dpi.c b/drivers/video/omap2/dss/dpi.c
index 25fb895..99b9851 100644
--- a/drivers/video/omap2/dss/dpi.c
+++ b/drivers/video/omap2/dss/dpi.c
@@ -31,7 +31,6 @@
 #include <linux/regulator/consumer.h>
 
 #include <video/omapdss.h>
-#include <plat/cpu.h>
 
 #include "dss.h"
 #include "dss_features.h"
diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index 254666f..8d815e3 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -41,7 +41,6 @@
 
 #include <video/omapdss.h>
 #include <video/mipi_display.h>
-#include <plat/clock.h>
 
 #include "dss.h"
 #include "dss_features.h"
diff --git a/drivers/video/omap2/dss/dss.c b/drivers/video/omap2/dss/dss.c
index 31a553a..759dbee 100644
--- a/drivers/video/omap2/dss/dss.c
+++ b/drivers/video/omap2/dss/dss.c
@@ -36,7 +36,6 @@
 #include <video/omapdss.h>
 
 #include <plat/cpu.h>
-#include <plat/clock.h>
 
 #include "dss.h"
 #include "dss_features.h"
diff --git a/drivers/video/omap2/dss/overlay.c b/drivers/video/omap2/dss/overlay.c
index 952c6fa..94e74be 100644
--- a/drivers/video/omap2/dss/overlay.c
+++ b/drivers/video/omap2/dss/overlay.c
@@ -32,7 +32,6 @@
 #include <linux/slab.h>
 
 #include <video/omapdss.h>
-#include <plat/cpu.h>
 
 #include "dss.h"
 #include "dss_features.h"
diff --git a/drivers/video/omap2/dss/venc.c b/drivers/video/omap2/dss/venc.c
index 4a6caf9..45252cf 100644
--- a/drivers/video/omap2/dss/venc.c
+++ b/drivers/video/omap2/dss/venc.c
@@ -36,7 +36,6 @@
 #include <linux/pm_runtime.h>
 
 #include <video/omapdss.h>
-#include <plat/cpu.h>
 
 #include "dss.h"
 #include "dss_features.h"

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120928/5c20fc3f/attachment-0001.sig>
