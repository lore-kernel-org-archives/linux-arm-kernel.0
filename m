From: hdegoede@redhat.com (Hans de Goede)
Date: Sat, 17 Sep 2016 12:08:10 +0200
Subject: [PATCH v2] musb: Export musb_root_disconnect for use in modules
Message-ID: <20160917100810.2406-1-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Export musb_root_disconnect for use in modules, so that musb glue
code build as module can use it.

This fixes the buildbot errors for -next in arm64-allmodconfig
and arm-allmodconfig.

Fixes: 7cba17ec9adc8cf ("musb: sunxi: Add support for platform_set_mode")
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
-Add Fixes tag and buildbot reference to the commit msg
---
 drivers/usb/musb/musb_virthub.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/musb/musb_virthub.c b/drivers/usb/musb/musb_virthub.c
index fe08e77..61b5f1c 100644
--- a/drivers/usb/musb/musb_virthub.c
+++ b/drivers/usb/musb/musb_virthub.c
@@ -245,6 +245,7 @@ void musb_root_disconnect(struct musb *musb)
 			usb_otg_state_string(musb->xceiv->otg->state));
 	}
 }
+EXPORT_SYMBOL_GPL(musb_root_disconnect);
 
 
 /*---------------------------------------------------------------------*/
-- 
2.9.3
