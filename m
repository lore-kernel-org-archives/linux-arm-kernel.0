From: jochen@scram.de (Jochen Friedrich)
Date: Sat, 19 Nov 2011 19:26:37 +0100
Subject: [PATCH] ARM: sa1100: collie: Remove irq_to_gpio from power driver
Message-ID: <1321727197-26686-1-git-send-email-jochen@scram.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since 9d08d5d77a355510c2f5657c86b0a4b25acfe72c, irq_to_gpio() is no
longer available but still in use by collie_battery.c. As it's just
for a debug message, just get rid of this call.

Signed-off-by: Jochen Friedrich <jochen@scram.de>
---
 drivers/power/collie_battery.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/power/collie_battery.c b/drivers/power/collie_battery.c
index 548d263..7a40fce 100644
--- a/drivers/power/collie_battery.c
+++ b/drivers/power/collie_battery.c
@@ -146,7 +146,7 @@ static void collie_bat_external_power_changed(struct power_supply *psy)
 
 static irqreturn_t collie_bat_gpio_isr(int irq, void *data)
 {
-	pr_info("collie_bat_gpio irq: %d\n", gpio_get_value(irq_to_gpio(irq)));
+	pr_info("collie_bat_gpio irq\n");
 	schedule_work(&bat_work);
 	return IRQ_HANDLED;
 }
-- 
1.7.7.3
