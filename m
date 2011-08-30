From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 30 Aug 2011 17:05:31 -0400 (EDT)
Subject: [PATCH] musb_debugfs.c: remove unneeded includes on ARM
Message-ID: <alpine.LFD.2.00.1108301659540.20358@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Nothing actually requires that <mach/hardware.h>, <mach/memory.h> nor
<asm/mach-types.h> be included here.

Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>

---

I'd need appropriate ACK's as this is part of a cleanup series actually 
removing <mach/memory.h>.  If those includes are not useless as I think 
they are, an alternative solution will need to be found.
Thanks.

diff --git a/drivers/usb/musb/musb_debugfs.c b/drivers/usb/musb/musb_debugfs.c
index b0176e4..61f4ee4 100644
--- a/drivers/usb/musb/musb_debugfs.c
+++ b/drivers/usb/musb/musb_debugfs.c
@@ -41,12 +41,6 @@
 #include <linux/debugfs.h>
 #include <linux/seq_file.h>
 
-#ifdef	CONFIG_ARM
-#include <mach/hardware.h>
-#include <mach/memory.h>
-#include <asm/mach-types.h>
-#endif
-
 #include <asm/uaccess.h>
 
 #include "musb_core.h"
