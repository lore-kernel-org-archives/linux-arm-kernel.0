From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 18 Sep 2017 17:47:50 +0200
Subject: [PATCH] ARM: defconfig: FRAMEBUFFER_CONSOLE can no longer be =m
Message-ID: <20170918154827.1654377-1-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It is no longer possible to load this at runtime, so let's
change the few remaining users to have it built-in all
the time.

arch/arm/configs/zeus_defconfig:115:warning: symbol value 'm' invalid for FRAMEBUFFER_CONSOLE
arch/arm/configs/viper_defconfig:116:warning: symbol value 'm' invalid for FRAMEBUFFER_CONSOLE
arch/arm/configs/pxa_defconfig:474:warning: symbol value 'm' invalid for FRAMEBUFFER_CONSOLE

Reported-by: kernelci.org bot <bot@kernelci.org>
Fixes: 6104c37094e7 ("fbcon: Make fbcon a built-time depency for fbdev")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/configs/pxa_defconfig   | 2 +-
 arch/arm/configs/viper_defconfig | 2 +-
 arch/arm/configs/zeus_defconfig  | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/configs/pxa_defconfig b/arch/arm/configs/pxa_defconfig
index 64e3a2a8cede..d5e1370ec303 100644
--- a/arch/arm/configs/pxa_defconfig
+++ b/arch/arm/configs/pxa_defconfig
@@ -471,7 +471,7 @@ CONFIG_LCD_PLATFORM=m
 CONFIG_LCD_TOSA=m
 CONFIG_BACKLIGHT_PWM=m
 CONFIG_BACKLIGHT_TOSA=m
-CONFIG_FRAMEBUFFER_CONSOLE=m
+CONFIG_FRAMEBUFFER_CONSOLE=y
 CONFIG_FRAMEBUFFER_CONSOLE_ROTATION=y
 CONFIG_LOGO=y
 CONFIG_SOUND=m
diff --git a/arch/arm/configs/viper_defconfig b/arch/arm/configs/viper_defconfig
index 44d4fa57ba0a..070e5074f1ee 100644
--- a/arch/arm/configs/viper_defconfig
+++ b/arch/arm/configs/viper_defconfig
@@ -113,7 +113,7 @@ CONFIG_FB_PXA_PARAMETERS=y
 CONFIG_BACKLIGHT_LCD_SUPPORT=y
 CONFIG_BACKLIGHT_PWM=m
 # CONFIG_VGA_CONSOLE is not set
-CONFIG_FRAMEBUFFER_CONSOLE=m
+CONFIG_FRAMEBUFFER_CONSOLE=y
 CONFIG_LOGO=y
 CONFIG_SOUND=m
 CONFIG_SND=m
diff --git a/arch/arm/configs/zeus_defconfig b/arch/arm/configs/zeus_defconfig
index 8d4c0c926c34..09e7050d5653 100644
--- a/arch/arm/configs/zeus_defconfig
+++ b/arch/arm/configs/zeus_defconfig
@@ -112,7 +112,7 @@ CONFIG_FB_PXA=m
 CONFIG_FB_PXA_PARAMETERS=y
 CONFIG_BACKLIGHT_LCD_SUPPORT=y
 # CONFIG_VGA_CONSOLE is not set
-CONFIG_FRAMEBUFFER_CONSOLE=m
+CONFIG_FRAMEBUFFER_CONSOLE=y
 CONFIG_LOGO=y
 CONFIG_SOUND=m
 CONFIG_SND=m
-- 
2.9.0
