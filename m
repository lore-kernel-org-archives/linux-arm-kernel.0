From: shengyong1@huawei.com (Sheng Yong)
Date: Tue, 16 Sep 2014 15:06:58 +0800
Subject: [PATCH] ARM: asm: add ARM_BE8 wapper to BE8 code
Message-ID: <1410851219-13210-1-git-send-email-shengyong1@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use ARM_BE8 wrapper to code if CONFIG_CPU_BIG_ENDIAN is configured.

Signed-off-by: Sheng Yong <shengyong1@huawei.com>
---
 arch/arm/kernel/head.S |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/arm/kernel/head.S b/arch/arm/kernel/head.S
index 664eee8..35ef767 100644
--- a/arch/arm/kernel/head.S
+++ b/arch/arm/kernel/head.S
@@ -199,9 +199,7 @@ __create_page_tables:
 	bne	1b
 
 	add	r4, r4, #0x1000			@ point to the PMD tables
-#ifdef CONFIG_CPU_ENDIAN_BE8
-	add	r4, r4, #4			@ we only write the bottom word
-#endif
+ARM_BE8(add	r4, r4, #4)			@ we only write the bottom word
 #endif
 
 	ldr	r7, [r10, #PROCINFO_MM_MMUFLAGS] @ mm_mmuflags
-- 
1.7.9.5
