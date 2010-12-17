From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Fri, 17 Dec 2010 14:00:10 +0900
Subject: [PATCH 09/17] ARM: SMDKC110: Enable I2S device to work
In-Reply-To: <1292561925-19586-1-git-send-email-jassisinghbrar@gmail.com>
References: <1292561925-19586-1-git-send-email-jassisinghbrar@gmail.com>
Message-ID: <1292562010-19876-1-git-send-email-jassisinghbrar@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jassi Brar <jassi.brar@samsung.com>

Add missing virtual ASoC DMA device and WM8580 as I2C slave, so
that the I2S can work on SMDK.

Signed-off-by: Jassi Brar <jassi.brar@samsung.com>
---
 arch/arm/mach-s5pv210/mach-smdkc110.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s5pv210/mach-smdkc110.c b/arch/arm/mach-s5pv210/mach-smdkc110.c
index 5dd1681..ce11a02 100644
--- a/arch/arm/mach-s5pv210/mach-smdkc110.c
+++ b/arch/arm/mach-s5pv210/mach-smdkc110.c
@@ -81,6 +81,7 @@ static struct s3c_ide_platdata smdkc110_ide_pdata __initdata = {
 };
 
 static struct platform_device *smdkc110_devices[] __initdata = {
+	&samsung_asoc_dma,
 	&s5pv210_device_iis0,
 	&s5pv210_device_ac97,
 	&s5pv210_device_spdif,
@@ -94,6 +95,7 @@ static struct platform_device *smdkc110_devices[] __initdata = {
 
 static struct i2c_board_info smdkc110_i2c_devs0[] __initdata = {
 	{ I2C_BOARD_INFO("24c08", 0x50), },     /* Samsung S524AD0XD1 */
+	{ I2C_BOARD_INFO("wm8580", 0x1b), },
 };
 
 static struct i2c_board_info smdkc110_i2c_devs1[] __initdata = {
-- 
1.6.2.5
