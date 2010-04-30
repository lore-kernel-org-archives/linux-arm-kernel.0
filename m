From: Dinh.Nguyen@freescale.com (Dinh.Nguyen at freescale.com)
Date: Fri, 30 Apr 2010 15:48:27 -0500
Subject: [PATCHv10 2.6.34-rc6 5/5] mx5: Add USB to Freescale MX51 defconfig
In-Reply-To: <1272660507-5917-4-git-send-email-Dinh.Nguyen@freescale.com>
References: <1272660507-5917-1-git-send-email-Dinh.Nguyen@freescale.com>
	<1272660507-5917-2-git-send-email-Dinh.Nguyen@freescale.com>
	<1272660507-5917-3-git-send-email-Dinh.Nguyen@freescale.com>
	<1272660507-5917-4-git-send-email-Dinh.Nguyen@freescale.com>
Message-ID: <1272660507-5917-5-git-send-email-Dinh.Nguyen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dinh Nguyen <Dinh.Nguyen@freescale.com>

Update mx51_defconfig to include USB EHCI by default.

This patch applies to 2.6.34-rc6.

Signed-off-by: Dinh Nguyen <Dinh.Nguyen@freescale.com>
---
 arch/arm/configs/mx51_defconfig |   17 ++++++++++++++++-
 1 files changed, 16 insertions(+), 1 deletions(-)

diff --git a/arch/arm/configs/mx51_defconfig b/arch/arm/configs/mx51_defconfig
index c88e952..a708fd6 100644
--- a/arch/arm/configs/mx51_defconfig
+++ b/arch/arm/configs/mx51_defconfig
@@ -809,7 +809,22 @@ CONFIG_SSB_POSSIBLE=y
 CONFIG_DUMMY_CONSOLE=y
 # CONFIG_SOUND is not set
 # CONFIG_HID_SUPPORT is not set
-# CONFIG_USB_SUPPORT is not set
+CONFIG_USB_SUPPORT=y
+CONFIG_USB_ARCH_HAS_HCD=y
+# CONFIG_USB_ARCH_HAS_OHCI is not set
+CONFIG_USB_ARCH_HAS_EHCI=y
+CONFIG_USB=y
+
+#
+# USB Host Controller Drivers
+#
+# CONFIG_USB_C67X00_HCD is not set
+CONFIG_USB_EHCI_HCD=y
+CONFIG_USB_EHCI_ROOT_HUB_TT=y
+# CONFIG_USB_EHCI_TT_NEWSCHED is not set
+CONFIG_USB_EHCI_MXC=y
+
+
 CONFIG_MMC=y
 # CONFIG_MMC_DEBUG is not set
 # CONFIG_MMC_UNSAFE_RESUME is not set
-- 
1.6.0.4
