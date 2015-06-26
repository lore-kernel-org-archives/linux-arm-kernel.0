From: vaibhav.hiremath@linaro.org (Vaibhav Hiremath)
Date: Fri, 26 Jun 2015 18:38:11 +0530
Subject: [PATCH] mfd: 880m80x: Make use of BIT() macro
Message-ID: <1435324091-2196-1-git-send-email-vaibhav.hiremath@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Instead of hard coding the shift for bit definition, use
BIT() macro.

Signed-off-by: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
---
Boot tested on PXA1928 based platform.
Note that all upcoming patches will be on top of this patch now.

 include/linux/mfd/88pm80x.h | 162 ++++++++++++++++++++++----------------------
 1 file changed, 81 insertions(+), 81 deletions(-)

diff --git a/include/linux/mfd/88pm80x.h b/include/linux/mfd/88pm80x.h
index 97cb283..8fcad63 100644
--- a/include/linux/mfd/88pm80x.h
+++ b/include/linux/mfd/88pm80x.h
@@ -60,60 +60,60 @@ enum {
 /* page 0 basic: slave adder 0x60 */
 
 #define PM800_STATUS_1			(0x01)
-#define PM800_ONKEY_STS1		(1 << 0)
-#define PM800_EXTON_STS1		(1 << 1)
-#define PM800_CHG_STS1			(1 << 2)
-#define PM800_BAT_STS1			(1 << 3)
-#define PM800_VBUS_STS1			(1 << 4)
-#define PM800_LDO_PGOOD_STS1	(1 << 5)
-#define PM800_BUCK_PGOOD_STS1	(1 << 6)
+#define PM800_ONKEY_STS1		BIT(0)
+#define PM800_EXTON_STS1		BIT(1)
+#define PM800_CHG_STS1			BIT(2)
+#define PM800_BAT_STS1			BIT(3)
+#define PM800_VBUS_STS1			BIT(4)
+#define PM800_LDO_PGOOD_STS1		BIT(5)
+#define PM800_BUCK_PGOOD_STS1		BIT(6)
 
 #define PM800_STATUS_2			(0x02)
-#define PM800_RTC_ALARM_STS2	(1 << 0)
+#define PM800_RTC_ALARM_STS2		BIT(0)
 
 /* Wakeup Registers */
-#define PM800_WAKEUP1		(0x0D)
+#define PM800_WAKEUP1			(0x0D)
 
-#define PM800_WAKEUP2		(0x0E)
-#define PM800_WAKEUP2_INV_INT		(1 << 0)
-#define PM800_WAKEUP2_INT_CLEAR		(1 << 1)
-#define PM800_WAKEUP2_INT_MASK		(1 << 2)
+#define PM800_WAKEUP2			(0x0E)
+#define PM800_WAKEUP2_INV_INT		BIT(0)
+#define PM800_WAKEUP2_INT_CLEAR		BIT(1)
+#define PM800_WAKEUP2_INT_MASK		BIT(2)
 
-#define PM800_POWER_UP_LOG	(0x10)
+#define PM800_POWER_UP_LOG		(0x10)
 
 /* Referance and low power registers */
 #define PM800_LOW_POWER1		(0x20)
 #define PM800_LOW_POWER2		(0x21)
-#define PM800_LOW_POWER_CONFIG3	(0x22)
-#define PM800_LOW_POWER_CONFIG4	(0x23)
+#define PM800_LOW_POWER_CONFIG3		(0x22)
+#define PM800_LOW_POWER_CONFIG4		(0x23)
 
 /* GPIO register */
 #define PM800_GPIO_0_1_CNTRL		(0x30)
-#define PM800_GPIO0_VAL				(1 << 0)
+#define PM800_GPIO0_VAL			BIT(0)
 #define PM800_GPIO0_GPIO_MODE(x)	(x << 1)
-#define PM800_GPIO1_VAL				(1 << 4)
+#define PM800_GPIO1_VAL			BIT(4)
 #define PM800_GPIO1_GPIO_MODE(x)	(x << 5)
 
 #define PM800_GPIO_2_3_CNTRL		(0x31)
-#define PM800_GPIO2_VAL				(1 << 0)
+#define PM800_GPIO2_VAL			BIT(0)
 #define PM800_GPIO2_GPIO_MODE(x)	(x << 1)
-#define PM800_GPIO3_VAL				(1 << 4)
+#define PM800_GPIO3_VAL			BIT(4)
 #define PM800_GPIO3_GPIO_MODE(x)	(x << 5)
 #define PM800_GPIO3_MODE_MASK		0x1F
 #define PM800_GPIO3_HEADSET_MODE	PM800_GPIO3_GPIO_MODE(6)
 
-#define PM800_GPIO_4_CNTRL			(0x32)
-#define PM800_GPIO4_VAL				(1 << 0)
+#define PM800_GPIO_4_CNTRL		(0x32)
+#define PM800_GPIO4_VAL			BIT(0)
 #define PM800_GPIO4_GPIO_MODE(x)	(x << 1)
 
 #define PM800_HEADSET_CNTRL		(0x38)
-#define PM800_HEADSET_DET_EN		(1 << 7)
-#define PM800_HSDET_SLP			(1 << 1)
+#define PM800_HEADSET_DET_EN		BIT(7)
+#define PM800_HSDET_SLP			BIT(1)
 /* PWM register */
-#define PM800_PWM1		(0x40)
-#define PM800_PWM2		(0x41)
-#define PM800_PWM3		(0x42)
-#define PM800_PWM4		(0x43)
+#define PM800_PWM1			(0x40)
+#define PM800_PWM2			(0x41)
+#define PM800_PWM3			(0x42)
+#define PM800_PWM4			(0x43)
 
 /* RTC Registers */
 #define PM800_RTC_CONTROL		(0xD0)
@@ -123,55 +123,55 @@ enum {
 #define PM800_RTC_MISC4			(0xE4)
 #define PM800_RTC_MISC5			(0xE7)
 /* bit definitions of RTC Register 1 (0xD0) */
-#define PM800_ALARM1_EN			(1 << 0)
-#define PM800_ALARM_WAKEUP		(1 << 4)
-#define PM800_ALARM			(1 << 5)
-#define PM800_RTC1_USE_XO		(1 << 7)
+#define PM800_ALARM1_EN			BIT(0)
+#define PM800_ALARM_WAKEUP		BIT(4)
+#define PM800_ALARM			BIT(5)
+#define PM800_RTC1_USE_XO		BIT(7)
 
 /* Regulator Control Registers: BUCK1,BUCK5,LDO1 have DVC */
 
 /* buck registers */
-#define PM800_SLEEP_BUCK1	(0x30)
+#define PM800_SLEEP_BUCK1		(0x30)
 
 /* BUCK Sleep Mode Register 1: BUCK[1..4] */
-#define PM800_BUCK_SLP1		(0x5A)
-#define PM800_BUCK1_SLP1_SHIFT	0
-#define PM800_BUCK1_SLP1_MASK	(0x3 << PM800_BUCK1_SLP1_SHIFT)
+#define PM800_BUCK_SLP1			(0x5A)
+#define PM800_BUCK1_SLP1_SHIFT		0
+#define PM800_BUCK1_SLP1_MASK		(0x3 << PM800_BUCK1_SLP1_SHIFT)
 
 /* page 2 GPADC: slave adder 0x02 */
 #define PM800_GPADC_MEAS_EN1		(0x01)
-#define PM800_MEAS_EN1_VBAT         (1 << 2)
+#define PM800_MEAS_EN1_VBAT		BIT(2)
 #define PM800_GPADC_MEAS_EN2		(0x02)
-#define PM800_MEAS_EN2_RFTMP        (1 << 0)
-#define PM800_MEAS_GP0_EN			(1 << 2)
-#define PM800_MEAS_GP1_EN			(1 << 3)
-#define PM800_MEAS_GP2_EN			(1 << 4)
-#define PM800_MEAS_GP3_EN			(1 << 5)
-#define PM800_MEAS_GP4_EN			(1 << 6)
+#define PM800_MEAS_EN2_RFTMP		BIT(0)
+#define PM800_MEAS_GP0_EN		BIT(2)
+#define PM800_MEAS_GP1_EN		BIT(3)
+#define PM800_MEAS_GP2_EN		BIT(4)
+#define PM800_MEAS_GP3_EN		BIT(5)
+#define PM800_MEAS_GP4_EN		BIT(6)
 
 #define PM800_GPADC_MISC_CONFIG1	(0x05)
 #define PM800_GPADC_MISC_CONFIG2	(0x06)
-#define PM800_GPADC_MISC_GPFSM_EN	(1 << 0)
+#define PM800_GPADC_MISC_GPFSM_EN	BIT(0)
 #define PM800_GPADC_SLOW_MODE(x)	(x << 3)
 
-#define PM800_GPADC_MISC_CONFIG3		(0x09)
-#define PM800_GPADC_MISC_CONFIG4		(0x0A)
+#define PM800_GPADC_MISC_CONFIG3	(0x09)
+#define PM800_GPADC_MISC_CONFIG4	(0x0A)
 
-#define PM800_GPADC_PREBIAS1			(0x0F)
+#define PM800_GPADC_PREBIAS1		(0x0F)
 #define PM800_GPADC0_GP_PREBIAS_TIME(x)	(x << 0)
-#define PM800_GPADC_PREBIAS2			(0x10)
+#define PM800_GPADC_PREBIAS2		(0x10)
 
-#define PM800_GP_BIAS_ENA1				(0x14)
-#define PM800_GPADC_GP_BIAS_EN0			(1 << 0)
-#define PM800_GPADC_GP_BIAS_EN1			(1 << 1)
-#define PM800_GPADC_GP_BIAS_EN2			(1 << 2)
-#define PM800_GPADC_GP_BIAS_EN3			(1 << 3)
+#define PM800_GP_BIAS_ENA1		(0x14)
+#define PM800_GPADC_GP_BIAS_EN0		BIT(0)
+#define PM800_GPADC_GP_BIAS_EN1		BIT(1)
+#define PM800_GPADC_GP_BIAS_EN2		BIT(2)
+#define PM800_GPADC_GP_BIAS_EN3		BIT(3)
 
 #define PM800_GP_BIAS_OUT1		(0x15)
-#define PM800_BIAS_OUT_GP0		(1 << 0)
-#define PM800_BIAS_OUT_GP1		(1 << 1)
-#define PM800_BIAS_OUT_GP2		(1 << 2)
-#define PM800_BIAS_OUT_GP3		(1 << 3)
+#define PM800_BIAS_OUT_GP0		BIT(0)
+#define PM800_BIAS_OUT_GP1		BIT(1)
+#define PM800_BIAS_OUT_GP2		BIT(2)
+#define PM800_BIAS_OUT_GP3		BIT(3)
 
 #define PM800_GPADC0_LOW_TH		0x20
 #define PM800_GPADC1_LOW_TH		0x21
@@ -222,37 +222,37 @@ enum {
 
 #define PM805_INT_STATUS1		(0x03)
 
-#define PM805_INT1_HP1_SHRT		(1 << 0)
-#define PM805_INT1_HP2_SHRT		(1 << 1)
-#define PM805_INT1_MIC_CONFLICT		(1 << 2)
-#define PM805_INT1_CLIP_FAULT		(1 << 3)
-#define PM805_INT1_LDO_OFF			(1 << 4)
-#define PM805_INT1_SRC_DPLL_LOCK	(1 << 5)
+#define PM805_INT1_HP1_SHRT		BIT(0)
+#define PM805_INT1_HP2_SHRT		BIT(1)
+#define PM805_INT1_MIC_CONFLICT		BIT(2)
+#define PM805_INT1_CLIP_FAULT		BIT(3)
+#define PM805_INT1_LDO_OFF		BIT(4)
+#define PM805_INT1_SRC_DPLL_LOCK	BIT(5)
 
 #define PM805_INT_STATUS2		(0x04)
 
-#define PM805_INT2_MIC_DET			(1 << 0)
-#define PM805_INT2_SHRT_BTN_DET		(1 << 1)
-#define PM805_INT2_VOLM_BTN_DET		(1 << 2)
-#define PM805_INT2_VOLP_BTN_DET		(1 << 3)
-#define PM805_INT2_RAW_PLL_FAULT	(1 << 4)
-#define PM805_INT2_FINE_PLL_FAULT	(1 << 5)
+#define PM805_INT2_MIC_DET		BIT(0)
+#define PM805_INT2_SHRT_BTN_DET		BIT(1)
+#define PM805_INT2_VOLM_BTN_DET		BIT(2)
+#define PM805_INT2_VOLP_BTN_DET		BIT(3)
+#define PM805_INT2_RAW_PLL_FAULT	BIT(4)
+#define PM805_INT2_FINE_PLL_FAULT	BIT(5)
 
 #define PM805_INT_MASK1			(0x05)
 #define PM805_INT_MASK2			(0x06)
-#define PM805_SHRT_BTN_DET		(1 << 1)
+#define PM805_SHRT_BTN_DET		BIT(1)
 
 /* number of status and int reg in a row */
 #define PM805_INT_REG_NUM		(2)
 
 #define PM805_MIC_DET1			(0x07)
-#define PM805_MIC_DET_EN_MIC_DET (1 << 0)
+#define PM805_MIC_DET_EN_MIC_DET	BIT(0)
 #define PM805_MIC_DET2			(0x08)
-#define PM805_MIC_DET_STATUS1	(0x09)
+#define PM805_MIC_DET_STATUS1		(0x09)
 
-#define PM805_MIC_DET_STATUS3	(0x0A)
-#define PM805_AUTO_SEQ_STATUS1	(0x0B)
-#define PM805_AUTO_SEQ_STATUS2	(0x0C)
+#define PM805_MIC_DET_STATUS3		(0x0A)
+#define PM805_AUTO_SEQ_STATUS1		(0x0B)
+#define PM805_AUTO_SEQ_STATUS2		(0x0C)
 
 #define PM805_ADC_SETTING1		(0x10)
 #define PM805_ADC_SETTING2		(0x11)
@@ -261,7 +261,7 @@ enum {
 #define PM805_ADC_GAIN2			(0x13)
 #define PM805_DMIC_SETTING		(0x15)
 #define PM805_DWS_SETTING		(0x16)
-#define PM805_MIC_CONFLICT_STS	(0x17)
+#define PM805_MIC_CONFLICT_STS		(0x17)
 
 #define PM805_PDM_SETTING1		(0x20)
 #define PM805_PDM_SETTING2		(0x21)
@@ -270,11 +270,11 @@ enum {
 #define PM805_PDM_CONTROL2		(0x24)
 #define PM805_PDM_CONTROL3		(0x25)
 
-#define PM805_HEADPHONE_SETTING			(0x26)
-#define PM805_HEADPHONE_GAIN_A2A		(0x27)
-#define PM805_HEADPHONE_SHORT_STATE		(0x28)
-#define PM805_EARPHONE_SETTING			(0x29)
-#define PM805_AUTO_SEQ_SETTING			(0x2A)
+#define PM805_HEADPHONE_SETTING		(0x26)
+#define PM805_HEADPHONE_GAIN_A2A	(0x27)
+#define PM805_HEADPHONE_SHORT_STATE	(0x28)
+#define PM805_EARPHONE_SETTING		(0x29)
+#define PM805_AUTO_SEQ_SETTING		(0x2A)
 
 struct pm80x_rtc_pdata {
 	int		vrtc;
-- 
1.9.1
