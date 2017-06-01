From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Thu, 1 Jun 2017 22:51:04 +0200
Subject: [PATCH 4/5] ARM: OMAP1: Delete an error message for a failed memory
 allocation in omap1_dm_timer_init()
In-Reply-To: <85e2ec7f-f650-28a2-6cc5-0b4b52e44183@users.sourceforge.net>
References: <85e2ec7f-f650-28a2-6cc5-0b4b52e44183@users.sourceforge.net>
Message-ID: <3a130a87-96e7-792b-29b7-f43f93ae78bc@users.sourceforge.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 1 Jun 2017 22:04:29 +0200

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Link: http://events.linuxfoundation.org/sites/events/files/slides/LCJ16-Refactor_Strings-WSang_0.pdf
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 arch/arm/mach-omap1/timer.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/mach-omap1/timer.c b/arch/arm/mach-omap1/timer.c
index 06c5ba7574a5..637f8c9d9f10 100644
--- a/arch/arm/mach-omap1/timer.c
+++ b/arch/arm/mach-omap1/timer.c
@@ -136,6 +136,4 @@ static int __init omap1_dm_timer_init(void)
 		if (!pdata) {
-			dev_err(&pdev->dev, "%s: Failed to allocate pdata.\n",
-				__func__);
 			ret = -ENOMEM;
 			goto err_free_pdata;
 		}
-- 
2.13.0
