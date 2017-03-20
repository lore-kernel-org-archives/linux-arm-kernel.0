From: quentin.schulz@free-electrons.com (Quentin Schulz)
Date: Mon, 20 Mar 2017 09:16:45 +0100
Subject: [RESEND PATCH v4 1/9] mfd: axp20x: correct name of temperature data
 ADC registers
In-Reply-To: <20170320081653.8884-1-quentin.schulz@free-electrons.com>
References: <20170320081653.8884-1-quentin.schulz@free-electrons.com>
Message-ID: <20170320081653.8884-2-quentin.schulz@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The registers 0x56 and 0x57 of AXP22X PMIC store the value of the
internal temperature of the PMIC.

This patch modifies the name of these registers from AXP22X_PMIC_ADC_H/L
to AXP22X_PMIC_TEMP_H/L so their purpose is clearer.

Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
Acked-by: Chen-Yu Tsai <wens@csie.org>
Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
---

added in v2

 drivers/mfd/axp20x.c       | 2 +-
 include/linux/mfd/axp20x.h | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
index 0512900..e02edf1 100644
--- a/drivers/mfd/axp20x.c
+++ b/drivers/mfd/axp20x.c
@@ -101,7 +101,7 @@ static const struct regmap_range axp22x_volatile_ranges[] = {
 	regmap_reg_range(AXP20X_PWR_INPUT_STATUS, AXP20X_PWR_OP_MODE),
 	regmap_reg_range(AXP20X_IRQ1_EN, AXP20X_IRQ5_STATE),
 	regmap_reg_range(AXP22X_GPIO_STATE, AXP22X_GPIO_STATE),
-	regmap_reg_range(AXP22X_PMIC_ADC_H, AXP20X_IPSOUT_V_HIGH_L),
+	regmap_reg_range(AXP22X_PMIC_TEMP_H, AXP20X_IPSOUT_V_HIGH_L),
 	regmap_reg_range(AXP20X_FG_RES, AXP20X_FG_RES),
 };
 
diff --git a/include/linux/mfd/axp20x.h b/include/linux/mfd/axp20x.h
index 0d9a1ff..dc8798c 100644
--- a/include/linux/mfd/axp20x.h
+++ b/include/linux/mfd/axp20x.h
@@ -228,8 +228,8 @@ enum axp20x_variants {
 #define AXP20X_OCV_MAX			0xf
 
 /* AXP22X specific registers */
-#define AXP22X_PMIC_ADC_H		0x56
-#define AXP22X_PMIC_ADC_L		0x57
+#define AXP22X_PMIC_TEMP_H		0x56
+#define AXP22X_PMIC_TEMP_L		0x57
 #define AXP22X_TS_ADC_H			0x58
 #define AXP22X_TS_ADC_L			0x59
 #define AXP22X_BATLOW_THRES1		0xe6
-- 
2.9.3
