From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Mon, 12 Aug 2013 20:46:52 +0200
Subject: [PATCH 6/9] ARM: dove: update dove_defconfig with SI5351, PCI,
 and xHCI
In-Reply-To: <1376333215-12885-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1376333215-12885-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <1376333215-12885-7-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds SI5351 clock driver found on the SolidRun CuBox, PCI driver
and USB 3.0 xHCI driver found on the Globalscale D3Plug to dove_defconfig.

Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
---
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Olof Johansson <olof@lixom.net>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: linux-kernel at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
---
 arch/arm/configs/dove_defconfig |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/configs/dove_defconfig b/arch/arm/configs/dove_defconfig
index 4364eff..1101054 100644
--- a/arch/arm/configs/dove_defconfig
+++ b/arch/arm/configs/dove_defconfig
@@ -13,6 +13,9 @@ CONFIG_ARCH_DOVE=y
 CONFIG_MACH_DOVE_DB=y
 CONFIG_MACH_CM_A510=y
 CONFIG_MACH_DOVE_DT=y
+CONFIG_PCI=y
+CONFIG_PCI_MSI=y
+CONFIG_PCI_MVEBU=y
 CONFIG_AEABI=y
 CONFIG_HIGHMEM=y
 CONFIG_ZBOOT_ROM_TEXT=0x0
@@ -78,6 +81,7 @@ CONFIG_SPI_ORION=y
 CONFIG_THERMAL=y
 CONFIG_DOVE_THERMAL=y
 CONFIG_USB=y
+CONFIG_USB_XHCI_HCD=y
 CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_EHCI_ROOT_HUB_TT=y
 CONFIG_USB_STORAGE=y
-- 
1.7.10.4
