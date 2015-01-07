From: oliver+list@schinagl.nl (Olliver Schinagl)
Date: Wed,  7 Jan 2015 08:41:08 +0100
Subject: [PATCH v1] ARM:sunxi:sid: Make use of the of_match_ptr
Message-ID: <1420616468-3782-1-git-send-email-oliver+list@schinagl.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Olliver Schinagl <oliver@schinagl.nl>

I probably have forgotten to use this macro for the of_match pointer, so
this patch adds the of_match_ptr macro.

Signed-off-by: Olliver Schinagl <oliver@schinagl.nl>
---
 drivers/misc/eeprom/sunxi_sid.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/eeprom/sunxi_sid.c b/drivers/misc/eeprom/sunxi_sid.c
index 8385177..5a330d9 100644
--- a/drivers/misc/eeprom/sunxi_sid.c
+++ b/drivers/misc/eeprom/sunxi_sid.c
@@ -25,6 +25,7 @@
 #include <linux/kernel.h>
 #include <linux/kobject.h>
 #include <linux/module.h>
+#include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/random.h>
@@ -146,7 +147,7 @@ static struct platform_driver sunxi_sid_driver = {
 	.remove = sunxi_sid_remove,
 	.driver = {
 		.name = DRV_NAME,
-		.of_match_table = sunxi_sid_of_match,
+		.of_match_table = of_match_ptr(sunxi_sid_of_match),
 	},
 };
 module_platform_driver(sunxi_sid_driver);
-- 
2.1.4
