From: will.deacon@arm.com (Will Deacon)
Date: Mon,  5 Jun 2017 16:22:55 +0100
Subject: [PATCH v4 3/5] perf/core: Add PERF_AUX_FLAG_COLLISION to report
 colliding samples
In-Reply-To: <1496676177-29356-1-git-send-email-will.deacon@arm.com>
References: <1496676177-29356-1-git-send-email-will.deacon@arm.com>
Message-ID: <1496676177-29356-4-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ARM SPE architecture permits an implementation to ignore a sample
if the sample is due to be taken whilst another sample is already being
produced. In this case, it is desirable to report the collision to
userspace, as they may want to lower the sample period.

This patch adds a PERF_AUX_FLAG_COLLISION flag, so that such events can
be relayed to userspace.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 include/uapi/linux/perf_event.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index b1c0b187acfe..157034597d21 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -916,6 +916,7 @@ enum perf_callchain_context {
 #define PERF_AUX_FLAG_TRUNCATED		0x01	/* record was truncated to fit */
 #define PERF_AUX_FLAG_OVERWRITE		0x02	/* snapshot from overwrite mode */
 #define PERF_AUX_FLAG_PARTIAL		0x04	/* record contains gaps */
+#define PERF_AUX_FLAG_COLLISION		0x08	/* sample collided with another */
 
 #define PERF_FLAG_FD_NO_GROUP		(1UL << 0)
 #define PERF_FLAG_FD_OUTPUT		(1UL << 1)
-- 
2.1.4
