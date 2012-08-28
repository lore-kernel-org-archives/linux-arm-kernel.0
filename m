From: richard.zhao@freescale.com (Richard Zhao)
Date: Tue, 28 Aug 2012 15:03:10 +0800
Subject: [PATCH v2 04/11] USB: chipidea: clear gadget struct at udc_start fail
 path
In-Reply-To: <1346137397-32374-1-git-send-email-richard.zhao@freescale.com>
References: <1346137397-32374-1-git-send-email-richard.zhao@freescale.com>
Message-ID: <1346137397-32374-5-git-send-email-richard.zhao@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

States in gadget are not needed any more, set it to zero.

Signed-off-by: Richard Zhao <richard.zhao@freescale.com>
---
 drivers/usb/chipidea/udc.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/chipidea/udc.c b/drivers/usb/chipidea/udc.c
index c7a032a..9fb6394 100644
--- a/drivers/usb/chipidea/udc.c
+++ b/drivers/usb/chipidea/udc.c
@@ -1746,6 +1746,7 @@ free_pools:
 	dma_pool_destroy(ci->td_pool);
 free_qh_pool:
 	dma_pool_destroy(ci->qh_pool);
+	memset(&ci->gadget, 0, sizeof(ci->gadget));
 	return retval;
 }
 
-- 
1.7.9.5
