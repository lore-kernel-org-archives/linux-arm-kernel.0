From: zhongjiang@huawei.com (zhong jiang)
Date: Sun, 16 Sep 2018 21:29:04 +0800
Subject: [PATCH] hwtracing: coresight: remove redundant null pointer check
 before of_node_put and put_device
Message-ID: <1537104544-64355-1-git-send-email-zhongjiang@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

of_node_put and put_device has taken the null pointer check into account.
So it is safe to remove the duplicated check.

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
 drivers/hwtracing/coresight/of_coresight.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/hwtracing/coresight/of_coresight.c b/drivers/hwtracing/coresight/of_coresight.c
index da71c97..89092f8 100644
--- a/drivers/hwtracing/coresight/of_coresight.c
+++ b/drivers/hwtracing/coresight/of_coresight.c
@@ -219,12 +219,9 @@ static int of_coresight_parse_endpoint(struct device *dev,
 		ret = 1;
 	} while (0);
 
-	if (rparent)
-		of_node_put(rparent);
-	if (rep)
-		of_node_put(rep);
-	if (rdev)
-		put_device(rdev);
+	of_node_put(rparent);
+	of_node_put(rep);
+	put_device(rdev);
 
 	return ret;
 }
-- 
1.7.12.4
