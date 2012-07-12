From: richard.zhao@freescale.com (Richard Zhao)
Date: Thu, 12 Jul 2012 15:01:44 +0800
Subject: [PATCH 04/12] USB: chipidea: clear gadget struct at udc_start fail
 path
In-Reply-To: <1342076512-19207-1-git-send-email-richard.zhao@freescale.com>
References: <1342076512-19207-1-git-send-email-richard.zhao@freescale.com>
Message-ID: <1342076512-19207-5-git-send-email-richard.zhao@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

States in gadget are not needed any more, set it to zero.

Signed-off-by: Richard Zhao <richard.zhao@freescale.com>
---
 drivers/usb/chipidea/udc.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/chipidea/udc.c b/drivers/usb/chipidea/udc.c
index 9029985..fd27f4d 100644
--- a/drivers/usb/chipidea/udc.c
+++ b/drivers/usb/chipidea/udc.c
@@ -1759,6 +1759,7 @@ free_pools:
 	dma_pool_destroy(ci->td_pool);
 free_qh_pool:
 	dma_pool_destroy(ci->qh_pool);
+	memset(&ci->gadget, 0, sizeof(ci->gadget));
 	return retval;
 }
 
-- 
1.7.9.5
