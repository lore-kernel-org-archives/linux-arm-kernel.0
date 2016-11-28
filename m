From: abailon@baylibre.com (Alexandre Bailon)
Date: Mon, 28 Nov 2016 17:30:54 +0100
Subject: [PATCH] ARM: davinci_all_defconfig: Enable the da8xx usb otg
Message-ID: <1480350654-26284-1-git-send-email-abailon@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The musb driver is enabled but the phy and the glue
for the da8xx are not enabled.
Enable them.

Signed-off-by: Alexandre Bailon <abailon@baylibre.com>
---
 arch/arm/configs/davinci_all_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/davinci_all_defconfig b/arch/arm/configs/davinci_all_defconfig
index b5e978f..21c548f 100644
--- a/arch/arm/configs/davinci_all_defconfig
+++ b/arch/arm/configs/davinci_all_defconfig
@@ -159,8 +159,10 @@ CONFIG_USB=m
 CONFIG_USB_MON=m
 CONFIG_USB_STORAGE=m
 CONFIG_USB_MUSB_HDRC=m
+CONFIG_USB_MUSB_DA8XX=m
 CONFIG_MUSB_PIO_ONLY=y
 CONFIG_USB_TEST=m
+CONFIG_NOP_USB_XCEIV=m
 CONFIG_USB_GADGET=m
 CONFIG_USB_GADGET_DEBUG_FILES=y
 CONFIG_USB_GADGET_DEBUG_FS=y
-- 
2.7.3
