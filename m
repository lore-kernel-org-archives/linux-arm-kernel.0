From: joe@perches.com (Joe Perches)
Date: Fri,  5 Nov 2010 16:12:34 -0700
Subject: [PATCH 1/7] arch/arm/kernel/traps.c: Convert sprintf_symbol to %pS
In-Reply-To: <1288998760-11775-1-git-send-email-joe@perches.com>
References: <1288998760-11775-1-git-send-email-joe@perches.com>
Message-ID: <1288998760-11775-2-git-send-email-joe@perches.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Joe Perches <joe@perches.com>
---
 arch/arm/kernel/traps.c |    5 +----
 1 files changed, 1 insertions(+), 4 deletions(-)

diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
index cda78d5..446aee9 100644
--- a/arch/arm/kernel/traps.c
+++ b/arch/arm/kernel/traps.c
@@ -53,10 +53,7 @@ static void dump_mem(const char *, const char *, unsigned long, unsigned long);
 void dump_backtrace_entry(unsigned long where, unsigned long from, unsigned long frame)
 {
 #ifdef CONFIG_KALLSYMS
-	char sym1[KSYM_SYMBOL_LEN], sym2[KSYM_SYMBOL_LEN];
-	sprint_symbol(sym1, where);
-	sprint_symbol(sym2, from);
-	printk("[<%08lx>] (%s) from [<%08lx>] (%s)\n", where, sym1, from, sym2);
+	printk("[<%08lx>] (%pS) from [<%08lx>] (%pS)\n", where, (void *)where, from, (void *)from);
 #else
 	printk("Function entered at [<%08lx>] from [<%08lx>]\n", where, from);
 #endif
-- 
1.7.3.2.146.gca209
