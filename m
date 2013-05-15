From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 15 May 2013 15:25:23 +0200
Subject: [PATCHv9 9/9] arm: mvebu: update defconfig with PCI and USB support
In-Reply-To: <1368624323-24311-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1368624323-24311-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1368624323-24311-10-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we have the necessary drivers and Device Tree informations to
support PCIe on Armada 370 and Armada XP, enable the CONFIG_PCI
option.

Also, since the Armada 370 Mirabox has a built-in USB XHCI controller
connected on the PCIe bus, enable the corresponding options as well.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/configs/mvebu_defconfig |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/configs/mvebu_defconfig b/arch/arm/configs/mvebu_defconfig
index f3e8ae0..966281e 100644
--- a/arch/arm/configs/mvebu_defconfig
+++ b/arch/arm/configs/mvebu_defconfig
@@ -13,6 +13,8 @@ CONFIG_MACH_ARMADA_370=y
 CONFIG_MACH_ARMADA_XP=y
 # CONFIG_CACHE_L2X0 is not set
 # CONFIG_SWP_EMULATE is not set
+CONFIG_PCI=y
+CONFIG_PCI_MVEBU=y
 CONFIG_SMP=y
 CONFIG_AEABI=y
 CONFIG_HIGHMEM=y
@@ -60,6 +62,7 @@ CONFIG_USB_SUPPORT=y
 CONFIG_USB=y
 CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_EHCI_ROOT_HUB_TT=y
+CONFIG_USB_XHCI_HCD=y
 CONFIG_MMC=y
 CONFIG_MMC_MVSDIO=y
 CONFIG_NEW_LEDS=y
-- 
1.7.9.5
