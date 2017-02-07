From: naveen.n.rao@linux.vnet.ibm.com (Naveen N. Rao)
Date: Wed,  8 Feb 2017 01:24:15 +0530
Subject: [PATCH 2/3] arm: kprobes: remove kprobe_exceptions_notify
In-Reply-To: <b0894e503195b13a5ed6319e897e673f376a748d.1486496890.git.naveen.n.rao@linux.vnet.ibm.com>
References: <b0894e503195b13a5ed6319e897e673f376a748d.1486496890.git.naveen.n.rao@linux.vnet.ibm.com>
Message-ID: <46a640f65b86650d3a7d64a577dd441838de1c20.1486496890.git.naveen.n.rao@linux.vnet.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

... as the weak variant will do.

Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
 arch/arm/probes/kprobes/core.c     | 10 ----------
 arch/arm64/kernel/probes/kprobes.c |  6 ------
 2 files changed, 16 deletions(-)

diff --git a/arch/arm/probes/kprobes/core.c b/arch/arm/probes/kprobes/core.c
index a4ec240ee7ba..f89db1e278cf 100644
--- a/arch/arm/probes/kprobes/core.c
+++ b/arch/arm/probes/kprobes/core.c
@@ -391,16 +391,6 @@ int __kprobes kprobe_fault_handler(struct pt_regs *regs, unsigned int fsr)
 	return 0;
 }
 
-int __kprobes kprobe_exceptions_notify(struct notifier_block *self,
-				       unsigned long val, void *data)
-{
-	/*
-	 * notify_die() is currently never called on ARM,
-	 * so this callback is currently empty.
-	 */
-	return NOTIFY_DONE;
-}
-
 /*
  * When a retprobed function returns, trampoline_handler() is called,
  * calling the kretprobe's handler. We construct a struct pt_regs to
diff --git a/arch/arm64/kernel/probes/kprobes.c b/arch/arm64/kernel/probes/kprobes.c
index f0593c92279b..769becae3e90 100644
--- a/arch/arm64/kernel/probes/kprobes.c
+++ b/arch/arm64/kernel/probes/kprobes.c
@@ -371,12 +371,6 @@ int __kprobes kprobe_fault_handler(struct pt_regs *regs, unsigned int fsr)
 	return 0;
 }
 
-int __kprobes kprobe_exceptions_notify(struct notifier_block *self,
-				       unsigned long val, void *data)
-{
-	return NOTIFY_DONE;
-}
-
 static void __kprobes kprobe_handler(struct pt_regs *regs)
 {
 	struct kprobe *p, *cur_kprobe;
-- 
2.11.0
