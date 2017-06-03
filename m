From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Sat, 3 Jun 2017 22:08:55 +0200
Subject: [PATCH 1/3] ARM: pxa: Delete an error message for a failed memory
 allocation in pxa_pm_init()
In-Reply-To: <f50bf224-7fdc-f9ba-b73b-0b3c11df50dc@users.sourceforge.net>
References: <f50bf224-7fdc-f9ba-b73b-0b3c11df50dc@users.sourceforge.net>
Message-ID: <9fb09355-13c4-cad3-a539-55ae7979aa11@users.sourceforge.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 3 Jun 2017 21:34:48 +0200

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Link: http://events.linuxfoundation.org/sites/events/files/slides/LCJ16-Refactor_Strings-WSang_0.pdf
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 arch/arm/mach-pxa/pm.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/arm/mach-pxa/pm.c b/arch/arm/mach-pxa/pm.c
index e7450fb49d24..f2237f471750 100644
--- a/arch/arm/mach-pxa/pm.c
+++ b/arch/arm/mach-pxa/pm.c
@@ -110,7 +110,5 @@ static int __init pxa_pm_init(void)
-	if (!sleep_save) {
-		printk(KERN_ERR "failed to alloc memory for pm save\n");
+	if (!sleep_save)
 		return -ENOMEM;
-	}
 
 	suspend_set_ops(&pxa_pm_ops);
 	return 0;
-- 
2.13.0
