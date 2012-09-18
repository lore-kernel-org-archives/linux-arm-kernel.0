From: horms@verge.net.au (Simon Horman)
Date: Tue, 18 Sep 2012 10:54:18 +0900
Subject: [PATCH 2/2] ARM: shmobile: kzm9g: enable three-axis digital
 accelerometer ADXL345
In-Reply-To: <1347933258-4372-1-git-send-email-horms@verge.net.au>
References: <1347933258-4372-1-git-send-email-horms@verge.net.au>
Message-ID: <1347933258-4372-3-git-send-email-horms@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Tetsuyuki Kobayashi <koba@kmckk.co.jp>

This patch enables three-axis digital accelerometer ADXL345.
Test:
  sudo cat /dev/input/event2
then tip up the board. You get something from /dev/input/event2.

Signed-off-by: Tetsuyuki Kobayashi <koba@kmckk.co.jp>
Signed-off-by: Simon Horman <horms@verge.net.au>
---
 arch/arm/configs/kzm9g_defconfig     |    2 ++
 arch/arm/mach-shmobile/board-kzm9g.c |    4 ++++
 2 files changed, 6 insertions(+)

diff --git a/arch/arm/configs/kzm9g_defconfig b/arch/arm/configs/kzm9g_defconfig
index 2aaa2ff..83047e0 100644
--- a/arch/arm/configs/kzm9g_defconfig
+++ b/arch/arm/configs/kzm9g_defconfig
@@ -73,6 +73,8 @@ CONFIG_INPUT_EVDEV=y
 # CONFIG_INPUT_MOUSE is not set
 CONFIG_INPUT_TOUCHSCREEN=y
 CONFIG_TOUCHSCREEN_ST1232=y
+CONFIG_INPUT_MISC=y
+CONFIG_INPUT_ADXL34X=y
 # CONFIG_LEGACY_PTYS is not set
 CONFIG_SERIAL_SH_SCI=y
 CONFIG_SERIAL_SH_SCI_NR_UARTS=9
diff --git a/arch/arm/mach-shmobile/board-kzm9g.c b/arch/arm/mach-shmobile/board-kzm9g.c
index 7965012..72f75e2 100644
--- a/arch/arm/mach-shmobile/board-kzm9g.c
+++ b/arch/arm/mach-shmobile/board-kzm9g.c
@@ -563,6 +563,10 @@ static struct i2c_board_info i2c0_devices[] = {
 		I2C_BOARD_INFO("ak8975", 0x0c),
 		.irq = intcs_evt2irq(0x3380), /* IRQ28 */
 	},
+	{
+		I2C_BOARD_INFO("adxl34x", 0x1d),
+		.irq = intcs_evt2irq(0x3340), /* IRQ26 */
+	},
 };
 
 static struct i2c_board_info i2c1_devices[] = {
-- 
1.7.10.4
