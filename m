From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Fri,  7 Jul 2017 14:07:44 +0100
Subject: [PATCH 1/5] perf: Export perf_event_update_userpage
In-Reply-To: <1499432868-18462-1-git-send-email-suzuki.poulose@arm.com>
References: <1499432868-18462-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1499432868-18462-2-git-send-email-suzuki.poulose@arm.com>
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
index 6c4e523..25a1a2f 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -4933,6 +4933,7 @@ void perf_event_update_userpage(struct perf_event *event)
 unlock:
 	rcu_read_unlock();
 }
+EXPORT_SYMBOL_GPL(perf_event_update_userpage);
 
 static int perf_mmap_fault(struct vm_fault *vmf)
 {
-- 
2.7.5
