From: arnd@arndb.de (Arnd Bergmann)
Date: Thu,  8 May 2014 15:52:16 +0200
Subject: [PATCH 3/8] usb: musb: omap2plus bus glue needs USB host support
In-Reply-To: <1399557141-1346645-1-git-send-email-arnd@arndb.de>
References: <1399557141-1346645-1-git-send-email-arnd@arndb.de>
Message-ID: <1399557141-1346645-4-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The musb/omap2430.c bus glue driver calls usb_hcd_poll_rh_status,
which is only available if CONFIG_USB is also set, i.e. we
are building USB host mode and not just endpoint mode.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: linux-omap at vger.kernel.org
---
 drivers/usb/musb/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/musb/Kconfig b/drivers/usb/musb/Kconfig
index 618b152..fce762c 100644
--- a/drivers/usb/musb/Kconfig
+++ b/drivers/usb/musb/Kconfig
@@ -76,7 +76,7 @@ config USB_MUSB_TUSB6010
 
 config USB_MUSB_OMAP2PLUS
 	tristate "OMAP2430 and onwards"
-	depends on ARCH_OMAP2PLUS
+	depends on ARCH_OMAP2PLUS && USB
 	select GENERIC_PHY
 
 config USB_MUSB_AM35X
-- 
1.8.3.2
