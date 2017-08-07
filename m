From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Mon,  7 Aug 2017 10:52:35 +0100
Subject: [PATCH v4 1/6] perf: Export perf_event_update_userpage
In-Reply-To: <1502099560-6267-1-git-send-email-suzuki.poulose@arm.com>
References: <1502099560-6267-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1502099560-6267-2-git-send-email-suzuki.poulose@arm.com>
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
index 426c2ff..21aad7a 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -4946,6 +4946,7 @@ void perf_event_update_userpage(struct perf_event *event)
 unlock:
 	rcu_read_unlock();
 }
+EXPORT_SYMBOL_GPL(perf_event_update_userpage);
 
 static int perf_mmap_fault(struct vm_fault *vmf)
 {
-- 
2.7.5
