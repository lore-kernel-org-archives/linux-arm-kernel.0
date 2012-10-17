From: horms@verge.net.au (Simon Horman)
Date: Wed, 17 Oct 2012 13:39:13 +0900
Subject: [PATCH 02/10] ARM: shmobile: kzm9g: enable magnetometer ak8975.
In-Reply-To: <1350448761-27346-1-git-send-email-horms@verge.net.au>
References: <1350448761-27346-1-git-send-email-horms@verge.net.au>
Message-ID: <1350448761-27346-3-git-send-email-horms@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Tetsuyuki Kobayashi <koba@kmckk.co.jp>

This patch enables magnetometer ak8975.
I checked ak8975_probe() returns successfully.

Signed-off-by: Tetsuyuki Kobayashi <koba@kmckk.co.jp>
Signed-off-by: Simon Horman <horms@verge.net.au>
---
 arch/arm/configs/kzm9g_defconfig     |    2 ++
 arch/arm/mach-shmobile/board-kzm9g.c |    6 +++++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/arm/configs/kzm9g_defconfig b/arch/arm/configs/kzm9g_defconfig
index c88b578..1404b04 100644
--- a/arch/arm/configs/kzm9g_defconfig
+++ b/arch/arm/configs/kzm9g_defconfig
@@ -119,6 +119,8 @@ CONFIG_DMADEVICES=y
 CONFIG_SH_DMAE=y
 CONFIG_ASYNC_TX_DMA=y
 CONFIG_STAGING=y
+CONFIG_SENSORS_AK8975=y
+CONFIG_IIO=y
 # CONFIG_DNOTIFY is not set
 CONFIG_INOTIFY_USER=y
 CONFIG_VFAT_FS=y
diff --git a/arch/arm/mach-shmobile/board-kzm9g.c b/arch/arm/mach-shmobile/board-kzm9g.c
index 0a43f31..a37da78 100644
--- a/arch/arm/mach-shmobile/board-kzm9g.c
+++ b/arch/arm/mach-shmobile/board-kzm9g.c
@@ -557,7 +557,11 @@ static struct i2c_board_info i2c0_devices[] = {
 	},
 	{
 		I2C_BOARD_INFO("r2025sd", 0x32),
-	}
+	},
+	{
+		I2C_BOARD_INFO("ak8975", 0x0c),
+		.irq = intcs_evt2irq(0x3380), /* IRQ28 */
+	},
 };
 
 static struct i2c_board_info i2c1_devices[] = {
-- 
1.7.10.4
