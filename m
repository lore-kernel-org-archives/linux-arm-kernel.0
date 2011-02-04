From: segoon@openwall.com (Vasiliy Kulikov)
Date: Fri,  4 Feb 2011 15:23:16 +0300
Subject: [PATCH 02/20] mach-omap2: pm: world-writable debugfs timer files
In-Reply-To: <cover.1296818921.git.segoon@openwall.com>
References: <cover.1296818921.git.segoon@openwall.com>
Message-ID: <aabede4db6c913bc7ab7c289d09eb272594e2290.1296818921.git.segoon@openwall.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Don't allow all users to change timer settings.

Signed-off-by: Vasiliy Kulikov <segoon@openwall.com>
---
 Cannot compile the driver, so it is not tested at all.

 arch/arm/mach-omap2/pm-debug.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/pm-debug.c b/arch/arm/mach-omap2/pm-debug.c
index 125f565..a5a83b3 100644
--- a/arch/arm/mach-omap2/pm-debug.c
+++ b/arch/arm/mach-omap2/pm-debug.c
@@ -637,14 +637,14 @@ static int __init pm_dbg_init(void)
 
 		}
 
-	(void) debugfs_create_file("enable_off_mode", S_IRUGO | S_IWUGO, d,
+	(void) debugfs_create_file("enable_off_mode", S_IRUGO | S_IWUSR, d,
 				   &enable_off_mode, &pm_dbg_option_fops);
-	(void) debugfs_create_file("sleep_while_idle", S_IRUGO | S_IWUGO, d,
+	(void) debugfs_create_file("sleep_while_idle", S_IRUGO | S_IWUSR, d,
 				   &sleep_while_idle, &pm_dbg_option_fops);
-	(void) debugfs_create_file("wakeup_timer_seconds", S_IRUGO | S_IWUGO, d,
+	(void) debugfs_create_file("wakeup_timer_seconds", S_IRUGO | S_IWUSR, d,
 				   &wakeup_timer_seconds, &pm_dbg_option_fops);
 	(void) debugfs_create_file("wakeup_timer_milliseconds",
-			S_IRUGO | S_IWUGO, d, &wakeup_timer_milliseconds,
+			S_IRUGO | S_IWUSR, d, &wakeup_timer_milliseconds,
 			&pm_dbg_option_fops);
 	pm_dbg_init_done = 1;
 
-- 
1.7.0.4
