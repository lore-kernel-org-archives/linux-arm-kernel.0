From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Mon,  5 Jun 2017 14:15:07 -0600
Subject: [PATCH 06/17] coresight: etb10: Delete an error message for a failed
 memory allocation in etb_probe()
In-Reply-To: <1496693718-9191-1-git-send-email-mathieu.poirier@linaro.org>
References: <1496693718-9191-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1496693718-9191-7-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Markus Elfring <elfring@users.sourceforge.net>

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Link: http://events.linuxfoundation.org/sites/events/files/slides/LCJ16-Refactor_Strings-WSang_0.pdf
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etb10.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etb10.c b/drivers/hwtracing/coresight/coresight-etb10.c
index 979ea6ec7902..837aebf22c45 100644
--- a/drivers/hwtracing/coresight/coresight-etb10.c
+++ b/drivers/hwtracing/coresight/coresight-etb10.c
@@ -675,11 +675,8 @@ static int etb_probe(struct amba_device *adev, const struct amba_id *id)
 
 	drvdata->buf = devm_kzalloc(dev,
 				    drvdata->buffer_depth * 4, GFP_KERNEL);
-	if (!drvdata->buf) {
-		dev_err(dev, "Failed to allocate %u bytes for buffer data\n",
-			drvdata->buffer_depth * 4);
+	if (!drvdata->buf)
 		return -ENOMEM;
-	}
 
 	desc.type = CORESIGHT_DEV_TYPE_SINK;
 	desc.subtype.sink_subtype = CORESIGHT_DEV_SUBTYPE_SINK_BUFFER;
-- 
2.7.4
