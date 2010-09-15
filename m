From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Wed, 15 Sep 2010 16:55:42 -0700
Subject: [PATCH 06/10] omap: pm-debug: Enable wakeup_timer_milliseconds
	debugfs entry
In-Reply-To: <1284594946-28963-1-git-send-email-khilman@deeprootsystems.com>
References: <1284594946-28963-1-git-send-email-khilman@deeprootsystems.com>
Message-ID: <1284594946-28963-7-git-send-email-khilman@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Santosh Shilimkar <santosh.shilimkar@ti.com>

Commit 8e2efde9 added milliseconds suspend wakeup time support but
same interface is not exported through debugfs

This patch enables the debugfs hook for wakeup_timer_milliseconds

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/pm-debug.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/pm-debug.c b/arch/arm/mach-omap2/pm-debug.c
index 655f9df..af00c17 100644
--- a/arch/arm/mach-omap2/pm-debug.c
+++ b/arch/arm/mach-omap2/pm-debug.c
@@ -638,6 +638,9 @@ static int __init pm_dbg_init(void)
 				   &sleep_while_idle, &pm_dbg_option_fops);
 	(void) debugfs_create_file("wakeup_timer_seconds", S_IRUGO | S_IWUGO, d,
 				   &wakeup_timer_seconds, &pm_dbg_option_fops);
+	(void) debugfs_create_file("wakeup_timer_milliseconds",
+			S_IRUGO | S_IWUGO, d, &wakeup_timer_milliseconds,
+			&pm_dbg_option_fops);
 	pm_dbg_init_done = 1;
 
 	return 0;
-- 
1.7.2.1
