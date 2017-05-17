From: jglauber@cavium.com (Jan Glauber)
Date: Wed, 17 May 2017 10:31:20 +0200
Subject: [PATCH v5 1/3] perf: export perf_event_update_userpage()
In-Reply-To: <20170517083122.5050-1-jglauber@cavium.com>
References: <20170517083122.5050-1-jglauber@cavium.com>
Message-ID: <20170517083122.5050-2-jglauber@cavium.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Export perf_event_update_userpage() to make it usable from a module.

Signed-off-by: Jan Glauber <jglauber@cavium.com>
---
 kernel/events/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 6e75a5c..6578b9f 100644
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
2.9.0.rc0.21.g7777322
