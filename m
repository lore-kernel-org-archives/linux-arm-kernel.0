From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Fri, 28 Jun 2013 12:20:43 +0100
Subject: [PATCH v7 2/6] kernel: missing include in cputime.c
In-Reply-To: <alpine.DEB.2.02.1306271614260.4782@kaball.uk.xensource.com>
References: <alpine.DEB.2.02.1306271614260.4782@kaball.uk.xensource.com>
Message-ID: <1372418447-24066-2-git-send-email-stefano.stabellini@eu.citrix.com>
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
---
 kernel/sched/cputime.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
index cc2dc3ee..a5d1a9b 100644
--- a/kernel/sched/cputime.c
+++ b/kernel/sched/cputime.c
@@ -5,6 +5,7 @@
 #include <linux/static_key.h>
 #include <linux/context_tracking.h>
 #include "sched.h"
+#include <asm/paravirt.h>
 
 
 #ifdef CONFIG_IRQ_TIME_ACCOUNTING
-- 
1.7.2.5
