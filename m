From: pebolle@tiscali.nl (Paul Bolle)
Date: Fri, 16 May 2014 17:25:10 +0200
Subject: [PATCH] ARM: remove check for CONFIG_CPU_ICACHE_STREAMING_DISABLE
Message-ID: <1400253910.20342.52.camel@x220>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A check for CONFIG_CPU_ICACHE_STREAMING_DISABLE was added in v2.6.4. But
the related Kconfig symbol was never added to the tree. So that check
has evaluated to false for a decade. Let's remove that check and the
single line it guards.

Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
---
Untested.

 arch/arm/mm/proc-arm925.S | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm/mm/proc-arm925.S b/arch/arm/mm/proc-arm925.S
index 97448c3acf38..3c31f32153ad 100644
--- a/arch/arm/mm/proc-arm925.S
+++ b/arch/arm/mm/proc-arm925.S
@@ -441,9 +441,6 @@ ENTRY(cpu_arm925_set_pte_ext)
 	.type	__arm925_setup, #function
 __arm925_setup:
 	mov	r0, #0
-#if defined(CONFIG_CPU_ICACHE_STREAMING_DISABLE)
-        orr     r0,r0,#1 << 7
-#endif
 
 	/* Transparent on, D-cache clean & flush mode. See  NOTE2 above */
         orr     r0,r0,#1 << 1			@ transparent mode on
-- 
1.9.0
