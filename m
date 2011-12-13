From: eric@eukrea.com (=?UTF-8?q?Eric=20B=C3=A9nard?=)
Date: Tue, 13 Dec 2011 07:31:44 +0100
Subject: [PATCH 12/19] cpuimx35: fix touchscreen support
In-Reply-To: <1323757911-25217-1-git-send-email-eric@eukrea.com>
References: <1323757911-25217-1-git-send-email-eric@eukrea.com>
Message-ID: <1323757911-25217-12-git-send-email-eric@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Eric B?nard <eric@eukrea.com>
Cc: Sascha Hauer <kernel@pengutronix.de>
---
 arch/arm/mach-imx/mach-cpuimx35.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-imx/mach-cpuimx35.c b/arch/arm/mach-imx/mach-cpuimx35.c
index 66af2e8..362aae7 100644
--- a/arch/arm/mach-imx/mach-cpuimx35.c
+++ b/arch/arm/mach-imx/mach-cpuimx35.c
@@ -53,12 +53,18 @@ static const struct imxi2c_platform_data
 	.bitrate =		100000,
 };
 
+#define TSC2007_IRQGPIO		IMX_GPIO_NR(3, 2)
+static int tsc2007_get_pendown_state(void)
+{
+	return !gpio_get_value(TSC2007_IRQGPIO);
+}
+
 static struct tsc2007_platform_data tsc2007_info = {
 	.model			= 2007,
 	.x_plate_ohms		= 180,
+	.get_pendown_state = tsc2007_get_pendown_state,
 };
 
-#define TSC2007_IRQGPIO		IMX_GPIO_NR(3, 2)
 static struct i2c_board_info eukrea_cpuimx35_i2c_devices[] = {
 	{
 		I2C_BOARD_INFO("pcf8563", 0x51),
-- 
1.7.6.4
