From: paul@pwsan.com (Paul Walmsley)
Date: Thu, 27 Sep 2012 10:33:31 -0600
Subject: [PATCH 2/6] staging: tidspbridge: remove unnecessary include of
 <plat/clock.h>
In-Reply-To: <20120927162800.21755.62891.stgit@dusk.lan>
References: <20120927162800.21755.62891.stgit@dusk.lan>
Message-ID: <20120927163330.21755.54156.stgit@dusk.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The DSPBridge driver includes arch/arm/plat-omap/include/plat/clock.h.
All of the <plat/ ...> includes are causing problems with the ARM
single image kernel effort.  Remove this one.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 .../tidspbridge/include/dspbridge/host_os.h        |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/tidspbridge/include/dspbridge/host_os.h b/drivers/staging/tidspbridge/include/dspbridge/host_os.h
index ed00d3d..896f157 100644
--- a/drivers/staging/tidspbridge/include/dspbridge/host_os.h
+++ b/drivers/staging/tidspbridge/include/dspbridge/host_os.h
@@ -40,7 +40,6 @@
 #include <linux/vmalloc.h>
 #include <linux/ioport.h>
 #include <linux/platform_device.h>
-#include <plat/clock.h>
 #include <linux/clk.h>
 #include <plat/mailbox.h>
 #include <linux/pagemap.h>
