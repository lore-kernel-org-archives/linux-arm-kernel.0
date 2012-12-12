From: joe@perches.com (Joe Perches)
Date: Wed, 12 Dec 2012 10:18:53 -0800
Subject: [TRIVIAL PATCH 04/26] arm64: Convert print_symbol to %pSR
In-Reply-To: <cover.1355335227.git.joe@perches.com>
References: <cover.1355335227.git.joe@perches.com>
Message-ID: <c5cb06461153912fe383547a267aaea6e8b4976a.1355335227.git.joe@perches.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the new vsprintf extension to avoid any possible
message interleaving.

Signed-off-by: Joe Perches <joe@perches.com>
---
 arch/arm64/kernel/process.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index cb0956b..55fb84e 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -187,8 +187,8 @@ void __show_regs(struct pt_regs *regs)
 		init_utsname()->release,
 		(int)strcspn(init_utsname()->version, " "),
 		init_utsname()->version);
-	print_symbol("PC is at %s\n", instruction_pointer(regs));
-	print_symbol("LR is at %s\n", regs->regs[30]);
+	printk("PC is at %pSR\n", (void *)instruction_pointer(regs));
+	printk("LR is at %pSR\n", (void *)regs->regs[30]);
 	printk("pc : [<%016llx>] lr : [<%016llx>] pstate: %08llx\n",
 	       regs->pc, regs->regs[30], regs->pstate);
 	printk("sp : %016llx\n", regs->sp);
-- 
1.7.8.112.g3fd21
