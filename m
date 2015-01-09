From: mathieu.poirier@linaro.org (mathieu.poirier at linaro.org)
Date: Fri,  9 Jan 2015 16:57:18 -0700
Subject: [PATCH 07/11] coresight: remove the unused macro
 CORESIGHT_DEBUGFS_ENTRY
In-Reply-To: <1420847842-31769-1-git-send-email-mathieu.poirier@linaro.org>
References: <1420847842-31769-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1420847842-31769-8-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Xia Kaixu <xiakaixu@huawei.com>

Debugfs isn't used for coresight configuration, so the macro
CORESIGHT_DEBUGFS_ENTRY is unnecessary, just remove it.

Signed-off-by: Xia Kaixu <xiakaixu@huawei.com>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 include/linux/coresight.h | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/include/linux/coresight.h b/include/linux/coresight.h
index 5d3c54311f7a..7cbfecbfa643 100644
--- a/include/linux/coresight.h
+++ b/include/linux/coresight.h
@@ -179,15 +179,6 @@ struct coresight_device {
 #define sink_ops(csdev)		csdev->ops->sink_ops
 #define link_ops(csdev)		csdev->ops->link_ops
 
-#define CORESIGHT_DEBUGFS_ENTRY(__name, __entry_name,			\
-				 __mode, __get, __set, __fmt)		\
-DEFINE_SIMPLE_ATTRIBUTE(__name ## _ops, __get, __set, __fmt);		\
-static const struct coresight_ops_entry __name ## _entry = {		\
-	.name = __entry_name,						\
-	.mode = __mode,							\
-	.ops  = &__name ## _ops						\
-}
-
 /**
  * struct coresight_ops_sink - basic operations for a sink
  * Operations available for sinks
-- 
1.9.1
