From: afzal.mohd.ma@gmail.com (afzal mohammed)
Date: Sat,  7 Jan 2017 22:51:30 +0530
Subject: [PATCH WIP 2/4] ARM: nommu: remove Hivecs configuration is asm
In-Reply-To: <20170107171339.GA5044@afzalpc>
References: <20170107171339.GA5044@afzalpc>
Message-ID: <20170107172130.6343-1-afzal.mohd.ma@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that exception based address is handled dynamically for
processors with CP15, remove Hivecs configuration in assembly.

Signed-off-by: afzal mohammed <afzal.mohd.ma@gmail.com>
---
 arch/arm/kernel/head-nommu.S | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/arm/kernel/head-nommu.S b/arch/arm/kernel/head-nommu.S
index 2ab026ffc270..e0565d73e49e 100644
--- a/arch/arm/kernel/head-nommu.S
+++ b/arch/arm/kernel/head-nommu.S
@@ -162,11 +162,6 @@ ENDPROC(secondary_startup_arm)
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
