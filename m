From: arvind.yadav.cs@gmail.com (Arvind Yadav)
Date: Thu, 24 Aug 2017 22:06:03 +0530
Subject: [PATCH 7/9] coresight: stm: constify amba_id
In-Reply-To: <1503592565-21601-1-git-send-email-arvind.yadav.cs@gmail.com>
References: <1503592565-21601-1-git-send-email-arvind.yadav.cs@gmail.com>
Message-ID: <1503592565-21601-8-git-send-email-arvind.yadav.cs@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

amba_id are not supposed to change at runtime. All functions
working with const amba_id. So mark the non-const structs as const.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/hwtracing/coresight/coresight-stm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight-stm.c b/drivers/hwtracing/coresight/coresight-stm.c
index 93fc26f..903fe2a 100644
--- a/drivers/hwtracing/coresight/coresight-stm.c
+++ b/drivers/hwtracing/coresight/coresight-stm.c
@@ -914,7 +914,7 @@ static const struct dev_pm_ops stm_dev_pm_ops = {
 	SET_RUNTIME_PM_OPS(stm_runtime_suspend, stm_runtime_resume, NULL)
 };
 
-static struct amba_id stm_ids[] = {
+static const struct amba_id stm_ids[] = {
 	{
 		.id     = 0x0003b962,
 		.mask   = 0x0003ffff,
-- 
2.7.4
