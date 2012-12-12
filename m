From: joe@perches.com (Joe Perches)
Date: Wed, 12 Dec 2012 10:18:52 -0800
Subject: [TRIVIAL PATCH 03/26] arm: Convert print_symbol to %pSR
In-Reply-To: <cover.1355335227.git.joe@perches.com>
References: <cover.1355335227.git.joe@perches.com>
Message-ID: <d7766488b6c6de5242f566b4bb1fb43c7bf483cf.1355335227.git.joe@perches.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the new vsprintf extension to avoid any possible
message interleaving.

Signed-off-by: Joe Perches <joe@perches.com>
---
 arch/arm/kernel/process.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
index f79dd1e..de3966a 100644
--- a/arch/arm/kernel/process.c
+++ b/arch/arm/kernel/process.c
@@ -283,8 +283,8 @@ void __show_regs(struct pt_regs *regs)
 		init_utsname()->release,
 		(int)strcspn(init_utsname()->version, " "),
 		init_utsname()->version);
-	print_symbol("PC is at %s\n", instruction_pointer(regs));
-	print_symbol("LR is at %s\n", regs->ARM_lr);
+	printk("PC is at %pSR\n", (void *)instruction_pointer(regs));
+	printk("LR is at %pSR\n", (void *)regs->ARM_lr);
 	printk("pc : [<%08lx>]    lr : [<%08lx>]    psr: %08lx\n"
 	       "sp : %08lx  ip : %08lx  fp : %08lx\n",
 		regs->ARM_pc, regs->ARM_lr, regs->ARM_cpsr,
-- 
1.7.8.112.g3fd21
