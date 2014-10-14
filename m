From: alexander.stein@systec-electronic.com (Alexander Stein)
Date: Tue, 14 Oct 2014 10:59:28 +0200
Subject: [PATCH 1/2] ARM: Add printf annotation to early_print
Message-ID: <1413277169-6941-1-git-send-email-alexander.stein@systec-electronic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the printf format annotation to early_print to warn users about
incompatible formats and argument.

Signed-off-by: Alexander Stein <alexander.stein@systec-electronic.com>
---
 arch/arm/include/asm/setup.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/setup.h b/arch/arm/include/asm/setup.h
index e0adb9f..d4e06cc 100644
--- a/arch/arm/include/asm/setup.h
+++ b/arch/arm/include/asm/setup.h
@@ -22,7 +22,7 @@
 static const struct tagtable __tagtable_##fn __tag = { tag, fn }
 
 extern int arm_add_memory(u64 start, u64 size);
-extern void early_print(const char *str, ...);
+extern __printf(1, 2) void early_print(const char *str, ...);
 extern void dump_machine_table(void);
 
 #endif
-- 
2.0.4
