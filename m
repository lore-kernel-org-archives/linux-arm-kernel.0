From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Thu, 9 Jan 2014 18:32:13 +0000
Subject: [PATCH v9 2/5] kernel: missing include in cputime.c
In-Reply-To: <alpine.DEB.2.02.1401091755390.21510@kaball.uk.xensource.com>
References: <alpine.DEB.2.02.1401091755390.21510@kaball.uk.xensource.com>
Message-ID: <1389292336-9292-2-git-send-email-stefano.stabellini@eu.citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

steal_account_process_tick calls paravirt_steal_clock, but paravirt.h is
currently missing amoung the included header files.
Add include asm/paravirt.h.

Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
CC: mingo at redhat.com
CC: peterz at infradead.org
---
 kernel/sched/cputime.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
index 9994791..951833e 100644
--- a/kernel/sched/cputime.c
+++ b/kernel/sched/cputime.c
@@ -5,6 +5,9 @@
 #include <linux/static_key.h>
 #include <linux/context_tracking.h>
 #include "sched.h"
+#ifdef CONFIG_PARAVIRT
+#include <asm/paravirt.h>
+#endif
 
 
 #ifdef CONFIG_IRQ_TIME_ACCOUNTING
-- 
1.7.10.4
