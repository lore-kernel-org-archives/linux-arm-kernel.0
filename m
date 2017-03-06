From: naveen.n.rao@linux.vnet.ibm.com (Naveen N. Rao)
Date: Tue,  7 Mar 2017 00:34:56 +0530
Subject: [PATCH 1/2] arm: kprobes: remove kprobe_exceptions_notify
In-Reply-To: <cover.1488826671.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1488826671.git.naveen.n.rao@linux.vnet.ibm.com>
Message-ID: <67983f0757dc99e8f50b4fe2956b053df920df10.1488826671.git.naveen.n.rao@linux.vnet.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit fc62d0207ae0 ("kprobes: Introduce weak variant of
kprobe_exceptions_notify()") introduces a generic empty version of the
function for architectures that don't need special handling, like arm.
As such, remove the arch/arm/ specific handler.

Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
 arch/arm/probes/kprobes/core.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/arch/arm/probes/kprobes/core.c b/arch/arm/probes/kprobes/core.c
index b6dc9d838a9a..4a548b99965b 100644
--- a/arch/arm/probes/kprobes/core.c
+++ b/arch/arm/probes/kprobes/core.c
@@ -392,16 +392,6 @@ int __kprobes kprobe_fault_handler(struct pt_regs *regs, unsigned int fsr)
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
-- 
2.11.1
