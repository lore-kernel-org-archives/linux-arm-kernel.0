From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Tue, 17 Mar 2015 12:22:32 +0000
Subject: [PATCH] ARM: add PCI hotplug support
Message-ID: <1426594952-1456-1-git-send-email-ben.dooks@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hotplug on PCIe should work with ARM, however the necessary
PCIe hotplug is not availale as the menu items for PCI hotplug
have not been included.

Add the include of PCI hotplug support to the ARM main Kconfig
so that it can be selected.

The only issue that was found during this is that the PCI code
did not assign interrupts properly to newly probed devices. This
will need to be fixed for any interrupt capable devices.

This has been tested on a Marvell 88F6281 with a TI XIO3130
PCIe bridge (with hotplug enabled) and fixes for IRQ assignment
added.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
--
CC: Linux ARM Kernel list <linux-arm-kernel@lists.infradead.org>
CC: Russell King <linux@arm.linux.org.uk>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: Bjorn Helgaas <bhelgaas@google.com>
CC: Linux PCI List <linux-pci@vger.kernel.org>
---
 arch/arm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 9f1f09a..4574ab4 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1302,6 +1302,7 @@ config PCI_HOST_ITE8152
 	select DMABOUNCE
 
 source "drivers/pci/Kconfig"
+source "drivers/pci/hotplug/Kconfig"
 source "drivers/pci/pcie/Kconfig"
 
 source "drivers/pcmcia/Kconfig"
-- 
2.1.4
