From: jhbird.choi@gmail.com (jhbird.choi at gmail.com)
Date: Sat, 29 Oct 2011 07:56:32 +0900
Subject: [PATCH] max8997_charger: Fix unsigned value for less than zero
Message-ID: <1319842592-11334-1-git-send-email-jhbird.choi@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jonghwan Choi <jhbird.choi@gmail.com>

The 'val' is a 'unsigned char', so it is never less than zero.

Signed-off-by: Jonghwan Choi <jhbird.choi@gmail.com>
---
 drivers/power/max8997_charger.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/power/max8997_charger.c b/drivers/power/max8997_charger.c
index ffc5033..a5eb3ed 100644
--- a/drivers/power/max8997_charger.c
+++ b/drivers/power/max8997_charger.c
@@ -97,7 +97,7 @@ static __devinit int max8997_battery_probe(struct platform_device *pdev)
 		return -EINVAL;
 
 	if (pdata->eoc_mA) {
-		u8 val = (pdata->eoc_mA - 50) / 10;
+		int val = (pdata->eoc_mA - 50) / 10;
 		if (val < 0)
 			val = 0;
 		if (val > 0xf)
-- 
1.7.0.4
