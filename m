From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Wed, 26 Jun 2013 12:02:55 +0200
Subject: [linux-next PATCH] ARM: shmobile: marzen: defconfig: enable DMA engine
 support
Message-ID: <1642514.quKgForQrD@amdc1032>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [linux-next PATCH] ARM: shmobile: marzen: defconfig: enable DMA engine support

Building marzen_defconfig for next-20130626 results in the following
build error:

drivers/built-in.o: In function `sh_mobile_sdhi_probe':
/home/bzolnier/sam/linux-sprc/drivers/mmc/host/sh_mobile_sdhi.c:170: undefined reference to `shdma_chan_filter'

Fix it by adding CONFIG_DMADEVICES=y line to marzen_defconfig. This
will result in CONFIG_SH_DMAE_BASE being enabled by default and the
needed code being build.

Cc: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Simon Horman <horms@verge.net.au>
Cc: Magnus Damm <magnus.damm@gmail.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 arch/arm/configs/marzen_defconfig |    1 +
 1 file changed, 1 insertion(+)

Index: b/arch/arm/configs/marzen_defconfig
===================================================================
--- a/arch/arm/configs/marzen_defconfig	2013-06-21 12:04:24.813681807 +0200
+++ b/arch/arm/configs/marzen_defconfig	2013-06-25 16:43:40.730367398 +0200
@@ -96,6 +96,7 @@ CONFIG_USB_STORAGE=y
 CONFIG_NEW_LEDS=y
 CONFIG_LEDS_CLASS=y
 CONFIG_LEDS_GPIO=y
+CONFIG_DMADEVICES=y
 CONFIG_UIO=y
 CONFIG_UIO_PDRV_GENIRQ=y
 # CONFIG_IOMMU_SUPPORT is not set
