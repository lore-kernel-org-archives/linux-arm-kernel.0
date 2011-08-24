From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 24 Aug 2011 08:41:11 +0200
Subject: [PATCH 4/5] USB gadget i.MX1: remove dependency on ARCH_MXC
In-Reply-To: <1314168072-13822-1-git-send-email-s.hauer@pengutronix.de>
References: <1314168072-13822-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1314168072-13822-5-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ARCH_MX1 scheduled for removal. Instead, depend on ARCH_MXC
and make clear in the Kconfig text that only i.MX1 has this
hardware.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Greg Kroah-Hartman <gregkh@suse.de>
Cc: linux-usb at vger.kernel.org
---
 drivers/usb/gadget/Kconfig |    9 ++++-----
 1 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/gadget/Kconfig b/drivers/usb/gadget/Kconfig
index 5a084b9..2e4424d 100644
--- a/drivers/usb/gadget/Kconfig
+++ b/drivers/usb/gadget/Kconfig
@@ -255,12 +255,11 @@ config USB_S3C_HSOTG
 	  integrated into the S3C64XX series SoC.
 
 config USB_IMX
-	tristate "Freescale IMX USB Peripheral Controller"
-	depends on ARCH_MX1
+	tristate "Freescale i.MX1 USB Peripheral Controller"
+	depends on ARCH_MXC
 	help
-	   Freescale's IMX series include an integrated full speed
-	   USB 1.1 device controller.  The controller in the IMX series
-	   is register-compatible.
+	   Freescale's i.MX1 includes an integrated full speed
+	   USB 1.1 device controller.
 
 	   It has Six fixed-function endpoints, as well as endpoint
 	   zero (for control transfers).
-- 
1.7.5.4
