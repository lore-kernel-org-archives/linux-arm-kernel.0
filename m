From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Wed, 8 Jan 2014 18:49:57 +0000
Subject: [PATCH v8 5/6] core: remove ifdef CONFIG_PARAVIRT
In-Reply-To: <alpine.DEB.2.02.1401081845040.21510@kaball.uk.xensource.com>
References: <alpine.DEB.2.02.1401081845040.21510@kaball.uk.xensource.com>
Message-ID: <1389206998-27875-5-git-send-email-stefano.stabellini@eu.citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All the asm/paravirt.h headers (x86, ia64, arm, arm64) are properly
ifdef'ed CONFIG_PARAVIRT inside so they can be safely included.

Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
---
 kernel/sched/core.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index a88f4a4..4f9b239 100644
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
1.7.10.4
