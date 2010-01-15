From: valentin.longchamp@epfl.ch (Valentin Longchamp)
Date: Fri, 15 Jan 2010 18:32:11 +0100
Subject: [PATCH] otg Kconfig: add missing select USB_OTG_UTILS to USB_ULPI
	option
Message-ID: <1263576731-26075-1-git-send-email-valentin.longchamp@epfl.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fixes a link error for mx3 platforms with ULPI host devices enabled. Should go for rc5 since it completes http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=f9ffaa9ca9889f17ef30b82bc0bf954d141280f8 that was introduced in rc4.

Signed-off-by: Valentin Longchamp <valentin.longchamp@epfl.ch>
---
 drivers/usb/otg/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/otg/Kconfig b/drivers/usb/otg/Kconfig
index de56b3d..3d2d3e5 100644
--- a/drivers/usb/otg/Kconfig
+++ b/drivers/usb/otg/Kconfig
@@ -44,6 +44,7 @@ config ISP1301_OMAP
 config USB_ULPI
 	bool "Generic ULPI Transceiver Driver"
 	depends on ARM
+	select USB_OTG_UTILS
 	help
 	  Enable this to support ULPI connected USB OTG transceivers which
 	  are likely found on embedded boards.
-- 
1.6.3.3
