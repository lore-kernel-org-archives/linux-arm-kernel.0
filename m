From: arvind.yadav.cs@gmail.com (Arvind Yadav)
Date: Thu, 24 Aug 2017 22:06:00 +0530
Subject: [PATCH 4/9] coresight: etm4x: constify amba_id
In-Reply-To: <1503592565-21601-1-git-send-email-arvind.yadav.cs@gmail.com>
References: <1503592565-21601-1-git-send-email-arvind.yadav.cs@gmail.com>
Message-ID: <1503592565-21601-5-git-send-email-arvind.yadav.cs@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

amba_id are not supposed to change at runtime. All functions
working with const amba_id. So mark the non-const structs as const.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/hwtracing/coresight/coresight-etm4x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x.c b/drivers/hwtracing/coresight/coresight-etm4x.c
index 532adc9..c466a2e 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x.c
@@ -1048,7 +1048,7 @@ static int etm4_probe(struct amba_device *adev, const struct amba_id *id)
 	return ret;
 }
 
-static struct amba_id etm4_ids[] = {
+static const struct amba_id etm4_ids[] = {
 	{       /* ETM 4.0 - Cortex-A53  */
 		.id	= 0x000bb95d,
 		.mask	= 0x000fffff,
-- 
2.7.4
