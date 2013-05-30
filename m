From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Thu, 30 May 2013 14:35:00 +0100
Subject: [PATCH v5 2/4] kernel: missing include in cputime.c
In-Reply-To: <alpine.DEB.2.02.1305301426520.4799@kaball.uk.xensource.com>
References: <alpine.DEB.2.02.1305301426520.4799@kaball.uk.xensource.com>
Message-ID: <1369920902-3546-2-git-send-email-stefano.stabellini@eu.citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

steal_account_process_tick calls paravirt_steal_clock, but paravirt.h is
currently missing amoung the included header files.
Add include asm/paravirt.h ifdef CONFIG_PARAVIRT.

Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
CC: mingo at redhat.com
CC: peterz at infradead.org

Changes in v5:
- add ifdef CONFIG_PARAVIRT.
---
 kernel/sched/cputime.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
index cc2dc3ee..317a578 100644
--- a/kernel/sched/cputime.c
+++ b/kernel/sched/cputime.c
@@ -5,7 +5,9 @@
 #include <linux/static_key.h>
 #include <linux/context_tracking.h>
 #include "sched.h"
-
+#ifdef CONFIG_PARAVIRT
+#include <asm/paravirt.h>
+#endif
 
 #ifdef CONFIG_IRQ_TIME_ACCOUNTING
 
-- 
1.7.2.5
