From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 23 Jul 2015 12:37:58 +0200
Subject: [PATCH v2] thermal: consistently use int for temperatures
In-Reply-To: <744357E9AAD1214791ACBA4B0B9092630153E699@SHSMSX101.ccr.corp.intel.com>
References: <1437463292-24844-1-git-send-email-s.hauer@pengutronix.de>
 <9hhk2tteqb3.fsf@e105922-lin.cambridge.arm.com>
 <744357E9AAD1214791ACBA4B0B9092630153E699@SHSMSX101.ccr.corp.intel.com>
Message-ID: <20150723103758.GI18700@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Zhang,

On Tue, Jul 21, 2015 at 01:35:31PM +0000, Zhang, Rui wrote:
> > >
> Patch applied.

Thanks for applying. I missed to convert another place, so we get a new
compiler warning. The attached patch fixes this (suitable for git rebase
--autosquash). Please let me know if you can handle this or if you
prefer a new patch instead.

Thanks
 Sascha


-----------------------------8<-------------------------------------

>From 4907a7c32fd16eaf9f31d9f904276c9a0176b717 Mon Sep 17 00:00:00 2001
From: Sascha Hauer <s.hauer@pengutronix.de>
Date: Thu, 23 Jul 2015 12:32:31 +0200
Subject: [PATCH] fixup! thermal: consistently use int for temperatures
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

fixes:
drivers/power/charger-manager.c: In function ?cm_get_battery_temperature?:
drivers/power/charger-manager.c:622:45: warning: passing argument 2 of ?thermal_zone_get_temp? from incompatible pointer type
   ret = thermal_zone_get_temp(cm->tzd_batt, (unsigned long *)temp);

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/power/charger-manager.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/charger-manager.c b/drivers/power/charger-manager.c
index 1c202cc..907293e 100644
--- a/drivers/power/charger-manager.c
+++ b/drivers/power/charger-manager.c
@@ -619,7 +619,7 @@ static int cm_get_battery_temperature(struct charger_manager *cm,
 
 #ifdef CONFIG_THERMAL
 	if (cm->tzd_batt) {
-		ret = thermal_zone_get_temp(cm->tzd_batt, (unsigned long *)temp);
+		ret = thermal_zone_get_temp(cm->tzd_batt, temp);
 		if (!ret)
 			/* Calibrate temperature unit */
 			*temp /= 100;
-- 
2.1.4


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
