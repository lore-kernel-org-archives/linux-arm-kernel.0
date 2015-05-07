From: boris.ostrovsky@oracle.com (Boris Ostrovsky)
Date: Thu,  7 May 2015 12:55:23 -0400
Subject: [PATCH] xen/arm: Define xen_arch_suspend()
Message-ID: <1431017723-27194-1-git-send-email-boris.ostrovsky@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 2b953a5e994c ("xen: Suspend ticks on all CPUs during suspend")
introduced xen_arch_suspend() routine but did so only for x86, breaking
ARM builds.

We need to add it to ARM as well.

Signed-off-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Reported-by: Michal Suchanek <hramrach@gmail.com>
Tested-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
---
 arch/arm/xen/enlighten.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/xen/enlighten.c b/arch/arm/xen/enlighten.c
index 224081c..7d0f070 100644
--- a/arch/arm/xen/enlighten.c
+++ b/arch/arm/xen/enlighten.c
@@ -272,6 +272,7 @@ void xen_arch_pre_suspend(void) { }
 void xen_arch_post_suspend(int suspend_cancelled) { }
 void xen_timer_resume(void) { }
 void xen_arch_resume(void) { }
+void xen_arch_suspend(void) { }
 
 
 /* In the hypervisor.S file. */
-- 
2.1.0
