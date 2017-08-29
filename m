From: jglauber@cavium.com (Jan Glauber)
Date: Tue, 29 Aug 2017 15:12:35 +0200
Subject: [RFC PATCH v9 4/7] perf: export perf_event_update_userpage()
In-Reply-To: <20170829131238.4988-1-jglauber@cavium.com>
References: <20170829131238.4988-1-jglauber@cavium.com>
Message-ID: <20170829131238.4988-5-jglauber@cavium.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Export perf_event_update_userpage(). This change is needed to allow
building a PMU driver as a kernel module.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>

Signed-off-by: Jan Glauber <jglauber@cavium.com>
---
 kernel/events/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 3504125..639bbf5 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -4977,6 +4977,7 @@ void perf_event_update_userpage(struct perf_event *event)
 unlock:
 	rcu_read_unlock();
 }
+EXPORT_SYMBOL_GPL(perf_event_update_userpage);
 
 static int perf_mmap_fault(struct vm_fault *vmf)
 {
-- 
2.9.0.rc0.21.g7777322
