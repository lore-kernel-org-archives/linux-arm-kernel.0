From: tony.lin@freescale.com (Tony Lin)
Date: Tue, 2 Aug 2011 16:39:46 +0800
Subject: [PATCH v4 7/7] ARM:  mxs: add usb host function to default config
In-Reply-To: <1312274386-6833-1-git-send-email-tony.lin@freescale.com>
References: <1312274386-6833-1-git-send-email-tony.lin@freescale.com>
Message-ID: <1312274386-6833-8-git-send-email-tony.lin@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

add usb host to mxs_defconfig

Signed-off-by: Tony Lin <tony.lin@freescale.com>
---
 arch/arm/configs/mxs_defconfig |    8 +++++++-
 arch/arm/mach-mxs/Kconfig      |    1 +
 2 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/arch/arm/configs/mxs_defconfig b/arch/arm/configs/mxs_defconfig
index db2cb7d..0a187a2 100644
--- a/arch/arm/configs/mxs_defconfig
+++ b/arch/arm/configs/mxs_defconfig
@@ -87,8 +87,14 @@ CONFIG_GPIO_SYSFS=y
 # CONFIG_HWMON is not set
 # CONFIG_MFD_SUPPORT is not set
 CONFIG_DISPLAY_SUPPORT=m
+CONFIG_USB_ARCH_HAS_EHCI=y
 # CONFIG_HID_SUPPORT is not set
-# CONFIG_USB_SUPPORT is not set
+CONFIG_USB_SUPPORT=y
+CONFIG_USB=y
+CONFIG_USB_EHCI_HCD=y
+CONFIG_USB_EHCI_ROOT_HUB_TT=y
+CONFIG_USB_EHCI_TT_NEWSCHED=y
+CONFIG_USB_EHCI_MXC=y
 CONFIG_MMC=y
 CONFIG_MMC_MXS=y
 CONFIG_RTC_CLASS=y
diff --git a/arch/arm/mach-mxs/Kconfig b/arch/arm/mach-mxs/Kconfig
index 1b11e79..58d52c5 100644
--- a/arch/arm/mach-mxs/Kconfig
+++ b/arch/arm/mach-mxs/Kconfig
@@ -49,6 +49,7 @@ config MACH_MX28EVK
 	select MXS_HAVE_PLATFORM_MXS_MMC
 	select MXS_HAVE_PLATFORM_MXSFB
 	select MXS_HAVE_PLATFORM_USB
+	select USB_ARCH_HAS_EHCI
 	select MXS_OCOTP
 	help
 	  Include support for MX28EVK platform. This includes specific
-- 
1.7.0.4
