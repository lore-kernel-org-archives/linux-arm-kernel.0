From: linus.walleij@stericsson.com (Linus Walleij)
Date: Mon, 14 Nov 2011 13:09:16 +0100
Subject: [PATCH v2] ARM: ux500: update the MOP500 GPIO assignments
Message-ID: <1321272556-1210-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

This is a more complete list of the MOP500 GPIO pins, especially
for those used with the Snowball board. Sort GPIO number in
falling number order so there is some structure to this file.
Fix some whitespace issues in the process.

Cc: Mian Yousaf Kaukab <mian.yousaf.kaukab@stericsson.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-ux500/board-mop500.h |   62 ++++++++++++++++++++++++++++-------
 1 files changed, 49 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-ux500/board-mop500.h b/arch/arm/mach-ux500/board-mop500.h
index e82552a..f926d3d 100644
--- a/arch/arm/mach-ux500/board-mop500.h
+++ b/arch/arm/mach-ux500/board-mop500.h
@@ -7,35 +7,71 @@
 #ifndef __BOARD_MOP500_H
 #define __BOARD_MOP500_H
 
-/* snowball GPIO for MMC card */
-#define SNOWBALL_SDMMC_EN_GPIO 217
-#define SNOWBALL_SDMMC_1V8_3V_GPIO 228
-#define SNOWBALL_SDMMC_CD_GPIO 218
+/* Snowball specific GPIO assignments, this board has no GPIO expander */
+#define SNOWBALL_ACCEL_INT1_GPIO	163
+#define SNOWBALL_ACCEL_INT2_GPIO	164
+#define SNOWBALL_MAGNET_DRDY_GPIO	165
+#define SNOWBALL_SDMMC_EN_GPIO		217
+#define SNOWBALL_SDMMC_1V8_3V_GPIO	228
+#define SNOWBALL_SDMMC_CD_GPIO		218
 
 /* HREFv60-specific GPIO assignments, this board has no GPIO expander */
-#define HREFV60_TOUCH_RST_GPIO		143
-#define HREFV60_PROX_SENSE_GPIO		217
-#define HREFV60_HAL_SW_GPIO		145
-#define HREFV60_SDMMC_EN_GPIO		169
 #define HREFV60_SDMMC_1V8_3V_GPIO	5
-#define HREFV60_SDMMC_CD_GPIO		95
-#define HREFV60_ACCEL_INT1_GPIO		82
-#define HREFV60_ACCEL_INT2_GPIO		83
+#define HREFV60_CAMERA_FLASH_ENABLE	21
 #define HREFV60_MAGNET_DRDY_GPIO	32
 #define HREFV60_DISP1_RST_GPIO		65
 #define HREFV60_DISP2_RST_GPIO		66
+#define HREFV60_ACCEL_INT1_GPIO		82
+#define HREFV60_ACCEL_INT2_GPIO		83
+#define HREFV60_SDMMC_CD_GPIO		95
+#define HREFV60_XSHUTDOWN_SECONDARY_SENSOR 140
+#define HREFV60_TOUCH_RST_GPIO		143
+#define HREFV60_HAL_SW_GPIO		145
+#define HREFV60_SDMMC_EN_GPIO		169
+#define HREFV60_MMIO_XENON_CHARGE	170
+#define HREFV60_PROX_SENSE_GPIO		217
+
+/* MOP500 generic GPIOs */
+#define CAMERA_FLASH_INT_PIN		7
+#define CYPRESS_TOUCH_INT_PIN		84
+#define XSHUTDOWN_PRIMARY_SENSOR	141
+#define XSHUTDOWN_SECONDARY_SENSOR	142
+#define CYPRESS_TOUCH_RST_GPIO		143
+#define MOP500_HDMI_RST_GPIO		196
+#define CYPRESS_SLAVE_SELECT_GPIO	216
 
 /* GPIOs on the TC35892 expander */
 #define MOP500_EGPIO(x)			(NOMADIK_NR_GPIO + (x))
+#define GPIO_MAGNET_DRDY		MOP500_EGPIO(1)
 #define GPIO_SDMMC_CD			MOP500_EGPIO(3)
+#define GPIO_CAMERA_FLASH_ENABLE	MOP500_EGPIO(4)
+#define GPIO_MMIO_XENON_CHARGE		MOP500_EGPIO(5)
 #define GPIO_PROX_SENSOR		MOP500_EGPIO(7)
+#define GPIO_HAL_SENSOR			MOP500_EGPIO(8)
+#define GPIO_ACCEL_INT1			MOP500_EGPIO(10)
+#define GPIO_ACCEL_INT2			MOP500_EGPIO(11)
 #define GPIO_BU21013_CS			MOP500_EGPIO(13)
+#define MOP500_DISP2_RST_GPIO		MOP500_EGPIO(14)
+#define MOP500_DISP1_RST_GPIO		MOP500_EGPIO(15)
 #define GPIO_SDMMC_EN			MOP500_EGPIO(17)
 #define GPIO_SDMMC_1V8_3V_SEL		MOP500_EGPIO(18)
 #define MOP500_EGPIO_END		MOP500_EGPIO(24)
 
-/* GPIOs on the AB8500 mixed-signals circuit */
-#define MOP500_AB8500_GPIO(x)		(MOP500_EGPIO_END + (x))
+/*
+ * GPIOs on the AB8500 mixed-signals circuit
+ * Notice that we subtract 1 from the number passed into the macro, this is
+ * because the AB8500 GPIO pins are enumbered starting from 1, so the value in
+ * parens matches the GPIO pin number in the data sheet.
+ */
+#define MOP500_AB8500_GPIO(x)		(MOP500_EGPIO_END + (x) - 1)
+/*Snowball AB8500 GPIO */
+#define SNOWBALL_VSMPS2_1V8_GPIO	MOP500_AB8500_PIN_GPIO(1)	/* SYSCLKREQ2/GPIO1 */
+#define SNOWBALL_PM_GPIO1_GPIO		MOP500_AB8500_PIN_GPIO(2)	/* SYSCLKREQ3/GPIO2 */
+#define SNOWBALL_WLAN_CLK_REQ_GPIO	MOP500_AB8500_PIN_GPIO(3)	/* SYSCLKREQ4/GPIO3 */
+#define SNOWBALL_PM_GPIO4_GPIO		MOP500_AB8500_PIN_GPIO(4)	/* SYSCLKREQ6/GPIO4 */
+#define SNOWBALL_EN_3V6_GPIO		MOP500_AB8500_PIN_GPIO(16)	/* PWMOUT3/GPIO16 */
+#define SNOWBALL_PME_ETH_GPIO		MOP500_AB8500_PIN_GPIO(24)	/* SYSCLKREQ7/GPIO24 */
+#define SNOWBALL_EN_3V3_ETH_GPIO	MOP500_AB8500_PIN_GPIO(26)	/* GPIO26 */
 
 struct i2c_board_info;
 
-- 
1.7.3.2
