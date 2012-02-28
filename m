From: joe@perches.com (Joe Perches)
Date: Tue, 28 Feb 2012 10:49:32 -0800
Subject: [PATCH trivial next 3/9] arm: Use vsprintf extention %pf with
 builtin_return_address
In-Reply-To: <cover.1330454853.git.joe@perches.com>
References: <cover.1330454853.git.joe@perches.com>
Message-ID: <367cf464b8ffed274c51573e195da7bb41b6889c.1330454853.git.joe@perches.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Emit the function name not the address when possible.

builtin_return_address() gives an address.  When building
a kernel with CONFIG_KALLSYMS, emit the actual function
name not the address.

Signed-off-by: Joe Perches <joe@perches.com>
---
 arch/arm/nwfpe/fpmodule.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/nwfpe/fpmodule.c b/arch/arm/nwfpe/fpmodule.c
index cb7658e..4e729f0 100644
--- a/arch/arm/nwfpe/fpmodule.c
+++ b/arch/arm/nwfpe/fpmodule.c
@@ -147,7 +147,7 @@ void float_raise(signed char flags)
 #ifdef CONFIG_DEBUG_USER
 	if (flags & debug)
  		printk(KERN_DEBUG
-		       "NWFPE: %s[%d] takes exception %08x at %p from %08lx\n",
+		       "NWFPE: %s[%d] takes exception %08x at %pf from %08lx\n",
 		       current->comm, current->pid, flags,
 		       __builtin_return_address(0), GET_USERREG()->ARM_pc);
 #endif
-- 
1.7.8.111.gad25c.dirty
