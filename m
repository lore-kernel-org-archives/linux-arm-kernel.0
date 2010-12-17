From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Fri, 17 Dec 2010 14:00:08 +0900
Subject: [PATCH 07/17] ARM: SMDK6440: Enable I2S device to work
In-Reply-To: <1292561925-19586-1-git-send-email-jassisinghbrar@gmail.com>
References: <1292561925-19586-1-git-send-email-jassisinghbrar@gmail.com>
Message-ID: <1292562008-19812-1-git-send-email-jassisinghbrar@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jassi Brar <jassi.brar@samsung.com>

Add missing virtual ASoC DMA device and WM8580 as I2C slave, so
that the I2S can work on SMDK.

Signed-off-by: Jassi Brar <jassi.brar@samsung.com>
---
 arch/arm/mach-s5p64x0/mach-smdk6440.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s5p64x0/mach-smdk6440.c b/arch/arm/mach-s5p64x0/mach-smdk6440.c
index 87c3f03..e5beb84 100644
--- a/arch/arm/mach-s5p64x0/mach-smdk6440.c
+++ b/arch/arm/mach-s5p64x0/mach-smdk6440.c
@@ -95,6 +95,7 @@ static struct platform_device *smdk6440_devices[] __initdata = {
 	&s3c_device_i2c1,
 	&s3c_device_ts,
 	&s3c_device_wdt,
+	&samsung_asoc_dma,
 	&s5p6440_device_iis,
 };
 
@@ -117,6 +118,7 @@ static struct s3c2410_platform_i2c s5p6440_i2c1_data __initdata = {
 
 static struct i2c_board_info smdk6440_i2c_devs0[] __initdata = {
 	{ I2C_BOARD_INFO("24c08", 0x50), },
+	{ I2C_BOARD_INFO("wm8580", 0x1b), },
 };
 
 static struct i2c_board_info smdk6440_i2c_devs1[] __initdata = {
-- 
1.6.2.5
