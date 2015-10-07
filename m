From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Wed,  7 Oct 2015 09:26:40 -0600
Subject: [PATCH 3/6] coresight: adding comments to remove ambiguity
In-Reply-To: <1444231603-26676-1-git-send-email-mathieu.poirier@linaro.org>
References: <1444231603-26676-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1444231603-26676-4-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add comment to function coresight_enable_path() to make
sure there is no misunderstanding about what the code does.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight.c b/drivers/hwtracing/coresight/coresight.c
index 894531d315b8..e25492137d8b 100644
--- a/drivers/hwtracing/coresight/coresight.c
+++ b/drivers/hwtracing/coresight/coresight.c
@@ -240,6 +240,11 @@ static int coresight_enable_path(struct list_head *path)
 	int ret = 0;
 	struct coresight_device *cd;
 
+	/*
+	 * At this point we have a full @path, from source to sink.  The
+	 * sink is the first entry and the source the last one.  Go through
+	 * all the components and enable them one by one.
+	 */
 	list_for_each_entry(cd, path, path_link) {
 		if (cd == list_first_entry(path, struct coresight_device,
 					   path_link)) {
-- 
1.9.1
