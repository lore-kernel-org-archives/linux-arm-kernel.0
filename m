From: zhaoxiu.zeng@gmail.com (Zhaoxiu Zeng)
Date: Sun,  6 Dec 2015 18:11:45 +0800
Subject: [PATCH 02/10] brcmstb_gisb: Replace "hweight_long(mask) != 1" with
 "!is_power_of_2(mask)"
Message-ID: <1449396705-14235-1-git-send-email-zhaoxiu.zeng@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Zeng Zhaoxiu <zhaoxiu.zeng@gmail.com>

Signed-off-by: Zeng Zhaoxiu <zhaoxiu.zeng@gmail.com>
---
 drivers/bus/brcmstb_gisb.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/bus/brcmstb_gisb.c b/drivers/bus/brcmstb_gisb.c
index f364fa4..2816a04 100644
--- a/drivers/bus/brcmstb_gisb.c
+++ b/drivers/bus/brcmstb_gisb.c
@@ -24,6 +24,7 @@
 #include <linux/of.h>
 #include <linux/bitops.h>
 #include <linux/pm.h>
+#include <linux/log2.h>
 
 #ifdef CONFIG_ARM
 #include <asm/bug.h>
@@ -171,7 +172,7 @@ brcmstb_gisb_master_to_str(struct brcmstb_gisb_arb_device *gdev,
 {
 	u32 mask = gdev->valid_mask & masters;
 
-	if (hweight_long(mask) != 1)
+	if (!is_power_of_2(mask))
 		return NULL;
 
 	return gdev->master_names[ffs(mask) - 1];
-- 
2.5.0
