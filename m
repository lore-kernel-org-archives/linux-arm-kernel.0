From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 24 Aug 2011 08:41:10 +0200
Subject: [PATCH 3/5] USB host i.MX21: remove dependency on MACH_MX21
In-Reply-To: <1314168072-13822-1-git-send-email-s.hauer@pengutronix.de>
References: <1314168072-13822-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1314168072-13822-4-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

the MACH_MX* macros are scheduled for removal, so just depend
on ARCH_MXC instead. The Kconfig text makes it clear on which
SoC the driver runs on.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Greg Kroah-Hartman <gregkh@suse.de>
Cc: linux-usb at vger.kernel.org
---
 drivers/usb/host/Kconfig |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
index ab085f1..24b5d0f 100644
--- a/drivers/usb/host/Kconfig
+++ b/drivers/usb/host/Kconfig
@@ -544,11 +544,11 @@ config USB_HWA_HCD
 	  will be called "hwa-hc".
 
 config USB_IMX21_HCD
-       tristate "iMX21 HCD support"
-       depends on USB && ARM && MACH_MX21
+       tristate "i.MX21 HCD support"
+       depends on USB && ARM && ARCH_MXC
        help
          This driver enables support for the on-chip USB host in the
-         iMX21 processor.
+         i.MX21 processor.
 
          To compile this driver as a module, choose M here: the
          module will be called "imx21-hcd".
-- 
1.7.5.4
