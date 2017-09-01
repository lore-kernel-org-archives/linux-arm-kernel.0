From: aford173@gmail.com (Adam Ford)
Date: Fri,  1 Sep 2017 09:53:19 -0500
Subject: [PATCH] ARM: davinci_all_defconfig: enable MTD_CMDLINE_PARTS
Message-ID: <1504277599-12812-1-git-send-email-aford173@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is some disagreement between the partition table map in Linux
for the DA850-EVM and the coresponding partition map in U-Boot.
To prevent breaking the Kernel, this patch enables MTD_CMDLINE_PARTS
which will allow the U-Boot to pass the partition map so future partitions
match without breaking backwards compatibility.

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/arch/arm/configs/davinci_all_defconfig b/arch/arm/configs/davinci_all_defconfig
index 27d9720..4d432cf 100644
--- a/arch/arm/configs/davinci_all_defconfig
+++ b/arch/arm/configs/davinci_all_defconfig
@@ -59,6 +59,7 @@ CONFIG_DEVTMPFS_MOUNT=y
 CONFIG_DA8XX_MSTPRI=y
 CONFIG_MTD=m
 CONFIG_MTD_TESTS=m
+CONFIG_MTD_CMDLINE_PARTS=m
 CONFIG_MTD_BLOCK=m
 CONFIG_MTD_CFI=m
 CONFIG_MTD_CFI_INTELEXT=m
@@ -195,7 +196,6 @@ CONFIG_USB_G_SERIAL=m
 CONFIG_USB_G_PRINTER=m
 CONFIG_USB_CDC_COMPOSITE=m
 CONFIG_MMC=y
-# CONFIG_MMC_BLOCK_BOUNCE is not set
 CONFIG_MMC_DAVINCI=y
 CONFIG_NEW_LEDS=y
 CONFIG_LEDS_CLASS=m
-- 
2.7.4
