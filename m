From: linux@roeck-us.net (Guenter Roeck)
Date: Fri, 24 Apr 2015 12:24:36 -0700
Subject: [PATCH] [media] xilinx: Reflect dma header file move
Message-ID: <1429903476-24161-1-git-send-email-linux@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 937abe88aea3 ("dmaengine: xilinx-dma: move header file to common
location") moved xilinx_dma.h to a common location but neglected to reflect
this move in all its users.

This causes compile errors for several builds.

drivers/media/platform/xilinx/xilinx-dma.c:15:35:
	fatal error: linux/amba/xilinx_dma.h: No such file or directory

Cc: Kedareswara rao Appana <appana.durga.rao@xilinx.com>
Fixes: 937abe88aea3 ("dmaengine: xilinx-dma: move header file to common
	location")
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/media/platform/xilinx/xilinx-dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/xilinx/xilinx-dma.c b/drivers/media/platform/xilinx/xilinx-dma.c
index 10209c294168..efde88adf624 100644
--- a/drivers/media/platform/xilinx/xilinx-dma.c
+++ b/drivers/media/platform/xilinx/xilinx-dma.c
@@ -12,7 +12,7 @@
  * published by the Free Software Foundation.
  */
 
-#include <linux/amba/xilinx_dma.h>
+#include <linux/dma/xilinx_dma.h>
 #include <linux/lcm.h>
 #include <linux/list.h>
 #include <linux/module.h>
-- 
2.1.0
