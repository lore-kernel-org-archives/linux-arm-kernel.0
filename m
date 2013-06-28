From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Fri, 28 Jun 2013 12:20:46 +0100
Subject: [PATCH v7 5/6] core: remove ifdef CONFIG_PARAVIRT
In-Reply-To: <alpine.DEB.2.02.1306271614260.4782@kaball.uk.xensource.com>
References: <alpine.DEB.2.02.1306271614260.4782@kaball.uk.xensource.com>
Message-ID: <1372418447-24066-5-git-send-email-stefano.stabellini@eu.citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All the asm/paravirt.h headers (x86, ia64, arm, arm64) are properly
ifdef'ed CONFIG_PARAVIRT inside so they can be safely included.

Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
CC: mingo at redhat.com
CC: peterz at infradead.org
---
 kernel/sched/core.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 58453b8..cd339c5 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -78,9 +78,7 @@
 #include <asm/tlb.h>
 #include <asm/irq_regs.h>
 #include <asm/mutex.h>
-#ifdef CONFIG_PARAVIRT
 #include <asm/paravirt.h>
-#endif
 
 #include "sched.h"
 #include "../workqueue_internal.h"
-- 
1.7.2.5
