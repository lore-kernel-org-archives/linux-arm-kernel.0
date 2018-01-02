From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Tue,  2 Jan 2018 11:25:26 +0000
Subject: [PATCH v11 1/8] perf: Export perf_event_update_userpage
In-Reply-To: <20180102112533.13640-1-suzuki.poulose@arm.com>
References: <20180102112533.13640-1-suzuki.poulose@arm.com>
Message-ID: <20180102112533.13640-2-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Export perf_event_update_userpage() so that PMU driver using them,
can be built as modules.

Acked-by: Peter Zilstra <peterz@infradead.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 kernel/events/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 4df5b695bf0d..64ec2c9d2c44 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -4904,6 +4904,7 @@ void perf_event_update_userpage(struct perf_event *event)
 unlock:
 	rcu_read_unlock();
 }
+EXPORT_SYMBOL_GPL(perf_event_update_userpage);
 
 static int perf_mmap_fault(struct vm_fault *vmf)
 {
-- 
2.13.6
