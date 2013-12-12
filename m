From: geoff@infradead.org (Geoff Levand)
Date: Thu, 12 Dec 2013 20:39:46 +0000
Subject: [PATCH 5/5] arm64: Add LOAD_OFFSET symbol for linker scripts
In-Reply-To: <cover.1386879684.git.geoff@infradead.org>
References: <cover.1386879684.git.geoff@infradead.org>
Message-ID: <92660d1b81279aa6784a33eff2f102e78d883931.1386879684.git.geoff@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a definition for the LOAD_OFFSET symbol used in the linker
scripts.  LOAD_OFFSET is used to generate the load address of
the section.

Signed-off-by: Geoff Levand <geoff@infradead.org> for Huawei, Linaro
---
 arch/arm64/include/asm/memory.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
index 3776217..1994c56 100644
--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -52,6 +52,8 @@
 #define EARLYCON_IOBASE		(MODULES_VADDR - SZ_4M)
 #define TASK_SIZE_64		(UL(1) << VA_BITS)
 
+#define LOAD_OFFSET		(PAGE_OFFSET)
+
 #ifdef CONFIG_COMPAT
 #define TASK_SIZE_32		UL(0x100000000)
 #define TASK_SIZE		(test_thread_flag(TIF_32BIT) ? \
-- 
1.8.1.2
