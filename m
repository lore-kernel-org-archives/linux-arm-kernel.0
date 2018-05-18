From: aford173@gmail.com (Adam Ford)
Date: Thu, 17 May 2018 19:43:31 -0500
Subject: [PATCH] ARM: davinci_all_defconfig: set CONFIG_BACKLIGHT_PWM=m
Message-ID: <20180518004331.28120-1-aford173@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The da850-evm came with an LCD with a backlight tied to a pwm. This
enables CONFIG_BACKLIGHT_PWM as a module so the PWM backlight can be
used to maintain brightness control of the backlight.

Note: make savedefconfig changed the order of one of the config options

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/arch/arm/configs/davinci_all_defconfig b/arch/arm/configs/davinci_all_defconfig
index 21b2d7791df4..63c5808a1055 100644
--- a/arch/arm/configs/davinci_all_defconfig
+++ b/arch/arm/configs/davinci_all_defconfig
@@ -7,9 +7,9 @@ CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 CONFIG_LOG_BUF_SHIFT=14
 CONFIG_CGROUPS=y
-CONFIG_CHECKPOINT_RESTORE=y
 CONFIG_BLK_DEV_INITRD=y
 CONFIG_EXPERT=y
+CONFIG_CHECKPOINT_RESTORE=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 CONFIG_MODULE_FORCE_UNLOAD=y
@@ -153,6 +153,7 @@ CONFIG_TINYDRM_ST7586=m
 CONFIG_FB=y
 CONFIG_FIRMWARE_EDID=y
 CONFIG_FB_DA8XX=y
+CONFIG_BACKLIGHT_PWM=m
 CONFIG_FRAMEBUFFER_CONSOLE=y
 CONFIG_LOGO=y
 CONFIG_SOUND=m
-- 
2.17.0
