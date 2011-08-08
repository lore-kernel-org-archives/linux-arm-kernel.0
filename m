From: robherring2@gmail.com (Rob Herring)
Date: Mon,  8 Aug 2011 14:14:26 -0500
Subject: [PATCH] dmaengine: pl330: add missing include of scatterlist.h
Message-ID: <1312830866-2932-1-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

scatterlist.h was getting implicitly included and now is not which
causes this compile error:

drivers/dma/pl330.c: In function ?pl330_prep_slave_sg?:
drivers/dma/pl330.c:603:2: error: implicit declaration of function
?for_each_sg?

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
Cc: Jassi Brar <jassisinghbrar@gmail.com>
Cc: Vinod Koul <vkoul@infradead.org>
---
 drivers/dma/pl330.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
index 00eee59..4e2ccde 100644
--- a/drivers/dma/pl330.c
+++ b/drivers/dma/pl330.c
@@ -15,6 +15,7 @@
 #include <linux/module.h>
 #include <linux/dmaengine.h>
 #include <linux/interrupt.h>
+#include <linux/scatterlist.h>
 #include <linux/amba/bus.h>
 #include <linux/amba/pl330.h>
 
-- 
1.7.4.1
