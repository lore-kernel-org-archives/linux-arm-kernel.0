From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Sat, 3 Jun 2017 20:36:10 +0200
Subject: [PATCH 9/9] ARM: OMAP2+: Delete an error message for a failed memory
 allocation in omap_timer_init()
In-Reply-To: <e9d44aa5-9208-9ff3-46ec-cd58ac3f4696@users.sourceforge.net>
References: <e9d44aa5-9208-9ff3-46ec-cd58ac3f4696@users.sourceforge.net>
Message-ID: <a673b257-4750-2135-2c4e-bc0e5937f4b0@users.sourceforge.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 3 Jun 2017 19:23:59 +0200

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Link: http://events.linuxfoundation.org/sites/events/files/slides/LCJ16-Refactor_Strings-WSang_0.pdf
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 arch/arm/mach-omap2/timer.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
index 07dd692c4737..f6b5ccfe4653 100644
--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -693,7 +693,5 @@ static int __init omap_timer_init(struct omap_hwmod *oh, void *unused)
-	if (!pdata) {
-		pr_err("%s: No memory for [%s]\n", __func__, oh->name);
+	if (!pdata)
 		return -ENOMEM;
-	}
 
 	/*
 	 * Extract the IDs from name field in hwmod database
-- 
2.13.0
