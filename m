From: srinivas.kandagatla@st.com (Srinivas KANDAGATLA)
Date: Wed, 10 Oct 2012 19:31:00 +0100
Subject: [PATCH 3.6.0- 5/6] ARM/omap: use module_platform_driver macro
Message-ID: <1349893860-7515-1-git-send-email-srinivas.kandagatla@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Srinivas Kandagatla <srinivas.kandagatla@st.com>

This patch removes some code duplication by using
module_platform_driver.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@st.com>
---
 arch/arm/plat-omap/dmtimer.c |   13 +------------
 1 files changed, 1 insertions(+), 12 deletions(-)

diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
index 938b50a..c89fc6a 100644
--- a/arch/arm/plat-omap/dmtimer.c
+++ b/arch/arm/plat-omap/dmtimer.c
@@ -786,19 +786,8 @@ static struct platform_driver omap_dm_timer_driver = {
 	},
 };
 
-static int __init omap_dm_timer_driver_init(void)
-{
-	return platform_driver_register(&omap_dm_timer_driver);
-}
-
-static void __exit omap_dm_timer_driver_exit(void)
-{
-	platform_driver_unregister(&omap_dm_timer_driver);
-}
-
 early_platform_init("earlytimer", &omap_dm_timer_driver);
-module_init(omap_dm_timer_driver_init);
-module_exit(omap_dm_timer_driver_exit);
+module_platform_driver(omap_dm_timer_driver);
 
 MODULE_DESCRIPTION("OMAP Dual-Mode Timer Driver");
 MODULE_LICENSE("GPL");
-- 
1.7.0.4
