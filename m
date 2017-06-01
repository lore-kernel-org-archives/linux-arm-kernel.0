From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Thu, 1 Jun 2017 19:55:06 +0200
Subject: [PATCH] ARM: lpc32xx: Delete an error message for a failed memory
 allocation in lpc32xx_pm_enter()
Message-ID: <fc803eb9-32fa-cfcd-7a8e-4847434dfb7d@users.sourceforge.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 1 Jun 2017 19:50:32 +0200

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Link: http://events.linuxfoundation.org/sites/events/files/slides/LCJ16-Refactor_Strings-WSang_0.pdf
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 arch/arm/mach-lpc32xx/pm.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/arch/arm/mach-lpc32xx/pm.c b/arch/arm/mach-lpc32xx/pm.c
index 62471570d586..5a4d31488d11 100644
--- a/arch/arm/mach-lpc32xx/pm.c
+++ b/arch/arm/mach-lpc32xx/pm.c
@@ -87,12 +87,8 @@ static int lpc32xx_pm_enter(suspend_state_t state)
 
 	/* Allocate some space for temporary IRAM storage */
 	iram_swap_area = kmalloc(lpc32xx_sys_suspend_sz, GFP_KERNEL);
-	if (!iram_swap_area) {
-		printk(KERN_ERR
-		       "PM Suspend: cannot allocate memory to save portion "
-			"of SRAM\n");
+	if (!iram_swap_area)
 		return -ENOMEM;
-	}
 
 	/* Backup a small area of IRAM used for the suspend code */
 	memcpy(iram_swap_area, (void *) TEMP_IRAM_AREA,
-- 
2.13.0
