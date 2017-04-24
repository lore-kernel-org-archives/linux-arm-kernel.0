From: julien.grall@arm.com (Julien Grall)
Date: Mon, 24 Apr 2017 18:58:37 +0100
Subject: [PATCH 1/3 v2] xen: Export xen_reboot
In-Reply-To: <20170424175839.5262-1-julien.grall@arm.com>
References: <20170424175839.5262-1-julien.grall@arm.com>
Message-ID: <20170424175839.5262-2-julien.grall@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The helper xen_reboot will be called by the EFI code in a later patch.

Note that the ARM version does not yet exist and will be added in a
later patch too.

Signed-off-by: Julien Grall <julien.grall@arm.com>

---

Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86 at kernel.org

    Changes in v2:
        - Patch added
---
 arch/x86/xen/enlighten.c | 2 +-
 include/xen/xen-ops.h    | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/xen/enlighten.c b/arch/x86/xen/enlighten.c
index ec1d5c46e58f..563f2d963a04 100644
--- a/arch/x86/xen/enlighten.c
+++ b/arch/x86/xen/enlighten.c
@@ -1294,7 +1294,7 @@ static const struct pv_cpu_ops xen_cpu_ops __initconst = {
 	.end_context_switch = xen_end_context_switch,
 };
 
-static void xen_reboot(int reason)
+void xen_reboot(int reason)
 {
 	struct sched_shutdown r = { .reason = reason };
 	int cpu;
diff --git a/include/xen/xen-ops.h b/include/xen/xen-ops.h
index b5486e648607..fc5ddb472f86 100644
--- a/include/xen/xen-ops.h
+++ b/include/xen/xen-ops.h
@@ -22,6 +22,8 @@ void xen_timer_resume(void);
 void xen_arch_resume(void);
 void xen_arch_suspend(void);
 
+void xen_reboot(int reason);
+
 void xen_resume_notifier_register(struct notifier_block *nb);
 void xen_resume_notifier_unregister(struct notifier_block *nb);
 
-- 
2.11.0
