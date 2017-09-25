From: jglauber@cavium.com (Jan Glauber)
Date: Mon, 25 Sep 2017 14:34:57 +0200
Subject: [PATCH v10 2/7] perf: export perf_event_update_userpage()
In-Reply-To: <20170925123502.17289-1-jglauber@cavium.com>
References: <20170925123502.17289-1-jglauber@cavium.com>
Message-ID: <20170925123502.17289-3-jglauber@cavium.com>
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
index 6bc21e202ae4..162f5ba756a9 100644
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
2.9.0.rc0.21.g7777322
