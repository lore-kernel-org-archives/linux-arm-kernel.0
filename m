From: deller@gmx.de (Helge Deller)
Date: Wed,  6 Sep 2017 22:27:48 +0200
Subject: [PATCH 01/14] arm: Use %pS printk format for symbols from direct
 addresses
In-Reply-To: <1504729681-3504-1-git-send-email-deller@gmx.de>
References: <1504729681-3504-1-git-send-email-deller@gmx.de>
Message-ID: <1504729681-3504-2-git-send-email-deller@gmx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the %pS printk format for printing symbols from direct addresses.
On ARM there is actually no difference between %pS and %pF, but for consistency
throughout the kernel fix the wrong usage here too.

Signed-off-by: Helge Deller <deller@gmx.de>
Cc: Russell King <linux@armlinux.org.uk>
Cc: linux-arm-kernel at lists.infradead.org
---
 arch/arm/mm/alignment.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mm/alignment.c b/arch/arm/mm/alignment.c
index 2c96190..20d721f 100644
--- a/arch/arm/mm/alignment.c
+++ b/arch/arm/mm/alignment.c
@@ -133,7 +133,7 @@ static const char *usermode_action[] = {
 static int alignment_proc_show(struct seq_file *m, void *v)
 {
 	seq_printf(m, "User:\t\t%lu\n", ai_user);
-	seq_printf(m, "System:\t\t%lu (%pF)\n", ai_sys, ai_sys_last_pc);
+	seq_printf(m, "System:\t\t%lu (%pS)\n", ai_sys, ai_sys_last_pc);
 	seq_printf(m, "Skipped:\t%lu\n", ai_skipped);
 	seq_printf(m, "Half:\t\t%lu\n", ai_half);
 	seq_printf(m, "Word:\t\t%lu\n", ai_word);
-- 
2.1.0
