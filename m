From: dave.long@linaro.org (David Long)
Date: Sun, 26 Jun 2016 23:06:53 -0400
Subject: [PATCH v14 10/10] kprobes: Add arm64 case in kprobe example module
In-Reply-To: <1466996813-23295-1-git-send-email-dave.long@linaro.org>
References: <1466996813-23295-1-git-send-email-dave.long@linaro.org>
Message-ID: <1466996813-23295-11-git-send-email-dave.long@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sandeepa Prabhu <sandeepa.s.prabhu@gmail.com>

Add info prints in sample kprobe handlers for ARM64

Signed-off-by: Sandeepa Prabhu <sandeepa.s.prabhu@gmail.com>
Signed-off-by: David A. Long <dave.long@linaro.org>
---
 samples/kprobes/kprobe_example.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/samples/kprobes/kprobe_example.c b/samples/kprobes/kprobe_example.c
index ed0ca0c..f3b61b4 100644
--- a/samples/kprobes/kprobe_example.c
+++ b/samples/kprobes/kprobe_example.c
@@ -46,6 +46,11 @@ static int handler_pre(struct kprobe *p, struct pt_regs *regs)
 			" ex1 = 0x%lx\n",
 		p->symbol_name, p->addr, regs->pc, regs->ex1);
 #endif
+#ifdef CONFIG_ARM64
+	pr_info("<%s> pre_handler: p->addr = 0x%p, pc = 0x%lx,"
+			" pstate = 0x%lx\n",
+		p->symbol_name, p->addr, (long)regs->pc, (long)regs->pstate);
+#endif
 
 	/* A dump_stack() here will give a stack backtrace */
 	return 0;
@@ -71,6 +76,10 @@ static void handler_post(struct kprobe *p, struct pt_regs *regs,
 	printk(KERN_INFO "<%s> post_handler: p->addr = 0x%p, ex1 = 0x%lx\n",
 		p->symbol_name, p->addr, regs->ex1);
 #endif
+#ifdef CONFIG_ARM64
+	pr_info("<%s> post_handler: p->addr = 0x%p, pstate = 0x%lx\n",
+		p->symbol_name, p->addr, (long)regs->pstate);
+#endif
 }
 
 /*
-- 
2.5.0
