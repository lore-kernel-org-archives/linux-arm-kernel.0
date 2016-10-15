From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Sat, 15 Oct 2016 22:54:49 +0200
Subject: [PATCH 3/3] ARM-OMAP2+: pm-debug: Use seq_putc() in two functions
In-Reply-To: <e86a5ded-a6e9-1b40-be1a-98fffef0abb5@users.sourceforge.net>
References: <e86a5ded-a6e9-1b40-be1a-98fffef0abb5@users.sourceforge.net>
Message-ID: <3b54e75d-eeee-5cce-5733-89b2750ab8c7@users.sourceforge.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 15 Oct 2016 22:30:44 +0200

A single character (line break) should be put into a sequence at the end.
Thus use the corresponding function "seq_putc".

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 arch/arm/mach-omap2/pm-debug.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/pm-debug.c b/arch/arm/mach-omap2/pm-debug.c
index 0b33986..003a6cb 100644
--- a/arch/arm/mach-omap2/pm-debug.c
+++ b/arch/arm/mach-omap2/pm-debug.c
@@ -114,8 +114,7 @@ static int pwrdm_dbg_show_counter(struct powerdomain *pwrdm, void *user)
 		seq_printf(s, ",RET-MEMBANK%d-OFF:%d", i + 1,
 				pwrdm->ret_mem_off_counter[i]);
 
-	seq_printf(s, "\n");
-
+	seq_putc(s, '\n');
 	return 0;
 }
 
@@ -138,7 +137,7 @@ static int pwrdm_dbg_show_timer(struct powerdomain *pwrdm, void *user)
 		seq_printf(s, ",%s:%lld", pwrdm_state_names[i],
 			pwrdm->state_timer[i]);
 
-	seq_printf(s, "\n");
+	seq_putc(s, '\n');
 	return 0;
 }
 
-- 
2.10.1
