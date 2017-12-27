From: pavel@ucw.cz (Pavel Machek)
Date: Wed, 27 Dec 2017 10:20:42 +0100
Subject: [PATCH] bq24190: Simplify code in property_is_writeable
Message-ID: <20171227092041.GA14507@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Simplify function that should be trivial.

Signed-off-by: Pavel machek <pavel@ucw.cz>

diff --git a/drivers/power/supply/bq24190_charger.c b/drivers/power/supply/bq24190_charger.c
index 35ff406..4ea8f0a 100644
--- a/drivers/power/supply/bq24190_charger.c
+++ b/drivers/power/supply/bq24190_charger.c
@@ -1193,8 +1193,6 @@ static int bq24190_charger_set_property(struct power_supply *psy,
 static int bq24190_charger_property_is_writeable(struct power_supply *psy,
 		enum power_supply_property psp)
 {
-	int ret;
-
 	switch (psp) {
 	case POWER_SUPPLY_PROP_ONLINE:
 	case POWER_SUPPLY_PROP_TEMP_ALERT_MAX:
@@ -1202,13 +1200,10 @@ static int bq24190_charger_property_is_writeable(struct power_supply *psy,
 	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT:
 	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE:
 	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
-		ret = 1;
-		break;
+		return 1;
 	default:
-		ret = 0;
+		return 0;
 	}
-
-	return ret;
 }
 
 static void bq24190_input_current_limit_work(struct work_struct *work)

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171227/b4e3f407/attachment-0001.sig>
