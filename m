From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Wed, 18 Jul 2018 15:48:01 -0600
Subject: [PATCH v3 1/7] perf: Introduce ioctl to communicate driver
 configuration to kernel
In-Reply-To: <1531950487-24554-1-git-send-email-mathieu.poirier@linaro.org>
References: <1531950487-24554-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1531950487-24554-2-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adding a new IOCTL command to communicate PMU specific configuration to
PMU kernel drivers.  This can be anything a PMU might need for
configuration that doesn't fit in the perf_event_attr structure, such
as the CoreSight sink to use for a session.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 include/uapi/linux/perf_event.h       | 1 +
 tools/include/uapi/linux/perf_event.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index b8e288a1f740..b5b3241877df 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -460,6 +460,7 @@ struct perf_event_query_bpf {
 #define PERF_EVENT_IOC_PAUSE_OUTPUT		_IOW('$', 9, __u32)
 #define PERF_EVENT_IOC_QUERY_BPF		_IOWR('$', 10, struct perf_event_query_bpf *)
 #define PERF_EVENT_IOC_MODIFY_ATTRIBUTES	_IOW('$', 11, struct perf_event_attr *)
+#define PERF_EVENT_IOC_SET_DRV_CONFIG		_IOW('$', 12, char *)
 
 enum perf_event_ioc_flags {
 	PERF_IOC_FLAG_GROUP		= 1U << 0,
diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
index b8e288a1f740..b5b3241877df 100644
--- a/tools/include/uapi/linux/perf_event.h
+++ b/tools/include/uapi/linux/perf_event.h
@@ -460,6 +460,7 @@ struct perf_event_query_bpf {
 #define PERF_EVENT_IOC_PAUSE_OUTPUT		_IOW('$', 9, __u32)
 #define PERF_EVENT_IOC_QUERY_BPF		_IOWR('$', 10, struct perf_event_query_bpf *)
 #define PERF_EVENT_IOC_MODIFY_ATTRIBUTES	_IOW('$', 11, struct perf_event_attr *)
+#define PERF_EVENT_IOC_SET_DRV_CONFIG		_IOW('$', 12, char *)
 
 enum perf_event_ioc_flags {
 	PERF_IOC_FLAG_GROUP		= 1U << 0,
-- 
2.7.4
