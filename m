From: wens@csie.org (Chen-Yu Tsai)
Date: Tue,  9 Feb 2016 23:31:27 +0800
Subject: [PATCH v2] ARM: sunxi_defconfig: Enable MUSB HDRC driver with
 Allwinner glue
Message-ID: <1455031887-14147-1-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allwinner SoCs typically have a Mentor Graphics Inventra MUSB dual role
controller for USB OTG.

Now that the issue with MUSB and USB gadget registration order has been
resolved, we can enable this driver in dual role mode. This requires the
NOP USB transceiver driver, which is also enabled.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---

Changes since v1:

 - Dropped default USB gadget driver.

---
 arch/arm/configs/sunxi_defconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/configs/sunxi_defconfig b/arch/arm/configs/sunxi_defconfig
index a55c48e27309..81a1b92fd4e6 100644
--- a/arch/arm/configs/sunxi_defconfig
+++ b/arch/arm/configs/sunxi_defconfig
@@ -110,6 +110,10 @@ CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_EHCI_HCD_PLATFORM=y
 CONFIG_USB_OHCI_HCD=y
 CONFIG_USB_OHCI_HCD_PLATFORM=y
+CONFIG_USB_MUSB_HDRC=y
+CONFIG_USB_MUSB_SUNXI=y
+CONFIG_NOP_USB_XCEIV=y
+CONFIG_USB_GADGET=y
 CONFIG_MMC=y
 CONFIG_MMC_SUNXI=y
 CONFIG_NEW_LEDS=y
-- 
2.7.0
