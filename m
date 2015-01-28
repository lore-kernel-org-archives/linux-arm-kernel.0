From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 28 Jan 2015 14:48:05 +0100
Subject: [PATCH 1/5] drm: panel/sharp: add backlight dependency
In-Reply-To: <1422452889-415782-1-git-send-email-arnd@arndb.de>
References: <1422452889-415782-1-git-send-email-arnd@arndb.de>
Message-ID: <1422452889-415782-2-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The sharp panel code uses the backlight interface to
find a device, which fails when backlight is disabled:

drivers/built-in.o: In function `sharp_panel_probe':
:(.text+0x5ceac): undefined reference to `of_find_backlight_by_node'

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/panel/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfig
index 024e98ef8e4d..84506053a7ca 100644
--- a/drivers/gpu/drm/panel/Kconfig
+++ b/drivers/gpu/drm/panel/Kconfig
@@ -31,6 +31,7 @@ config DRM_PANEL_SHARP_LQ101R1SX01
 	tristate "Sharp LQ101R1SX01 panel"
 	depends on OF
 	depends on DRM_MIPI_DSI
+	depends on BACKLIGHT_CLASS_DEVICE
 	help
 	  Say Y here if you want to enable support for Sharp LQ101R1SX01
 	  TFT-LCD modules. The panel has a 2560x1600 resolution and uses
-- 
2.1.0.rc2
