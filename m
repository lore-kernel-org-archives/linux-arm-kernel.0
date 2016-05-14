From: hdegoede@redhat.com (Hans de Goede)
Date: Sat, 14 May 2016 19:51:28 +0200
Subject: [PATCH 2/3] mfd: axp20x: Extend axp22x_volatile_ranges
In-Reply-To: <1463248289-16456-1-git-send-email-hdegoede@redhat.com>
References: <1463248289-16456-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1463248289-16456-2-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The axp22x pmic has a bunch of volatile registers besides the interrupt
ones, extend axp22x_volatile_ranges with these.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/mfd/axp20x.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
index e4e3297..ca04361 100644
--- a/drivers/mfd/axp20x.c
+++ b/drivers/mfd/axp20x.c
@@ -93,7 +93,10 @@ static const struct regmap_range axp22x_writeable_ranges[] = {
 };
 
 static const struct regmap_range axp22x_volatile_ranges[] = {
+	regmap_reg_range(AXP20X_PWR_INPUT_STATUS, AXP20X_PWR_OP_MODE),
 	regmap_reg_range(AXP20X_IRQ1_EN, AXP20X_IRQ5_STATE),
+	regmap_reg_range(AXP22X_GPIO_STATE, AXP22X_GPIO_STATE),
+	regmap_reg_range(AXP20X_FG_RES, AXP20X_FG_RES),
 };
 
 static const struct regmap_access_table axp22x_writeable_table = {
-- 
2.7.4
