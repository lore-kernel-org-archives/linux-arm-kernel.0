From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Mon, 28 Mar 2016 20:36:59 -0700
Subject: [PATCH v2 3/9] remoteproc: Add additional crash reasons
In-Reply-To: <1459222625-11440-1-git-send-email-bjorn.andersson@linaro.org>
References: <1459222625-11440-1-git-send-email-bjorn.andersson@linaro.org>
Message-ID: <1459222625-11440-4-git-send-email-bjorn.andersson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Bjorn Andersson <bjorn.andersson@sonymobile.com>

The Qualcomm WCNSS can crash by watchdog or a fatal software error. Add
these types to the list of remoteproc crash reasons.

Signed-off-by: Bjorn Andersson <bjorn.andersson@sonymobile.com>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v1:
- None

 drivers/remoteproc/remoteproc_core.c | 2 ++
 include/linux/remoteproc.h           | 4 ++++
 2 files changed, 6 insertions(+)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index c04a786dc051..19a906716abd 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -57,6 +57,8 @@ static DEFINE_IDA(rproc_dev_index);
 
 static const char * const rproc_crash_names[] = {
 	[RPROC_MMUFAULT]	= "mmufault",
+	[RPROC_WATCHDOG]	= "watchdog",
+	[RPROC_FATAL_ERROR]	= "fatal error",
 };
 
 /* translate rproc_crash_type to string */
diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
index 9c4e1384f636..1c457a8dd5a6 100644
--- a/include/linux/remoteproc.h
+++ b/include/linux/remoteproc.h
@@ -365,6 +365,8 @@ enum rproc_state {
 /**
  * enum rproc_crash_type - remote processor crash types
  * @RPROC_MMUFAULT:	iommu fault
+ * @RPROC_WATCHDOG:	watchdog bite
+ * @RPROC_FATAL_ERROR	fatal error
  *
  * Each element of the enum is used as an array index. So that, the value of
  * the elements should be always something sane.
@@ -373,6 +375,8 @@ enum rproc_state {
  */
 enum rproc_crash_type {
 	RPROC_MMUFAULT,
+	RPROC_WATCHDOG,
+	RPROC_FATAL_ERROR,
 };
 
 /**
-- 
2.5.0
