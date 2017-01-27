From: quentin.schulz@free-electrons.com (Quentin Schulz)
Date: Fri, 27 Jan 2017 09:54:50 +0100
Subject: [PATCH v2 17/25] mfd: axp20x: add CHRG_CTRL1/2/3 to writeable regs
 for AXP20X/AXP22X
In-Reply-To: <20170127085458.18270-1-quentin.schulz@free-electrons.com>
References: <20170127085458.18270-1-quentin.schulz@free-electrons.com>
Message-ID: <20170127085458.18270-18-quentin.schulz@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The CHRG_CTRL1 and CHRG_CTRL2 registers are made for controlling
different battery charging settings such as the constant current charge
value.

The AXP22X also have a third register CHRG_CTRL3 which has settings for
battery charging too.

This adds the CHRG_CTRL1, CHRG_CTRL2 and CHRG_CTRL3 registers to the
list of writeable registers for AXP20X and AXP22X PMICs.

Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
---

v2:
 - added AXP20X_CHRG_CTRL2 and AXP20X_CHRG_CTRL3 to the writeable
 registers table,
 - removed added reg range for ADC data in volatile regs range,

 drivers/mfd/axp20x.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
index 7607c30..8210623 100644
--- a/drivers/mfd/axp20x.c
+++ b/drivers/mfd/axp20x.c
@@ -66,6 +66,7 @@ static const struct regmap_access_table axp152_volatile_table = {
 static const struct regmap_range axp20x_writeable_ranges[] = {
 	regmap_reg_range(AXP20X_DATACACHE(0), AXP20X_IRQ5_STATE),
 	regmap_reg_range(AXP20X_VBUS_IPSOUT_MGMT, AXP20X_VBUS_IPSOUT_MGMT),
+	regmap_reg_range(AXP20X_CHRG_CTRL1, AXP20X_CHRG_CTRL2),
 	regmap_reg_range(AXP20X_DCDC_MODE, AXP20X_FG_RES),
 	regmap_reg_range(AXP20X_RDC_H, AXP20X_OCV(AXP20X_OCV_MAX)),
 };
@@ -94,6 +95,7 @@ static const struct regmap_access_table axp20x_volatile_table = {
 static const struct regmap_range axp22x_writeable_ranges[] = {
 	regmap_reg_range(AXP20X_DATACACHE(0), AXP20X_IRQ5_STATE),
 	regmap_reg_range(AXP20X_VBUS_IPSOUT_MGMT, AXP20X_VBUS_IPSOUT_MGMT),
+	regmap_reg_range(AXP20X_CHRG_CTRL1, AXP22X_CHRG_CTRL3),
 	regmap_reg_range(AXP20X_DCDC_MODE, AXP22X_BATLOW_THRES1),
 };
 
-- 
2.9.3
