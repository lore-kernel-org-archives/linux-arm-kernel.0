From: arvind.yadav.cs@gmail.com (Arvind Yadav)
Date: Thu, 24 Aug 2017 22:05:57 +0530
Subject: [PATCH 1/9] coresight: constify amba_id
In-Reply-To: <1503592565-21601-1-git-send-email-arvind.yadav.cs@gmail.com>
References: <1503592565-21601-1-git-send-email-arvind.yadav.cs@gmail.com>
Message-ID: <1503592565-21601-2-git-send-email-arvind.yadav.cs@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

amba_id are not supposed to change at runtime. All functions
working with const amba_id. So mark the non-const structs as const.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/hwtracing/coresight/coresight-cpu-debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight-cpu-debug.c b/drivers/hwtracing/coresight/coresight-cpu-debug.c
index 64a77e0..6ea62c6 100644
--- a/drivers/hwtracing/coresight/coresight-cpu-debug.c
+++ b/drivers/hwtracing/coresight/coresight-cpu-debug.c
@@ -667,7 +667,7 @@ static int debug_remove(struct amba_device *adev)
 	return 0;
 }
 
-static struct amba_id debug_ids[] = {
+static const struct amba_id debug_ids[] = {
 	{       /* Debug for Cortex-A53 */
 		.id	= 0x000bbd03,
 		.mask	= 0x000fffff,
-- 
2.7.4
