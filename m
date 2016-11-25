From: bgolaszewski@baylibre.com (Bartosz Golaszewski)
Date: Fri, 25 Nov 2016 10:13:02 +0100
Subject: [PATCH] ARM: davinci_all_defconfig: enable dumb vga-dac drm bridge
Message-ID: <1480065182-7095-1-git-send-email-bgolaszewski@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This enables the dumb-vga-dac driver by default for davinci boards.

The driver is needed for tilcdc support on da850-lcdk board.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/configs/davinci_all_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/davinci_all_defconfig b/arch/arm/configs/davinci_all_defconfig
index b5e978f..ab1bf18 100644
--- a/arch/arm/configs/davinci_all_defconfig
+++ b/arch/arm/configs/davinci_all_defconfig
@@ -127,6 +127,8 @@ CONFIG_REGULATOR_FIXED_VOLTAGE=y
 CONFIG_REGULATOR_TPS6507X=y
 CONFIG_DRM=m
 CONFIG_DRM_TILCDC=m
+CONFIG_DRM_BRIDGE=y
+CONFIG_DRM_DUMB_VGA_DAC=m
 CONFIG_FB=y
 CONFIG_FIRMWARE_EDID=y
 CONFIG_FB_DA8XX=y
-- 
2.9.3
