From: behanw@converseincode.com (behanw at converseincode.com)
Date: Fri,  5 Sep 2014 16:21:42 -0700
Subject: [PATCH] arm64: LLVMLinux: Add missing abort() for AARCH64
Message-ID: <1409959302-13976-1-git-send-email-behanw@converseincode.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mark Charlebois <charlebm@gmail.com>

Add missing abort for arch aarch64.

This patch makes the aarch64 kernel able to compile with gcc or clang.

Signed-off-by: Mark Charlebois <charlebm@gmail.com>
Signed-off-by: Behan Webster <behanw@converseincode.com>
---
 arch/arm64/kernel/traps.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index 02cd3f0..123cd6e 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -349,6 +349,15 @@ void __pgd_error(const char *file, int line, unsigned long val)
 	pr_crit("%s:%d: bad pgd %016lx.\n", file, line, val);
 }
 
+void abort(void)
+{
+	BUG();
+
+	/* if that doesn't kill us, halt */
+	panic("Oops failed to kill thread");
+}
+EXPORT_SYMBOL(abort);
+
 void __init trap_init(void)
 {
 	return;
-- 
1.9.1
