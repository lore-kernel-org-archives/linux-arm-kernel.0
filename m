From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 15 Feb 2013 12:45:07 +0000
Subject: [PATCH 37/40] pm2301-charger: Reference put missing after access
In-Reply-To: <1360932310-30065-1-git-send-email-lee.jones@linaro.org>
References: <1360932310-30065-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1360932310-30065-38-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rupesh Kumar <rupesh.kumar@stericsson.com>

Added missing pm_runtime_put_sync in read & write.

Signed-off-by: Rupesh Kumar <rupesh.kumar@stericsson.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Reviewed-by: Sandeep TRIPATHY <sandeep.tripathy@stericsson.com>
Reviewed-by: Philippe LANGLAIS <philippe.langlais@stericsson.com>
---
 drivers/power/pm2301_charger.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/power/pm2301_charger.c b/drivers/power/pm2301_charger.c
index ea9870d..af12af8 100644
--- a/drivers/power/pm2301_charger.c
+++ b/drivers/power/pm2301_charger.c
@@ -139,6 +139,8 @@ static int pm2xxx_reg_read(struct pm2xxx_charger *pm2, int reg, u8 *val)
 	else
 		ret = 0;
 
+	pm_runtime_put_sync(pm2->dev);
+
 	return ret;
 }
 
@@ -156,6 +158,8 @@ static int pm2xxx_reg_write(struct pm2xxx_charger *pm2, int reg, u8 val)
 	else
 		ret = 0;
 
+	pm_runtime_put_sync(pm2->dev);
+
 	return ret;
 }
 
-- 
1.7.10.4
