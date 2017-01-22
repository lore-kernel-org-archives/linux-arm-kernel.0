From: afzal.mohd.ma@gmail.com (afzal mohammed)
Date: Sun, 22 Jan 2017 08:52:59 +0530
Subject: [PATCH v2 4/4] ARM: nommu: remove Hivecs configuration is asm
In-Reply-To: <20170122031652.13074-1-afzal.mohd.ma@gmail.com>
References: <20170122031652.13074-1-afzal.mohd.ma@gmail.com>
Message-ID: <20170122032259.13512-1-afzal.mohd.ma@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that exception based address is handled dynamically for
processors with CP15, remove Hivecs configuration in assembly.

Signed-off-by: afzal mohammed <afzal.mohd.ma@gmail.com>
---
 arch/arm/kernel/head-nommu.S | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/arm/kernel/head-nommu.S b/arch/arm/kernel/head-nommu.S
index 6b4eb27b8758..2e21e08de747 100644
--- a/arch/arm/kernel/head-nommu.S
+++ b/arch/arm/kernel/head-nommu.S
@@ -152,11 +152,6 @@ __after_proc_init:
 #ifdef CONFIG_CPU_ICACHE_DISABLE
 	bic	r0, r0, #CR_I
 #endif
-#ifdef CONFIG_CPU_HIGH_VECTOR
-	orr	r0, r0, #CR_V
-#else
-	bic	r0, r0, #CR_V
-#endif
 	mcr	p15, 0, r0, c1, c0, 0		@ write control reg
 #elif defined (CONFIG_CPU_V7M)
 	/* For V7M systems we want to modify the CCR similarly to the SCTLR */
-- 
2.11.0
