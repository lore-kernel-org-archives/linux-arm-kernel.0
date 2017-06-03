From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Sat, 3 Jun 2017 20:31:10 +0200
Subject: [PATCH 5/9] ARM: OMAP2+: McBSP: Delete an error message for a failed
 memory allocation in omap_init_mcbsp()
In-Reply-To: <e9d44aa5-9208-9ff3-46ec-cd58ac3f4696@users.sourceforge.net>
References: <e9d44aa5-9208-9ff3-46ec-cd58ac3f4696@users.sourceforge.net>
Message-ID: <57bb7074-8283-23fe-6112-822bd40098dc@users.sourceforge.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 3 Jun 2017 18:03:25 +0200

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Link: http://events.linuxfoundation.org/sites/events/files/slides/LCJ16-Refactor_Strings-WSang_0.pdf
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 arch/arm/mach-omap2/mcbsp.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/mcbsp.c b/arch/arm/mach-omap2/mcbsp.c
index 408793d14fc5..0372e3358ec1 100644
--- a/arch/arm/mach-omap2/mcbsp.c
+++ b/arch/arm/mach-omap2/mcbsp.c
@@ -68,7 +68,5 @@ static int __init omap_init_mcbsp(struct omap_hwmod *oh, void *unused)
-	if (!pdata) {
-		pr_err("%s: No memory for mcbsp\n", __func__);
+	if (!pdata)
 		return -ENOMEM;
-	}
 
 	pdata->reg_step = 4;
 	if (oh->class->rev < MCBSP_CONFIG_TYPE2) {
-- 
2.13.0
