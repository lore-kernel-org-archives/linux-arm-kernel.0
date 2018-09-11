From: nicolas.ferre@microchip.com (Nicolas Ferre)
Date: Tue, 11 Sep 2018 10:44:48 +0200
Subject: [PATCH] mfd: at91-usart: fix missing mod_devicetable.h
In-Reply-To: <20180911125857.5e5c34f4@canb.auug.org.au>
References: <20180911125857.5e5c34f4@canb.auug.org.au>
Message-ID: <20180911084448.17878-1-nicolas.ferre@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Following the inclusion of the patch ac3167257b9f ("headers:
separate linux/mod_devicetable.h from linux/platform_device.h"), there is a
build issue:

drivers/mfd/at91-usart.c:51:34: error: array type has incomplete element type
'struct of_device_id'
  static const struct of_device_id at91_usart_mode_of_match[] = {

Before this patch, the definition was reached by its inclusion of
linux/mfd/core.h.

The build issue is solved by simply adding the mod_devicetable.h in this
driver.

Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
Cc: Radu Pirea <radu_nicolae.pirea@upb.ro>
---
 drivers/mfd/at91-usart.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mfd/at91-usart.c b/drivers/mfd/at91-usart.c
index a4b9929c156f..ad743b8ca6be 100644
--- a/drivers/mfd/at91-usart.c
+++ b/drivers/mfd/at91-usart.c
@@ -11,6 +11,7 @@
 #include <dt-bindings/mfd/at91-usart.h>
 
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/mfd/core.h>
 #include <linux/property.h>
 
-- 
2.15.1
