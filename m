From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 15 Feb 2013 12:45:04 +0000
Subject: [PATCH 34/40] pm2301-charger: Charging LED control for pm2301
In-Reply-To: <1360932310-30065-1-git-send-email-lee.jones@linaro.org>
References: <1360932310-30065-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1360932310-30065-35-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rupesh Kumar <rupesh.kumar@stericsson.com>

The LED Indicator feature allows indicating through a led when the
PM2301 battery charging is active. SW shall not disable this LED.

Signed-off-by: Rupesh Kumar <rupesh.kumar@stericsson.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Reviewed-by: Marcus COOPER <marcus.xm.cooper@stericsson.com>
Reviewed-by: Philippe LANGLAIS <philippe.langlais@stericsson.com>
---
 drivers/power/pm2301_charger.c |    4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/power/pm2301_charger.c b/drivers/power/pm2301_charger.c
index eed6034..f99a0c8 100644
--- a/drivers/power/pm2301_charger.c
+++ b/drivers/power/pm2301_charger.c
@@ -706,10 +706,6 @@ static int pm2xxx_charging_init(struct pm2xxx_charger *pm2)
 	ret = pm2xxx_reg_write(pm2, PM2XXX_BATT_LOW_LEV_COMP_REG,
 		PM2XXX_VBAT_LOW_MONITORING_ENA);
 
-	/* Disable LED */
-	ret = pm2xxx_reg_write(pm2, PM2XXX_LED_CTRL_REG,
-		PM2XXX_LED_SELECT_DIS);
-
 	return ret;
 }
 
-- 
1.7.10.4
