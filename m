From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Sat, 3 Dec 2016 21:56:48 +0100
Subject: [PATCH] ARM: OMAP2+: PRM: Delete an error message for a failed memory
 allocation
Message-ID: <6212b730-8e09-bf87-2a6b-23df9bc43e2d@users.sourceforge.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 3 Dec 2016 21:46:02 +0100

Omit an extra message for a memory allocation failure in this function.

Link: http://events.linuxfoundation.org/sites/events/files/slides/LCJ16-Refactor_Strings-WSang_0.pdf
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 arch/arm/mach-omap2/prm_common.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/prm_common.c b/arch/arm/mach-omap2/prm_common.c
index 5b2f5138d938..2b138b65129a 100644
--- a/arch/arm/mach-omap2/prm_common.c
+++ b/arch/arm/mach-omap2/prm_common.c
@@ -295,10 +295,8 @@ int omap_prcm_register_chain_handler(struct omap_prcm_irq_setup *irq_setup)
 		GFP_KERNEL);
 
 	if (!prcm_irq_chips || !prcm_irq_setup->saved_mask ||
-	    !prcm_irq_setup->priority_mask) {
-		pr_err("PRCM: kzalloc failed\n");
+	    !prcm_irq_setup->priority_mask)
 		goto err;
-	}
 
 	memset(mask, 0, sizeof(mask));
 
-- 
2.11.0
