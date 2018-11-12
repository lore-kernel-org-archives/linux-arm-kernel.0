From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 12 Nov 2018 13:31:15 +0100
Subject: [PATCH 3/3 v6] ARM: defconfig: Enable the PL111 DRM driver on vexpress
In-Reply-To: <20181112123115.6176-1-linus.walleij@linaro.org>
References: <20181112123115.6176-1-linus.walleij@linaro.org>
Message-ID: <20181112123115.6176-4-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This updates the Versatile defconfig to use the new P111 DRM
driver that is merged in the DRM subsystem.

We deactivate the old CLCD driver and activate the Pl111 DRM
driver and the SiI9022 HDMI bridge.

We activate DMA memory allocation using CMA so that the special
graphics memory for the on-board CLCD can be used.

Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v5->v6:
- Resending
ChangeLog v4->v5:
- Resending
ChangeLog v3->v4:
- Resending
ChangeLog v1->v3:
- Rebased
---
 arch/arm/configs/vexpress_defconfig | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/arm/configs/vexpress_defconfig b/arch/arm/configs/vexpress_defconfig
index 226fe4bfb487..392ed3b3613c 100644
--- a/arch/arm/configs/vexpress_defconfig
+++ b/arch/arm/configs/vexpress_defconfig
@@ -48,6 +48,7 @@ CONFIG_NET_9P=y
 CONFIG_NET_9P_VIRTIO=y
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_DEVTMPFS=y
+CONFIG_DMA_CMA=y
 CONFIG_MTD=y
 CONFIG_MTD_CMDLINE_PARTS=y
 CONFIG_MTD_BLOCK=y
@@ -78,13 +79,16 @@ CONFIG_SERIAL_AMBA_PL011_CONSOLE=y
 CONFIG_VIRTIO_CONSOLE=y
 CONFIG_HW_RANDOM=y
 CONFIG_HW_RANDOM_VIRTIO=y
-CONFIG_I2C=y
 CONFIG_I2C_VERSATILE=y
 CONFIG_SENSORS_VEXPRESS=y
 CONFIG_REGULATOR_VEXPRESS=y
-CONFIG_FB=y
-CONFIG_FB_ARMCLCD=y
-CONFIG_FRAMEBUFFER_CONSOLE=y
+CONFIG_DRM=y
+CONFIG_DRM_PANEL_SIMPLE=y
+CONFIG_DRM_SII902X=y
+CONFIG_DRM_PL111=y
+CONFIG_FB_MODE_HELPERS=y
+CONFIG_BACKLIGHT_LCD_SUPPORT=y
+CONFIG_BACKLIGHT_CLASS_DEVICE=y
 CONFIG_LOGO=y
 # CONFIG_LOGO_LINUX_MONO is not set
 # CONFIG_LOGO_LINUX_VGA16 is not set
-- 
2.17.2
