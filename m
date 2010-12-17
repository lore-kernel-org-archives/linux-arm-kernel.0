From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Fri, 17 Dec 2010 14:00:11 +0900
Subject: [PATCH 10/17] ARM: SMDKV210: Enable I2S device to work
In-Reply-To: <1292561925-19586-1-git-send-email-jassisinghbrar@gmail.com>
References: <1292561925-19586-1-git-send-email-jassisinghbrar@gmail.com>
Message-ID: <1292562011-19908-1-git-send-email-jassisinghbrar@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jassi Brar <jassi.brar@samsung.com>

Add missing virtual ASoC DMA device and WM8580 as I2C slave, so
that the I2S can work on SMDK.

Signed-off-by: Jassi Brar <jassi.brar@samsung.com>
---
 arch/arm/mach-s5pv210/mach-smdkv210.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s5pv210/mach-smdkv210.c b/arch/arm/mach-s5pv210/mach-smdkv210.c
index 1fbc45b..1b27015 100644
--- a/arch/arm/mach-s5pv210/mach-smdkv210.c
+++ b/arch/arm/mach-s5pv210/mach-smdkv210.c
@@ -103,6 +103,7 @@ static struct samsung_keypad_platdata smdkv210_keypad_data __initdata = {
 };
 
 static struct platform_device *smdkv210_devices[] __initdata = {
+	&samsung_asoc_dma,
 	&s5pv210_device_iis0,
 	&s5pv210_device_ac97,
 	&s5pv210_device_spdif,
@@ -123,6 +124,7 @@ static struct platform_device *smdkv210_devices[] __initdata = {
 
 static struct i2c_board_info smdkv210_i2c_devs0[] __initdata = {
 	{ I2C_BOARD_INFO("24c08", 0x50), },     /* Samsung S524AD0XD1 */
+	{ I2C_BOARD_INFO("wm8580", 0x1b), },
 };
 
 static struct i2c_board_info smdkv210_i2c_devs1[] __initdata = {
-- 
1.6.2.5
