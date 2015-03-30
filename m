From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Mon, 30 Mar 2015 14:13:38 -0600
Subject: [PATCH 5/8] coresight: adding the LINKSINK block as a sink type
In-Reply-To: <1427746421-31360-1-git-send-email-mathieu.poirier@linaro.org>
References: <1427746421-31360-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1427746421-31360-6-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Xia Kaixu <kaixu.xia@linaro.org>

>From the TMC TRM, the ETF can be configured as buffer mode, so ETF can
be a sink type.

Signed-off-by: Xia Kaixu <kaixu.xia@linaro.org>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/coresight/coresight.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/coresight/coresight.c b/drivers/coresight/coresight.c
index c5def9382357..894531d315b8 100644
--- a/drivers/coresight/coresight.c
+++ b/drivers/coresight/coresight.c
@@ -305,7 +305,9 @@ static int coresight_build_paths(struct coresight_device *csdev,
 
 	list_add(&csdev->path_link, path);
 
-	if (csdev->type == CORESIGHT_DEV_TYPE_SINK && csdev->activated) {
+	if ((csdev->type == CORESIGHT_DEV_TYPE_SINK ||
+	    csdev->type == CORESIGHT_DEV_TYPE_LINKSINK) &&
+	    csdev->activated) {
 		if (enable)
 			ret = coresight_enable_path(path);
 		else
-- 
1.9.1
