From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Fri,  3 Nov 2017 17:50:58 +0000
Subject: [PATCH v10 1/8] perf: Export perf_event_update_userpage
In-Reply-To: <20171103175105.23546-1-suzuki.poulose@arm.com>
References: <20171103175105.23546-1-suzuki.poulose@arm.com>
Message-ID: <20171103175105.23546-2-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Export perf_event_update_userpage() so that PMU driver using them,
can be built as modules.

Cc: Peter Zilstra <peterz@infradead.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 kernel/events/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 9d93db81fa36..550015829db8 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -4982,6 +4982,7 @@ void perf_event_update_userpage(struct perf_event *event)
 unlock:
 	rcu_read_unlock();
 }
+EXPORT_SYMBOL_GPL(perf_event_update_userpage);
 
 static int perf_mmap_fault(struct vm_fault *vmf)
 {
-- 
2.13.6
