From: semen.protsenko@linaro.org (Semen Protsenko)
Date: Thu, 13 Feb 2014 18:39:54 +0200
Subject: [PATCH] mfd: vexpress-sysreg: initialize "site" variable
Message-ID: <1392309594-28229-1-git-send-email-semen.protsenko@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

"site" variable should be initialized with 0 so that
when "site" property doesn't exist in DTB it can be handled correctly.

"0" value means board site number is motherboard (see
Documentation/devicetree/bindings/arm/vexpress.txt for details).

Signed-off-by: Semen Protsenko <semen.protsenko@linaro.org>
---
 drivers/mfd/vexpress-sysreg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/vexpress-sysreg.c b/drivers/mfd/vexpress-sysreg.c
index 981bef4..35281e8 100644
--- a/drivers/mfd/vexpress-sysreg.c
+++ b/drivers/mfd/vexpress-sysreg.c
@@ -168,7 +168,7 @@ static void *vexpress_sysreg_config_func_get(struct device *dev,
 		struct device_node *node)
 {
 	struct vexpress_sysreg_config_func *config_func;
-	u32 site;
+	u32 site = 0;
 	u32 position = 0;
 	u32 dcc = 0;
 	u32 func_device[2];
-- 
1.8.5.3
