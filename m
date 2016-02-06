From: wens@csie.org (Chen-Yu Tsai)
Date: Sat,  6 Feb 2016 23:53:46 +0800
Subject: [PATCH 3/6] ARM: sunxi_defconfig: Enable MUSB HDRC driver with
 Allwinner glue
In-Reply-To: <1454774029-10469-1-git-send-email-wens@csie.org>
References: <1454774029-10469-1-git-send-email-wens@csie.org>
Message-ID: <1454774029-10469-4-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allwinner SoCs typically have a Mentor Graphics Inventra MUSB dual role
controller for USB OTG.

Now that the issue with MUSB and USB gadget registration order has been
resolved, we can enable this driver in dual role mode. This requires the
NOP USB transceiver driver, which is also enabled.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/configs/sunxi_defconfig | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/configs/sunxi_defconfig b/arch/arm/configs/sunxi_defconfig
index efa12c88fe1c..e29b81694184 100644
--- a/arch/arm/configs/sunxi_defconfig
+++ b/arch/arm/configs/sunxi_defconfig
@@ -109,6 +109,11 @@ CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_EHCI_HCD_PLATFORM=y
 CONFIG_USB_OHCI_HCD=y
 CONFIG_USB_OHCI_HCD_PLATFORM=y
+CONFIG_USB_MUSB_HDRC=y
+CONFIG_USB_MUSB_SUNXI=y
+CONFIG_NOP_USB_XCEIV=y
+CONFIG_USB_GADGET=y
+CONFIG_USB_CDC_COMPOSITE=y
 CONFIG_MMC=y
 CONFIG_MMC_SUNXI=y
 CONFIG_NEW_LEDS=y
-- 
2.7.0
