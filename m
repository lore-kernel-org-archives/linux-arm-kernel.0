From: siccegge@cs.fau.de (Christoph Egger)
Date: Wed, 30 Jun 2010 18:04:01 +0200
Subject: [PATCH 32/33] Removing dead CPU_ICACHE_STREAMING_DISABLE
In-Reply-To: <cover.1277911345.git.siccegge@cs.fau.de>
References: <cover.1277911345.git.siccegge@cs.fau.de>
Message-ID: <c09196cb2149f5a1a845ead405b73add3c1a804f.1277911346.git.siccegge@cs.fau.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CPU_ICACHE_STREAMING_DISABLE doesn't exist in Kconfig, therefore
removing all references for it from the source code.

Signed-off-by: Christoph Egger <siccegge@cs.fau.de>
---
 arch/arm/mm/proc-arm925.S |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mm/proc-arm925.S b/arch/arm/mm/proc-arm925.S
index 3c6cffe..2a3bb73 100644
--- a/arch/arm/mm/proc-arm925.S
+++ b/arch/arm/mm/proc-arm925.S
@@ -437,9 +437,6 @@ ENTRY(cpu_arm925_set_pte_ext)
 	.type	__arm925_setup, #function
 __arm925_setup:
 	mov	r0, #0
-#if defined(CONFIG_CPU_ICACHE_STREAMING_DISABLE)
-        orr     r0,r0,#1 << 7
-#endif
 
 	/* Transparent on, D-cache clean & flush mode. See  NOTE2 above */
         orr     r0,r0,#1 << 1			@ transparent mode on
-- 
1.7.0.4
