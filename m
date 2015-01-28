From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 28 Jan 2015 14:48:06 +0100
Subject: [PATCH 2/5] drm: panel/simple: add backlight dependency
In-Reply-To: <1422452889-415782-1-git-send-email-arnd@arndb.de>
References: <1422452889-415782-1-git-send-email-arnd@arndb.de>
Message-ID: <1422452889-415782-3-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The simple panel code uses the backlight interface to
find a device, which fails when backlight is disabled:

drivers/built-in.o: In function `panel_simple_platform_probe':
:(.text+0xd3c48): undefined reference to `of_find_backlight_by_node'

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/panel/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfig
index 84506053a7ca..d84583776d50 100644
--- a/drivers/gpu/drm/panel/Kconfig
+++ b/drivers/gpu/drm/panel/Kconfig
@@ -10,6 +10,7 @@ menu "Display Panels"
 config DRM_PANEL_SIMPLE
 	tristate "support for simple panels"
 	depends on OF
+	depends on BACKLIGHT_CLASS_DEVICE
 	help
 	  DRM panel driver for dumb panels that need at most a regulator and
 	  a GPIO to be powered up. Optionally a backlight can be attached so
-- 
2.1.0.rc2
