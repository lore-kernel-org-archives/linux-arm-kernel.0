From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu,  9 Mar 2017 18:28:26 +0100
Subject: [PATCH v3 2/3] usb: host: Allow to build ehci orion with mvebu SoCs
In-Reply-To: <20170309172827.17874-1-gregory.clement@free-electrons.com>
References: <20170309172827.17874-1-gregory.clement@free-electrons.com>
Message-ID: <20170309172827.17874-3-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The mvebu ARM64 SoCs no longer select PLAT_ORION. However Armada 37xx use
the Orion EHCI controller. This patch allows the Orion EHCI driver to be
built when ARCH_MVEBU is selected.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 drivers/usb/host/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
index 407d947b34ea..54bdd76c7f03 100644
--- a/drivers/usb/host/Kconfig
+++ b/drivers/usb/host/Kconfig
@@ -188,7 +188,7 @@ config USB_EHCI_HCD_OMAP
 
 config USB_EHCI_HCD_ORION
 	tristate  "Support for Marvell EBU on-chip EHCI USB controller"
-	depends on USB_EHCI_HCD && PLAT_ORION
+	depends on USB_EHCI_HCD && (PLAT_ORION || ARCH_MVEBU)
 	default y
 	---help---
 	  Enables support for the on-chip EHCI controller on Marvell's
-- 
2.11.0
