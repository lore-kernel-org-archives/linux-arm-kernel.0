From: w.sang@pengutronix.de (Wolfram Sang)
Date: Thu, 10 Feb 2011 20:14:51 +0100
Subject: [PATCH 5/5] arm: mach-mx3: use IMX_GPIO_NR instead of hard-coded
	values
In-Reply-To: <1297365291-1038-1-git-send-email-w.sang@pengutronix.de>
References: <1297365291-1038-1-git-send-email-w.sang@pengutronix.de>
Message-ID: <1297365291-1038-6-git-send-email-w.sang@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The latter are error-prone because the bank number is one less than one
would read in the documentation.

Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
Cc: Eric B?nard <eric@eukrea.com>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/mach-mx3/eukrea_mbimxsd-baseboard.c |    4 ++--
 arch/arm/mach-mx3/mach-cpuimx35.c            |    2 +-
 arch/arm/mach-mx3/mach-pcm043.c              |   10 +++++-----
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-mx3/eukrea_mbimxsd-baseboard.c b/arch/arm/mach-mx3/eukrea_mbimxsd-baseboard.c
index 14a5ffc..8076147 100644
--- a/arch/arm/mach-mx3/eukrea_mbimxsd-baseboard.c
+++ b/arch/arm/mach-mx3/eukrea_mbimxsd-baseboard.c
@@ -165,8 +165,8 @@ static iomux_v3_cfg_t eukrea_mbimxsd_pads[] = {
 	MX35_PAD_SD1_DATA3__ESDHC1_DAT3,
 };
 
-#define GPIO_LED1	(2 * 32 + 29)
-#define GPIO_SWITCH1	(2 * 32 + 25)
+#define GPIO_LED1	IMX_GPIO_NR(3, 29)
+#define GPIO_SWITCH1	IMX_GPIO_NR(3, 25)
 #define GPIO_LCDPWR	(4)
 
 static void eukrea_mbimxsd_lcd_power_set(struct plat_lcd_data *pd,
diff --git a/arch/arm/mach-mx3/mach-cpuimx35.c b/arch/arm/mach-mx3/mach-cpuimx35.c
index 26ae90f..892c3a9 100644
--- a/arch/arm/mach-mx3/mach-cpuimx35.c
+++ b/arch/arm/mach-mx3/mach-cpuimx35.c
@@ -60,7 +60,7 @@ static struct tsc2007_platform_data tsc2007_info = {
 	.x_plate_ohms		= 180,
 };
 
-#define TSC2007_IRQGPIO		(2 * 32 + 2)
+#define TSC2007_IRQGPIO		IMX_GPIO_NR(3, 2)
 static struct i2c_board_info eukrea_cpuimx35_i2c_devices[] = {
 	{
 		I2C_BOARD_INFO("pcf8563", 0x51),
diff --git a/arch/arm/mach-mx3/mach-pcm043.c b/arch/arm/mach-mx3/mach-pcm043.c
index 26b686c..51542f7 100644
--- a/arch/arm/mach-mx3/mach-pcm043.c
+++ b/arch/arm/mach-mx3/mach-pcm043.c
@@ -224,12 +224,12 @@ static iomux_v3_cfg_t pcm043_pads[] = {
 	MX35_PAD_ATA_DATA11__GPIO2_24, /* CardDetect */
 };
 
-#define AC97_GPIO_TXFS	(1 * 32 + 31)
-#define AC97_GPIO_TXD	(1 * 32 + 28)
-#define AC97_GPIO_RESET	(1 * 32 + 0)
+#define AC97_GPIO_TXFS	IMX_GPIO_NR(2, 31)
+#define AC97_GPIO_TXD	IMX_GPIO_NR(2, 28)
+#define AC97_GPIO_RESET	IMX_GPIO_NR(2, 0)
 
-#define SD1_GPIO_WP	(1 * 32 + 23)
-#define SD1_GPIO_CD	(1 * 32 + 24)
+#define SD1_GPIO_WP	IMX_GPIO_NR(2, 23)
+#define SD1_GPIO_CD	IMX_GPIO_NR(2, 24)
 
 static void pcm043_ac97_warm_reset(struct snd_ac97 *ac97)
 {
-- 
1.7.2.3
