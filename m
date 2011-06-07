From: javier.martin@vista-silicon.com (Javier Martin)
Date: Tue,  7 Jun 2011 17:37:18 +0200
Subject: [PATCH] Add tlv320aic32x4 platform data to Visstrim_M10.
Message-ID: <1307461038-30069-1-git-send-email-javier.martin@vista-silicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Without this platform data the aic32x4 audio
codec in the Visstrim_M10 won't work properly.

Signed-off-by: Javier Martin <javier.martin@vista-silicon.com>
---
 arch/arm/mach-imx/mach-imx27_visstrim_m10.c |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-imx/mach-imx27_visstrim_m10.c b/arch/arm/mach-imx/mach-imx27_visstrim_m10.c
index d7e0d21..a46b2e0 100644
--- a/arch/arm/mach-imx/mach-imx27_visstrim_m10.c
+++ b/arch/arm/mach-imx/mach-imx27_visstrim_m10.c
@@ -31,6 +31,7 @@
 #include <linux/input.h>
 #include <linux/gpio.h>
 #include <linux/delay.h>
+#include <sound/tlv320aic32x4.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/time.h>
@@ -205,6 +206,17 @@ static struct pca953x_platform_data visstrim_m10_pca9555_pdata = {
 	.invert = 0,
 };
 
+static struct aic32x4_pdata visstrim_m10_aic32x4_pdata = {
+	.power_cfg = AIC32X4_PWR_MICBIAS_2075_LDOIN |
+		     AIC32X4_PWR_AVDD_DVDD_WEAK_DISABLE |
+		     AIC32X4_PWR_AIC32X4_LDO_ENABLE |
+		     AIC32X4_PWR_CMMODE_LDOIN_RANGE_18_36 |
+		     AIC32X4_PWR_CMMODE_HP_LDOIN_POWERED,
+	.micpga_routing = AIC32X4_MICPGA_ROUTE_LMIC_IN2R_10K |
+			 AIC32X4_MICPGA_ROUTE_RMIC_IN1L_10K,
+	.swapdacs = false,
+};
+
 static struct i2c_board_info visstrim_m10_i2c_devices[] = {
 	{
 		I2C_BOARD_INFO("pca9555", 0x20),
@@ -212,6 +224,7 @@ static struct i2c_board_info visstrim_m10_i2c_devices[] = {
 	},
 	{
 		I2C_BOARD_INFO("tlv320aic32x4", 0x18),
+		.platform_data = &visstrim_m10_aic32x4_pdata,
 	}
 };
 
-- 
1.7.0.4
