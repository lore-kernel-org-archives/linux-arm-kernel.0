From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 16 Feb 2013 23:03:47 +0000
Subject: [PATCH] USB: update host controller Kconfig entries
In-Reply-To: <20130216141924.GA2473@localhost>
References: <201302152158.23446.arnd@arndb.de>
 <1360966349-1242560-2-git-send-email-arnd@arndb.de>
 <20130216141924.GA2473@localhost>
Message-ID: <201302162303.48174.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 16 February 2013, Ezequiel Garcia wrote:
> 
> s/Morvell/Marvell
> 
> Just this tiny nitpick.

Thanks for pointing this out! Tony Prisk had another comment
about the VT8500 patch, so I figured it would be good to
update both here, and I found a few more outdated changeset
comments about drivers that have become used on more platforms
now. Greg, please apply to whichever release you see fit. This
is based on your current usb-next branch.

	Arnd

8<-----------
Subject: USB: update host controller Kconfig entries

The recent patches from Manjunath Goudar introduced two small
mistakes in the Kconfig help text for the new options. Let's
fix those and the other entries that have become stale over time.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/usb/host/Kconfig | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
index 7ac6f48..245da35 100644
--- a/drivers/usb/host/Kconfig
+++ b/drivers/usb/host/Kconfig
@@ -163,23 +163,28 @@ config USB_EHCI_HCD_OMAP
 	  OMAP3 and later chips.
 
 config USB_EHCI_HCD_ORION
-        tristate  "Support for Marvell Orion on-chip EHCI USB controller"
+        tristate  "Support for Marvell EBU on-chip EHCI USB controller"
         depends on USB_EHCI_HCD && PLAT_ORION
         default y
         ---help---
           Enables support for the on-chip EHCI controller on
-          Morvell Orion chips.
+          Marvell's embedded ARM SoCs, including Orion,
+	  Kirkwood, Dove, Armada XP, Armada 370.
+	  This is different from the EHCI implementation on
+	  Marvell's mobile PXA and MMP SoC, see USB_EHCI_MV
+	  for those.
+	
 
 config USB_EHCI_HCD_VT8500
-        tristate "Support for VT8500 on-chip EHCI USB controller"
+        tristate "Support for VIA/Wondermedia on-chip EHCI USB controller"
         depends on USB_EHCI_HCD && ARCH_VT8500
         default y
         ---help---
           Enables support for the on-chip EHCI controller on
-          VT8500 chips.
+          VIA VT8500 and Wondermedia WM8x50 chips.
 
 config USB_EHCI_MSM
-	bool "Support for MSM on-chip EHCI USB controller"
+	bool "Support for Qualcomm QSD/MSM on-chip EHCI USB controller"
 	depends on USB_EHCI_HCD && ARCH_MSM
 	select USB_EHCI_ROOT_HUB_TT
 	select USB_MSM_OTG
@@ -215,10 +220,11 @@ config USB_EHCI_SH
 	  If you use the PCI EHCI controller, this option is not necessary.
 
 config USB_EHCI_S5P
-       boolean "S5P EHCI support"
-       depends on USB_EHCI_HCD && PLAT_S5P
-       help
-	 Enable support for the S5P SOC's on-chip EHCI controller.
+	boolean "EHCI support for Samsung S5P/EXYNOS SoC Series"
+	depends on USB_EHCI_HCD && PLAT_S5P
+	help
+	 Enable support for the Samsung S5Pxxxx and Exynos3/4/5 SOC's
+	 on-chip EHCI controller.
 
 config USB_EHCI_MV
 	bool "EHCI support for Marvell on-chip controller"
@@ -228,6 +234,8 @@ config USB_EHCI_MV
 	  Enables support for Marvell (including PXA and MMP series) on-chip
 	  USB SPH and OTG controller. SPH is a single port host, and it can
 	  only be EHCI host. OTG is controller that can switch to host mode.
+	  Note that there is a separate driver for Marvell's embedded ARM
+	  SoCs, see USB_EHCI_HCD_ORION for those.
 
 config USB_W90X900_EHCI
 	bool "W90X900(W90P910) EHCI support"
