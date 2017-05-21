From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Sun, 21 May 2017 18:44:39 +0200
Subject: [PATCH 4/4] ARM: bcm2835_defconfig: Enable serial & ethernet USB
 gadget support
In-Reply-To: <1495385079-3697-1-git-send-email-stefan.wahren@i2se.com>
References: <1495385079-3697-1-git-send-email-stefan.wahren@i2se.com>
Message-ID: <1495385079-3697-5-git-send-email-stefan.wahren@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to use the serial and ethernet USB gadget support on
Raspberry Zero, we also need to enable the PHY driver, kernel module
and OTG support.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 arch/arm/configs/bcm2835_defconfig | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/configs/bcm2835_defconfig b/arch/arm/configs/bcm2835_defconfig
index 3ba8cd3..3ee9d78 100644
--- a/arch/arm/configs/bcm2835_defconfig
+++ b/arch/arm/configs/bcm2835_defconfig
@@ -24,6 +24,8 @@ CONFIG_PROFILING=y
 CONFIG_OPROFILE=y
 CONFIG_JUMP_LABEL=y
 CONFIG_CC_STACKPROTECTOR_REGULAR=y
+CONFIG_MODULES=y
+CONFIG_MODULE_UNLOAD=y
 CONFIG_ARCH_MULTI_V6=y
 CONFIG_ARCH_BCM=y
 CONFIG_ARCH_BCM2835=y
@@ -86,8 +88,14 @@ CONFIG_SND=y
 CONFIG_SND_SOC=y
 CONFIG_SND_BCM2835_SOC_I2S=y
 CONFIG_USB=y
+CONFIG_USB_OTG=y
 CONFIG_USB_STORAGE=y
 CONFIG_USB_DWC2=y
+CONFIG_NOP_USB_XCEIV=y
+CONFIG_USB_GADGET=y
+CONFIG_USB_ETH=m
+CONFIG_USB_ETH_EEM=y
+CONFIG_USB_G_SERIAL=m
 CONFIG_MMC=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_PLTFM=y
-- 
2.7.4
