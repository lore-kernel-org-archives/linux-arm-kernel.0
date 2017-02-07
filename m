From: naveen.n.rao@linux.vnet.ibm.com (Naveen N. Rao)
Date: Wed,  8 Feb 2017 01:24:16 +0530
Subject: [PATCH 3/3] powerpc: kprobes: remove kprobe_exceptions_notify()
In-Reply-To: <b0894e503195b13a5ed6319e897e673f376a748d.1486496890.git.naveen.n.rao@linux.vnet.ibm.com>
References: <b0894e503195b13a5ed6319e897e673f376a748d.1486496890.git.naveen.n.rao@linux.vnet.ibm.com>
Message-ID: <4d802c747c86386fbf744021007b1cc74c8cdc59.1486496890.git.naveen.n.rao@linux.vnet.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

... as the weak variant will do.

Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/kprobes.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/arch/powerpc/kernel/kprobes.c b/arch/powerpc/kernel/kprobes.c
index 45e4f82b230d..fce05a38851c 100644
--- a/arch/powerpc/kernel/kprobes.c
+++ b/arch/powerpc/kernel/kprobes.c
@@ -475,15 +475,6 @@ int __kprobes kprobe_fault_handler(struct pt_regs *regs, int trapnr)
 	return 0;
 }
 
-/*
- * Wrapper routine to for handling exceptions.
- */
-int __kprobes kprobe_exceptions_notify(struct notifier_block *self,
-				       unsigned long val, void *data)
-{
-	return NOTIFY_DONE;
-}
-
 unsigned long arch_deref_entry_point(void *entry)
 {
 	return ppc_global_function_entry(entry);
-- 
2.11.0
