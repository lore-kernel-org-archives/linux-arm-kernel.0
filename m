From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Mon, 30 Mar 2015 14:13:35 -0600
Subject: [PATCH 2/8] coresight: fixing compilation warnings picked up by 64bit
 compiler
In-Reply-To: <1427746421-31360-1-git-send-email-mathieu.poirier@linaro.org>
References: <1427746421-31360-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1427746421-31360-3-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Compiling coresight drivers with a 64-bit compiler highlights a couple
of formatting issues, which are fixed by this patch.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/coresight/coresight-etb10.c | 4 ++--
 drivers/coresight/coresight-tmc.c   | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/coresight/coresight-etb10.c b/drivers/coresight/coresight-etb10.c
index c9acd406f0d0..40049869aecd 100644
--- a/drivers/coresight/coresight-etb10.c
+++ b/drivers/coresight/coresight-etb10.c
@@ -313,8 +313,8 @@ static ssize_t etb_read(struct file *file, char __user *data,
 
 	*ppos += len;
 
-	dev_dbg(drvdata->dev, "%s: %d bytes copied, %d bytes left\n",
-		__func__, len, (int) (depth * 4 - *ppos));
+	dev_dbg(drvdata->dev, "%s: %zu bytes copied, %d bytes left\n",
+		__func__, len, (int)(depth * 4 - *ppos));
 	return len;
 }
 
diff --git a/drivers/coresight/coresight-tmc.c b/drivers/coresight/coresight-tmc.c
index 3ff232f9ddf7..030e097c4fb2 100644
--- a/drivers/coresight/coresight-tmc.c
+++ b/drivers/coresight/coresight-tmc.c
@@ -533,8 +533,8 @@ static ssize_t tmc_read(struct file *file, char __user *data, size_t len,
 
 	*ppos += len;
 
-	dev_dbg(drvdata->dev, "%s: %d bytes copied, %d bytes left\n",
-		__func__, len, (int) (drvdata->size - *ppos));
+	dev_dbg(drvdata->dev, "%s: %zu bytes copied, %d bytes left\n",
+		__func__, len, (int)(drvdata->size - *ppos));
 	return len;
 }
 
-- 
1.9.1
