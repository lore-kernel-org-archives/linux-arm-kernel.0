From: leochen@broadcom.com (Leo Chen)
Date: Wed, 7 Oct 2009 11:44:35 -0700
Subject: [PATCH] bcmring: modify bcmring_defconfig with gpio support
Message-ID: <mailman.68.1255122832.2253.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Leo Hao Chen <leochen@broadcom.com>
---
 arch/arm/configs/bcmring_defconfig |   29 +++++++++++++++++++++++++++--
 1 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/arch/arm/configs/bcmring_defconfig b/arch/arm/configs/bcmring_defconfig
index bcc0bac..b3d6fdd 100644
--- a/arch/arm/configs/bcmring_defconfig
+++ b/arch/arm/configs/bcmring_defconfig
@@ -413,6 +413,7 @@ CONFIG_MTD_NAND=y
 CONFIG_MTD_NAND_VERIFY_WRITE=y
 # CONFIG_MTD_NAND_ECC_SMC is not set
 # CONFIG_MTD_NAND_MUSEUM_IDS is not set
+# CONFIG_MTD_NAND_GPIO is not set
 CONFIG_MTD_NAND_IDS=y
 CONFIG_MTD_NAND_BCM_UMI=y
 CONFIG_MTD_NAND_BCM_UMI_HWCS=y
@@ -438,6 +439,7 @@ CONFIG_BLK_DEV=y
 # CONFIG_BLK_DEV_RAM is not set
 # CONFIG_CDROM_PKTCDVD is not set
 # CONFIG_ATA_OVER_ETH is not set
+# CONFIG_MG_DISK is not set
 # CONFIG_MISC_DEVICES is not set
 CONFIG_HAVE_IDE=y
 # CONFIG_IDE is not set
@@ -520,8 +522,28 @@ CONFIG_LEGACY_PTY_COUNT=64
 # CONFIG_TCG_TPM is not set
 # CONFIG_I2C is not set
 # CONFIG_SPI is not set
-CONFIG_ARCH_WANT_OPTIONAL_GPIOLIB=y
-# CONFIG_GPIOLIB is not set
+CONFIG_ARCH_REQUIRE_GPIOLIB=y
+CONFIG_GPIOLIB=y
+#
+# Memory mapped GPIO expanders:
+#
+# CONFIG_GPIO_PL061 is not set
+
+#
+# I2C GPIO expanders:
+#
+
+#
+# PCI GPIO expanders:
+#
+
+#
+# SPI GPIO expanders:
+#
+
+#
+# AC97 GPIO expanders:
+#
 # CONFIG_W1 is not set
 # CONFIG_POWER_SUPPLY is not set
 # CONFIG_HWMON is not set
@@ -540,8 +562,11 @@ CONFIG_SSB_POSSIBLE=y
 #
 # CONFIG_MFD_CORE is not set
 # CONFIG_MFD_SM501 is not set
+# CONFIG_MFD_ASIC3 is not set
+# CONFIG_HTC_EGPIO is not set
 # CONFIG_HTC_PASIC3 is not set
 # CONFIG_MFD_TMIO is not set
+# CONFIG_MFD_TC6393XB is not set
 # CONFIG_MEDIA_SUPPORT is not set
 
 #
-- 
1.6.0.6

Leo Chen
