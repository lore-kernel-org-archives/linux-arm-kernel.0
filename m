From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 17 Sep 2012 12:13:22 -0700
Subject: [PATCH] ARM: msm: Silence warning when CONFIG_MMC=n
Message-ID: <1347909202-14773-1-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

arch/arm/mach-msm/board-trout.c:67:6: warning: unused variable 'rc'

Just drop the #ifdef and do this unconditionally.

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 arch/arm/mach-msm/board-trout.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm/mach-msm/board-trout.c b/arch/arm/mach-msm/board-trout.c
index 4ba0800..7861c1b 100644
--- a/arch/arm/mach-msm/board-trout.c
+++ b/arch/arm/mach-msm/board-trout.c
@@ -67,12 +67,9 @@ static void __init trout_init(void)
 
 	platform_add_devices(devices, ARRAY_SIZE(devices));
 
-#ifdef CONFIG_MMC
         rc = trout_init_mmc(system_rev);
         if (rc)
                 printk(KERN_CRIT "%s: MMC init failure (%d)\n", __func__, rc);
-#endif
-
 }
 
 static struct map_desc trout_io_desc[] __initdata = {
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
