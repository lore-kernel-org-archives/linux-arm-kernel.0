From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Tue,  3 May 2016 11:33:35 -0600
Subject: [PATCH 01/27] coresight: no need to do the forced type conversion
In-Reply-To: <1462296841-12327-1-git-send-email-mathieu.poirier@linaro.org>
References: <1462296841-12327-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1462296841-12327-2-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: lipengcheng <lipengcheng8@huawei.com>

activated and enable are already unsigned type,
no need to change them to unsigned.

Signed-off-by: Li Pengcheng <lipengcheng8@huawei.com>
Signed-off-by: Li Zhong <lizhong11@hisilicon.com>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight.c b/drivers/hwtracing/coresight/coresight.c
index 2ea5961092c1..945bc31f0ec5 100644
--- a/drivers/hwtracing/coresight/coresight.c
+++ b/drivers/hwtracing/coresight/coresight.c
@@ -514,7 +514,7 @@ static ssize_t enable_sink_show(struct device *dev,
 {
 	struct coresight_device *csdev = to_coresight_device(dev);
 
-	return scnprintf(buf, PAGE_SIZE, "%u\n", (unsigned)csdev->activated);
+	return scnprintf(buf, PAGE_SIZE, "%u\n", csdev->activated);
 }
 
 static ssize_t enable_sink_store(struct device *dev,
@@ -544,7 +544,7 @@ static ssize_t enable_source_show(struct device *dev,
 {
 	struct coresight_device *csdev = to_coresight_device(dev);
 
-	return scnprintf(buf, PAGE_SIZE, "%u\n", (unsigned)csdev->enable);
+	return scnprintf(buf, PAGE_SIZE, "%u\n", csdev->enable);
 }
 
 static ssize_t enable_source_store(struct device *dev,
-- 
2.5.0
