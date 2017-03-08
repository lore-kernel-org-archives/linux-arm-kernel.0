From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed,  8 Mar 2017 17:24:22 +0100
Subject: [PATCH 2/3] usb: host: Allow to build ehci orion with mvebu SoCs
In-Reply-To: <20170308162423.25553-1-gregory.clement@free-electrons.com>
References: <20170308162423.25553-1-gregory.clement@free-electrons.com>
Message-ID: <20170308162423.25553-3-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The mvebu ARM64 SoCs no more select PLAT_ORION but some of them as the
Armada 37xx use the EHCI orion controller. This patch allow to build
the driver when ARCH_MVEBU is selected.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 drivers/usb/host/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
index 407d947b34ea..870c42d89298 100644
--- a/drivers/usb/host/Kconfig
+++ b/drivers/usb/host/Kconfig
@@ -188,7 +188,7 @@ config USB_EHCI_HCD_OMAP
 
 config USB_EHCI_HCD_ORION
 	tristate  "Support for Marvell EBU on-chip EHCI USB controller"
-	depends on USB_EHCI_HCD && PLAT_ORION
+	depends on USB_EHCI_HCD && PLAT_ORION || ARCH_MVEBU
 	default y
 	---help---
 	  Enables support for the on-chip EHCI controller on Marvell's
-- 
2.11.0
