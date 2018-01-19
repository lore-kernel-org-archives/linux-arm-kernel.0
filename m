From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 19 Jan 2018 14:32:08 +0100
Subject: [PATCH] ARM: sunxi_defconfig: Enable CMA
Message-ID: <20180119133208.12873-1-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The DRM driver most notably, but also out of tree drivers (for now) like
the VPU or GPU drivers, are quite big consumers of large, contiguous memory
buffers. However, the sunxi_defconfig doesn't enable CMA in order to
mitigate that, which makes them almost unusable.

Enable it to make sure it somewhat works.

Cc: <stable@vger.kernel.org>
Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---

Hi Arnd, Olof,

Could you queue that patch as a fix?

Thanks!
Maxime

 arch/arm/configs/sunxi_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/sunxi_defconfig b/arch/arm/configs/sunxi_defconfig
index 5caaf971fb50..df433abfcb02 100644
--- a/arch/arm/configs/sunxi_defconfig
+++ b/arch/arm/configs/sunxi_defconfig
@@ -10,6 +10,7 @@ CONFIG_SMP=y
 CONFIG_NR_CPUS=8
 CONFIG_AEABI=y
 CONFIG_HIGHMEM=y
+CONFIG_CMA=y
 CONFIG_ARM_APPENDED_DTB=y
 CONFIG_ARM_ATAG_DTB_COMPAT=y
 CONFIG_CPU_FREQ=y
@@ -33,6 +34,7 @@ CONFIG_CAN_SUN4I=y
 # CONFIG_WIRELESS is not set
 CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
+CONFIG_DMA_CMA=y
 CONFIG_BLK_DEV_SD=y
 CONFIG_ATA=y
 CONFIG_AHCI_SUNXI=y
-- 
2.14.3
