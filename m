From: jhnikula@gmail.com (Jarkko Nikula)
Date: Fri, 17 Dec 2010 21:18:25 +0200
Subject: [PATCH 3/3] omap: rx51: Add supplies and data for codec b part of
	TLV320AIC34
In-Reply-To: <1292613505-10113-1-git-send-email-jhnikula@gmail.com>
References: <1292613505-10113-1-git-send-email-jhnikula@gmail.com>
Message-ID: <1292613505-10113-3-git-send-email-jhnikula@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Upcoming ASoC core and tlv320aic3x changes makes possible to take b part of
TLV320AIC34 into use on RX51/N900. Prepare to this by adding virtual supplies
and platform data for b part of the codec.

Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
---
 arch/arm/mach-omap2/board-rx51-peripherals.c |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-rx51-peripherals.c b/arch/arm/mach-omap2/board-rx51-peripherals.c
index 6114e47..ca8cecd 100644
--- a/arch/arm/mach-omap2/board-rx51-peripherals.c
+++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
@@ -343,6 +343,8 @@ static struct regulator_consumer_supply rx51_vmmc2_supplies[] = {
 	/* tlv320aic3x analog supplies */
 	REGULATOR_SUPPLY("AVDD", "2-0018"),
 	REGULATOR_SUPPLY("DRVDD", "2-0018"),
+	REGULATOR_SUPPLY("AVDD", "2-0019"),
+	REGULATOR_SUPPLY("DRVDD", "2-0019"),
 	/* tpa6130a2 */
 	REGULATOR_SUPPLY("Vdd", "2-0060"),
 	/* Keep vmmc as last item. It is not iterated for newer boards */
@@ -353,6 +355,8 @@ static struct regulator_consumer_supply rx51_vio_supplies[] = {
 	/* tlv320aic3x digital supplies */
 	REGULATOR_SUPPLY("IOVDD", "2-0018"),
 	REGULATOR_SUPPLY("DVDD", "2-0018"),
+	REGULATOR_SUPPLY("IOVDD", "2-0019"),
+	REGULATOR_SUPPLY("DVDD", "2-0019"),
 };
 
 #if defined(CONFIG_FB_OMAP2) || defined(CONFIG_FB_OMAP2_MODULE)
@@ -743,11 +747,19 @@ static struct aic3x_pdata rx51_aic3x_data = {
 	.gpio_reset = 60,
 };
 
+static struct aic3x_pdata rx51_aic3x_data2 = {
+	.gpio_reset = 60,
+};
+
 static struct i2c_board_info __initdata rx51_peripherals_i2c_board_info_2[] = {
 	{
 		I2C_BOARD_INFO("tlv320aic3x", 0x18),
 		.platform_data = &rx51_aic3x_data,
 	},
+	{
+		I2C_BOARD_INFO("tlv320aic3x", 0x19),
+		.platform_data = &rx51_aic3x_data2,
+	},
 #if defined(CONFIG_SENSORS_TSL2563) || defined(CONFIG_SENSORS_TSL2563_MODULE)
 	{
 		I2C_BOARD_INFO("tsl2563", 0x29),
-- 
1.7.2.3
