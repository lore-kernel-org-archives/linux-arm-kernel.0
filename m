From: o.rempel@pengutronix.de (Oleksij Rempel)
Date: Fri,  9 Jun 2017 16:07:36 +0200
Subject: [PATCH v4 3/6] kernel/reboot.c: export pm_power_off_prepare
In-Reply-To: <20170609140739.15726-1-o.rempel@pengutronix.de>
References: <20170609140739.15726-1-o.rempel@pengutronix.de>
Message-ID: <20170609140739.15726-4-o.rempel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Export pm_power_off_prepare. It is needed to implement power off on
Freescale/NXP iMX6 based boards with external power management
integrated circuit (PMIC).

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
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
