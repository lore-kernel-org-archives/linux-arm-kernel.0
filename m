From: laurent.pinchart+renesas@ideasonboard.com (Laurent Pinchart)
Date: Tue, 29 Oct 2013 00:46:52 +0100
Subject: [PATCH 04/19] input: sh_keysc: Enable the driver on all ARM platforms
In-Reply-To: <1383004027-25036-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1383004027-25036-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Message-ID: <1383004027-25036-5-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Renesas ARM platforms are transitioning from single-platform to
multi-platform kernels using the new ARCH_SHMOBILE_MULTI. Make the
driver available on all ARM platforms to enable it on both ARCH_SHMOBILE
and ARCH_SHMOBILE_MULTI and increase build testing coverage.

Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input at vger.kernel.org
Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/input/keyboard/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kconfig
index c1edd39..7ac6a716e 100644
--- a/drivers/input/keyboard/Kconfig
+++ b/drivers/input/keyboard/Kconfig
@@ -525,7 +525,7 @@ config KEYBOARD_SUNKBD
 
 config KEYBOARD_SH_KEYSC
 	tristate "SuperH KEYSC keypad support"
-	depends on SUPERH || ARCH_SHMOBILE
+	depends on SUPERH || ARM
 	help
 	  Say Y here if you want to use a keypad attached to the KEYSC block
 	  on SuperH processors such as sh7722 and sh7343.
-- 
1.8.1.5
