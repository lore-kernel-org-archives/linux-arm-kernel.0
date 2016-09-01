From: zijun_hu@zoho.com (zijun_hu)
Date: Thu, 1 Sep 2016 18:51:19 +0800
Subject: [PATCH 1/2] arm64: remove duplicate macro __KERNEL__ check
Message-ID: <456417d8-9167-e996-b940-82bdd4bd6fb4@zoho.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: zijun_hu <zijun_hu@htc.com>

remove duplicate macro __KERNEL__ check

Signed-off-by: zijun_hu <zijun_hu@htc.com>
---
 arch/arm64/include/asm/processor.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
index ace0a96e7d6e..df2e53d3a969 100644
--- a/arch/arm64/include/asm/processor.h
+++ b/arch/arm64/include/asm/processor.h
@@ -37,7 +37,6 @@
 #include <asm/ptrace.h>
 #include <asm/types.h>
 
-#ifdef __KERNEL__
 #define STACK_TOP_MAX		TASK_SIZE_64
 #ifdef CONFIG_COMPAT
 #define AARCH32_VECTORS_BASE	0xffff0000
@@ -49,7 +48,6 @@
 
 extern phys_addr_t arm64_dma_phys_limit;
 #define ARCH_LOW_ADDRESS_LIMIT	(arm64_dma_phys_limit - 1)
-#endif /* __KERNEL__ */
 
 struct debug_info {
 	/* Have we suspended stepping by a debugger? */
-- 
1.9.1
