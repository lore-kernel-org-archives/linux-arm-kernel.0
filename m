From: s-anna@ti.com (Suman Anna)
Date: Mon, 12 Feb 2018 19:32:35 -0600
Subject: [PATCH 1/9] dmaengine: omap-dma: include header for bool type
In-Reply-To: <20180213013243.8378-1-s-anna@ti.com>
References: <20180213013243.8378-1-s-anna@ti.com>
Message-ID: <20180213013243.8378-2-s-anna@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The omap-dmaengine.h header file uses a bool type, so include
the linux types.h header file so that it is self-contained.
The lack of this header caused some build errors while cleaning
up some header files from various omap_hwmod data files.

Signed-off-by: Suman Anna <s-anna@ti.com>
---
 include/linux/omap-dmaengine.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/omap-dmaengine.h b/include/linux/omap-dmaengine.h
index 8e6906c72e90..fc245bafb3ea 100644
--- a/include/linux/omap-dmaengine.h
+++ b/include/linux/omap-dmaengine.h
@@ -8,6 +8,8 @@
 #ifndef __LINUX_OMAP_DMAENGINE_H
 #define __LINUX_OMAP_DMAENGINE_H
 
+#include <linux/types.h>
+
 struct dma_chan;
 
 #if defined(CONFIG_DMA_OMAP) || (defined(CONFIG_DMA_OMAP_MODULE) && defined(MODULE))
-- 
2.15.1
