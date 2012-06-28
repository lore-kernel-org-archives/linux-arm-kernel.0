From: zonque@gmail.com (Daniel Mack)
Date: Thu, 28 Jun 2012 18:12:32 +0200
Subject: [PATCH] davinci_cpdma: include linux/module.h
Message-ID: <1340899952-15201-1-git-send-email-zonque@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This fixes a number of warnings such as:

  CC      drivers/net/ethernet/ti/davinci_cpdma.o
drivers/net/ethernet/ti/davinci_cpdma.c:279:1: warning: data definition
has no type or storage class
drivers/net/ethernet/ti/davinci_cpdma.c:279:1: warning: type defaults to
?int? in declaration of ?EXPORT_SYMBOL_GPL?
drivers/net/ethernet/ti/davinci_cpdma.c:279:1: warning: parameter names
(without types) in function declaration

Signed-off-by: Daniel Mack <zonque@gmail.com>
Cc: Vaibhav Hiremath <hvaibhav@ti.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: Christian Riesch <christian.riesch@omicron.at>
---
 drivers/net/ethernet/ti/davinci_cpdma.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/ti/davinci_cpdma.c b/drivers/net/ethernet/ti/davinci_cpdma.c
index d614c37..3b5c457 100644
--- a/drivers/net/ethernet/ti/davinci_cpdma.c
+++ b/drivers/net/ethernet/ti/davinci_cpdma.c
@@ -15,6 +15,7 @@
 #include <linux/kernel.h>
 #include <linux/spinlock.h>
 #include <linux/device.h>
+#include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/err.h>
 #include <linux/dma-mapping.h>
-- 
1.7.10.4
