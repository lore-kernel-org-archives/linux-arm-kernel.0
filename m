From: arvind.yadav.cs@gmail.com (Arvind Yadav)
Date: Thu, 24 Aug 2017 22:06:04 +0530
Subject: [PATCH 8/9] coresight: tmc: constify amba_id
In-Reply-To: <1503592565-21601-1-git-send-email-arvind.yadav.cs@gmail.com>
References: <1503592565-21601-1-git-send-email-arvind.yadav.cs@gmail.com>
Message-ID: <1503592565-21601-9-git-send-email-arvind.yadav.cs@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

amba_id are not supposed to change at runtime. All functions
working with const amba_id. So mark the non-const structs as const.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/hwtracing/coresight/coresight-tmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight-tmc.c b/drivers/hwtracing/coresight/coresight-tmc.c
index 8644887..142001c 100644
--- a/drivers/hwtracing/coresight/coresight-tmc.c
+++ b/drivers/hwtracing/coresight/coresight-tmc.c
@@ -391,7 +391,7 @@ static int tmc_probe(struct amba_device *adev, const struct amba_id *id)
 	return ret;
 }
 
-static struct amba_id tmc_ids[] = {
+static const struct amba_id tmc_ids[] = {
 	{
 		.id     = 0x0003b961,
 		.mask   = 0x0003ffff,
-- 
2.7.4
