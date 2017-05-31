From: o.rempel@pengutronix.de (Oleksij Rempel)
Date: Wed, 31 May 2017 08:14:54 +0200
Subject: [PATCH v2 3/6] kernel/reboot.c: export pm_power_off_prepare
In-Reply-To: <20170531061457.23744-1-o.rempel@pengutronix.de>
References: <20170531061457.23744-1-o.rempel@pengutronix.de>
Message-ID: <20170531061457.23744-4-o.rempel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

we need it to preconfigure PMIC to properly power off the system.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: kernel at pengutronix.de
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-kernel at vger.kernel.org
---
 kernel/reboot.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/reboot.c b/kernel/reboot.c
index bd30a973fe94..a6903bf772c7 100644
--- a/kernel/reboot.c
+++ b/kernel/reboot.c
@@ -49,6 +49,7 @@ int reboot_force;
  */
 
 void (*pm_power_off_prepare)(void);
+EXPORT_SYMBOL(pm_power_off_prepare);
 
 /**
  *	emergency_restart - reboot the system
-- 
2.11.0
