From: grinberg@compulab.co.il (Igor Grinberg)
Date: Thu, 15 Jul 2010 16:00:15 +0300
Subject: [PATCH 2/3] usb/otg/ulpi: add support for SMSC USB3319 ulpi phy
In-Reply-To: <1279198816-30367-1-git-send-email-grinberg@compulab.co.il>
References: <1279198816-30367-1-git-send-email-grinberg@compulab.co.il>
Message-ID: <1279198816-30367-3-git-send-email-grinberg@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>
Signed-off-by: Mike Rapoport <mike@compulab.co.il>
---
 drivers/usb/otg/Kconfig |    2 --
 drivers/usb/otg/ulpi.c  |    1 +
 2 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/otg/Kconfig b/drivers/usb/otg/Kconfig
index 3d2d3e5..3b12895 100644
--- a/drivers/usb/otg/Kconfig
+++ b/drivers/usb/otg/Kconfig
@@ -49,8 +49,6 @@ config USB_ULPI
 	  Enable this to support ULPI connected USB OTG transceivers which
 	  are likely found on embedded boards.
 
-	  The only chip currently supported is NXP's ISP1504
-
 config TWL4030_USB
 	tristate "TWL4030 USB Transceiver Driver"
 	depends on TWL4030_CORE && REGULATOR_TWL4030
diff --git a/drivers/usb/otg/ulpi.c b/drivers/usb/otg/ulpi.c
index 448d643..ef7dbe4 100644
--- a/drivers/usb/otg/ulpi.c
+++ b/drivers/usb/otg/ulpi.c
@@ -34,6 +34,7 @@
 /* ULPI hardcoded IDs, used for probing */
 static unsigned int ulpi_ids[] = {
 	ULPI_ID(0x04cc, 0x1504),	/* NXP ISP1504 */
+	ULPI_ID(0x0424, 0x0006),        /* SMSC USB3319 */
 };
 
 static int ulpi_set_flags(struct otg_transceiver *otg)
-- 
1.7.1
