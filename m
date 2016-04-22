From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Fri, 22 Apr 2016 11:14:12 -0600
Subject: [PATCH V3 15/18] coresight: moving struct cs_buffers to header file
In-Reply-To: <1461345255-11758-1-git-send-email-mathieu.poirier@linaro.org>
References: <1461345255-11758-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1461345255-11758-16-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

That way we can re-use the structure in other drivers.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etb10.c | 20 --------------------
 drivers/hwtracing/coresight/coresight-priv.h  | 20 ++++++++++++++++++++
 2 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etb10.c b/drivers/hwtracing/coresight/coresight-etb10.c
index a974c39171a9..239800aa5e24 100644
--- a/drivers/hwtracing/coresight/coresight-etb10.c
+++ b/drivers/hwtracing/coresight/coresight-etb10.c
@@ -71,26 +71,6 @@
 #define ETB_FRAME_SIZE_WORDS	4
 
 /**
- * struct cs_buffer - keep track of a recording session' specifics
- * @cur:	index of the current buffer
- * @nr_pages:	max number of pages granted to us
- * @offset:	offset within the current buffer
- * @data_size:	how much we collected in this run
- * @lost:	other than zero if we had a HW buffer wrap around
- * @snapshot:	is this run in snapshot mode
- * @data_pages:	a handle the ring buffer
- */
-struct cs_buffers {
-	unsigned int		cur;
-	unsigned int		nr_pages;
-	unsigned long		offset;
-	local_t			data_size;
-	local_t			lost;
-	bool			snapshot;
-	void			**data_pages;
-};
-
-/**
  * struct etb_drvdata - specifics associated to an ETB component
  * @base:	memory mapped base address for this component.
  * @dev:	the device entity associated to this component.
diff --git a/drivers/hwtracing/coresight/coresight-priv.h b/drivers/hwtracing/coresight/coresight-priv.h
index 3b5dd95a3588..ad975c58080d 100644
--- a/drivers/hwtracing/coresight/coresight-priv.h
+++ b/drivers/hwtracing/coresight/coresight-priv.h
@@ -53,6 +53,26 @@ enum cs_mode {
 	CS_MODE_PERF,
 };
 
+/**
+ * struct cs_buffer - keep track of a recording session' specifics
+ * @cur:	index of the current buffer
+ * @nr_pages:	max number of pages granted to us
+ * @offset:	offset within the current buffer
+ * @data_size:	how much we collected in this run
+ * @lost:	other than zero if we had a HW buffer wrap around
+ * @snapshot:	is this run in snapshot mode
+ * @data_pages:	a handle the ring buffer
+ */
+struct cs_buffers {
+	unsigned int		cur;
+	unsigned int		nr_pages;
+	unsigned long		offset;
+	local_t			data_size;
+	local_t			lost;
+	bool			snapshot;
+	void			**data_pages;
+};
+
 static inline void CS_LOCK(void __iomem *addr)
 {
 	do {
-- 
2.5.0
