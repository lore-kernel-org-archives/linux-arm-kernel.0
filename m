From: mathieu.poirier@linaro.org (mathieu.poirier at linaro.org)
Date: Fri,  9 Jan 2015 16:57:22 -0700
Subject: [PATCH 11/11] coresight: fixing validity check on remote device
In-Reply-To: <1420847842-31769-1-git-send-email-mathieu.poirier@linaro.org>
References: <1420847842-31769-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1420847842-31769-12-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kaixu Xia <xiakaixu@huawei.com>

A validity check should be made on the remote device, i.e rdev,
rather than the current device.

Signed-off-by: Kaixu Xia <xiakaixu@huawei.com>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/coresight/of_coresight.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/coresight/of_coresight.c b/drivers/coresight/of_coresight.c
index 89ebbe29ac97..9a5ff56f34d9 100644
--- a/drivers/coresight/of_coresight.c
+++ b/drivers/coresight/of_coresight.c
@@ -174,7 +174,7 @@ struct coresight_platform_data *of_get_coresight_platform_data(
 				continue;
 
 			rdev = of_coresight_get_endpoint_device(rparent);
-			if (!dev)
+			if (!rdev)
 				continue;
 
 			pdata->child_names[i] = dev_name(rdev);
-- 
1.9.1
