From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Fri, 14 Nov 2014 12:58:37 +0100
Subject: [PATCH] ARM: exynos_defconfig: Use 16 minors per MMC block device
Message-ID: <1415966317-11170-1-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

16 minors per MMC block device are required to boot Rinato (Gear 2)
board because up to 15 partitions are used.

With default 8 minors booting failed with:
[    1.329092] mmcblk0: mmc0:0001 F5X5MA 3.64 GiB
[    1.329448] mmcblk0boot0: mmc0:0001 F5X5MA partition 1 4.00 MiB
[    1.329627] mmcblk0boot1: mmc0:0001 F5X5MA partition 2 4.00 MiB
[    1.329808] mmcblk0rpmb: mmc0:0001 F5X5MA partition 3 512 KiB
[    1.335717]  mmcblk0: p1 p2 p3 p4 p5 p6 p7
[    1.436553] Waiting for root device /dev/mmcblk0p15...

while the correct list of partitions on mmcblk0 for Gear 2 is:
[    1.436651]  mmcblk0: p1 p2 p3 p4 p5 p6 p7 p8 p9 p10 p11 p12 p13 p14 p15

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 arch/arm/configs/exynos_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/exynos_defconfig b/arch/arm/configs/exynos_defconfig
index 72058b8a6f4d..aa32931bdd30 100644
--- a/arch/arm/configs/exynos_defconfig
+++ b/arch/arm/configs/exynos_defconfig
@@ -134,6 +134,7 @@ CONFIG_USB_STORAGE=y
 CONFIG_USB_DWC3=y
 CONFIG_USB_HSIC_USB3503=y
 CONFIG_MMC=y
+CONFIG_MMC_BLOCK_MINORS=16
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_S3C=y
 CONFIG_MMC_SDHCI_S3C_DMA=y
-- 
1.9.1
