From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 14 May 2013 16:42:24 +0200
Subject: [PATCH] ARM: Kirkwood: Enable USB 3.0 in kirkwood_defconfig
Message-ID: <1368542544-24743-1-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some QNAP devices has a USB 3.0 host controller on a PCIe bus.  Enable
the driver for this in the default configuration.

Reported-by: Marek Vasut <marex@denx.de>
Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 arch/arm/configs/kirkwood_defconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/kirkwood_defconfig b/arch/arm/configs/kirkwood_defconfig
index a1d8252..49c9872 100644
--- a/arch/arm/configs/kirkwood_defconfig
+++ b/arch/arm/configs/kirkwood_defconfig
@@ -140,6 +140,7 @@ CONFIG_HID_TOPSEED=y
 CONFIG_HID_THRUSTMASTER=y
 CONFIG_HID_ZEROPLUS=y
 CONFIG_USB=y
+CONFIG_USB_XHCI_HCD=y
 CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_EHCI_ROOT_HUB_TT=y
 CONFIG_USB_PRINTER=m
-- 
1.7.10.4
