From: naveen.n.rao@linux.vnet.ibm.com (Naveen N. Rao)
Date: Tue,  7 Mar 2017 00:34:57 +0530
Subject: [PATCH 2/2] arm64: kprobes: remove kprobe_exceptions_notify
In-Reply-To: <cover.1488826671.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1488826671.git.naveen.n.rao@linux.vnet.ibm.com>
Message-ID: <a768e49cc553061ba8e01201fa90f7a9924c26c6.1488826671.git.naveen.n.rao@linux.vnet.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit fc62d0207ae0 ("kprobes: Introduce weak variant of
kprobe_exceptions_notify()") introduces a generic empty version of the
function for architectures that don't need special handling, like arm64.
As such, remove the arch/arm64/ specific handler.

Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
 arch/arm64/kernel/probes/kprobes.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/arm64/kernel/probes/kprobes.c b/arch/arm64/kernel/probes/kprobes.c
index 2a07aae5b8a2..c5c45942fb6e 100644
--- a/arch/arm64/kernel/probes/kprobes.c
+++ b/arch/arm64/kernel/probes/kprobes.c
@@ -372,12 +372,6 @@ int __kprobes kprobe_fault_handler(struct pt_regs *regs, unsigned int fsr)
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
2.11.1
