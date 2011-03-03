From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu,  3 Mar 2011 14:30:57 +0100
Subject: [PATCH 3/6] usb i.MX21: use IMX_HAVE_PLATFORM_IMX21_HCD to depend on
In-Reply-To: <1299159060-9289-1-git-send-email-s.hauer@pengutronix.de>
References: <1299159060-9289-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1299159060-9289-4-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The i.MX architecture provides IMX_HAVE_PLATFORM_* macros to signal
that a selected SoC supports a certain hardware. Use them instead of
depending on ARCH_* directly.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
Acked-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
Cc: Greg Kroah-Hartman <gregkh@suse.de>
Cc: linux-usb at vger.kernel.org
---
 drivers/usb/host/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
index 0e6afa2..40bb79f 100644
--- a/drivers/usb/host/Kconfig
+++ b/drivers/usb/host/Kconfig
@@ -463,7 +463,7 @@ config USB_HWA_HCD
 
 config USB_IMX21_HCD
        tristate "iMX21 HCD support"
-       depends on USB && ARM && MACH_MX21
+       depends on USB && IMX_HAVE_PLATFORM_IMX21_HCD
        help
          This driver enables support for the on-chip USB host in the
          iMX21 processor.
-- 
1.7.2.3
