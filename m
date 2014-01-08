From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Wed, 8 Jan 2014 18:49:54 +0000
Subject: [PATCH v8 2/6] kernel: missing include in cputime.c
In-Reply-To: <alpine.DEB.2.02.1401081845040.21510@kaball.uk.xensource.com>
References: <alpine.DEB.2.02.1401081845040.21510@kaball.uk.xensource.com>
Message-ID: <1389206998-27875-2-git-send-email-stefano.stabellini@eu.citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

steal_account_process_tick calls paravirt_steal_clock, but paravirt.h is
currently missing amoung the included header files.
Add include asm/paravirt.h.

Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
CC: mingo at redhat.com
CC: peterz at infradead.org

---

Changes in v7:
- remove ifdef CONFIG_PARAVIRT (the ifdef has been moved inside the
  paravirt headers).

Changes in v5:
- add ifdef CONFIG_PARAVIRT.
---
 kernel/sched/cputime.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
index 9994791..9f9b76a 100644
--- a/kernel/sched/cputime.c
+++ b/kernel/sched/cputime.c
@@ -5,6 +5,7 @@
 #include <linux/static_key.h>
 #include <linux/context_tracking.h>
 #include "sched.h"
+#include <asm/paravirt.h>
 
 
 #ifdef CONFIG_IRQ_TIME_ACCOUNTING
-- 
1.7.10.4
