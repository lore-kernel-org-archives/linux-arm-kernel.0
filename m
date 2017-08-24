From: arvind.yadav.cs@gmail.com (Arvind Yadav)
Date: Thu, 24 Aug 2017 22:05:59 +0530
Subject: [PATCH 3/9] coresight: etm3x: constify amba_id
In-Reply-To: <1503592565-21601-1-git-send-email-arvind.yadav.cs@gmail.com>
References: <1503592565-21601-1-git-send-email-arvind.yadav.cs@gmail.com>
Message-ID: <1503592565-21601-4-git-send-email-arvind.yadav.cs@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

amba_id are not supposed to change at runtime. All functions
working with const amba_id. So mark the non-const structs as const.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/hwtracing/coresight/coresight-etm3x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm3x.c b/drivers/hwtracing/coresight/coresight-etm3x.c
index 93ee8fc..29b4e47 100644
--- a/drivers/hwtracing/coresight/coresight-etm3x.c
+++ b/drivers/hwtracing/coresight/coresight-etm3x.c
@@ -885,7 +885,7 @@ static const struct dev_pm_ops etm_dev_pm_ops = {
 	SET_RUNTIME_PM_OPS(etm_runtime_suspend, etm_runtime_resume, NULL)
 };
 
-static struct amba_id etm_ids[] = {
+static const struct amba_id etm_ids[] = {
 	{	/* ETM 3.3 */
 		.id	= 0x0003b921,
 		.mask	= 0x0003ffff,
-- 
2.7.4
