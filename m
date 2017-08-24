From: arvind.yadav.cs@gmail.com (Arvind Yadav)
Date: Thu, 24 Aug 2017 22:06:02 +0530
Subject: [PATCH 6/9] coresight: replicator: constify amba_id
In-Reply-To: <1503592565-21601-1-git-send-email-arvind.yadav.cs@gmail.com>
References: <1503592565-21601-1-git-send-email-arvind.yadav.cs@gmail.com>
Message-ID: <1503592565-21601-7-git-send-email-arvind.yadav.cs@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

amba_id are not supposed to change at runtime. All functions
working with const amba_id. So mark the non-const structs as const.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/hwtracing/coresight/coresight-replicator-qcom.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight-replicator-qcom.c b/drivers/hwtracing/coresight/coresight-replicator-qcom.c
index 0a3d15f..e1ab121 100644
--- a/drivers/hwtracing/coresight/coresight-replicator-qcom.c
+++ b/drivers/hwtracing/coresight/coresight-replicator-qcom.c
@@ -175,7 +175,7 @@ static const struct dev_pm_ops replicator_dev_pm_ops = {
 			   NULL)
 };
 
-static struct amba_id replicator_ids[] = {
+static const struct amba_id replicator_ids[] = {
 	{
 		.id     = 0x0003b909,
 		.mask   = 0x0003ffff,
-- 
2.7.4
