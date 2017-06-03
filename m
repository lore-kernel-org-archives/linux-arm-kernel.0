From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Sat, 3 Jun 2017 20:29:20 +0200
Subject: [PATCH 3/9] ARM: OMAP2+: McBSP: Delete an unnecessary variable
 initialisation in omap_init_mcbsp()
In-Reply-To: <e9d44aa5-9208-9ff3-46ec-cd58ac3f4696@users.sourceforge.net>
References: <e9d44aa5-9208-9ff3-46ec-cd58ac3f4696@users.sourceforge.net>
Message-ID: <9d9bee0e-01b2-ff5d-1bb4-76b401208cd4@users.sourceforge.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 3 Jun 2017 17:54:19 +0200

The local variable "pdata" is reassigned by a statement at the beginning.
Thus omit the explicit initialisation.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 arch/arm/mach-omap2/mcbsp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/mcbsp.c b/arch/arm/mach-omap2/mcbsp.c
index fc04be74e064..53c4a30e2963 100644
--- a/arch/arm/mach-omap2/mcbsp.c
+++ b/arch/arm/mach-omap2/mcbsp.c
@@ -59,5 +59,5 @@ static int __init omap_init_mcbsp(struct omap_hwmod *oh, void *unused)
 	int id, count = 1;
 	char *name = "omap-mcbsp";
 	struct omap_hwmod *oh_device[2];
-	struct omap_mcbsp_platform_data *pdata = NULL;
+	struct omap_mcbsp_platform_data *pdata;
 	struct platform_device *pdev;
-- 
2.13.0
