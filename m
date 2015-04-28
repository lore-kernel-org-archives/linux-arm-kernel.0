From: valentinrothberg@gmail.com (Valentin Rothberg)
Date: Tue, 28 Apr 2015 18:45:29 +0200
Subject: [PATCH] arch/arm/mm/proc-arm925.S: remove dead #ifdef block
Message-ID: <1430239529-15726-1-git-send-email-valentinrothberg@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The block could never be compiled;  CPU_ICACHE_STREAMING_DISABLE has not
been defined in Kconfig since the very first Git commit.  Hence, we can
safely remove the entire block.

Signed-off-by: Valentin Rothberg <valentinrothberg@gmail.com>
---
There is a similar looking option 'CPU_ICACHE_DISABLE'.  However, I
decided to remove the entire block since it could not be compiled for
such a long time.

I detected this issue with scripts/checkkconfigsymbols.py
---
 arch/arm/mm/proc-arm925.S | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm/mm/proc-arm925.S b/arch/arm/mm/proc-arm925.S
index ede8c54ab4aa..32a47cc19076 100644
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
2.1.4
