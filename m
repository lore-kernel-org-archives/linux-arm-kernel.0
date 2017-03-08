From: kraxel@redhat.com (Gerd Hoffmann)
Date: Wed,  8 Mar 2017 10:19:07 +0100
Subject: [PATCH v4 4/7] arm: set CONFIG_MMC_BCM2835=y in bcm2835_defconfig and
 multi_v7_defconfig
In-Reply-To: <1488964751-22763-1-git-send-email-kraxel@redhat.com>
References: <1488964751-22763-1-git-send-email-kraxel@redhat.com>
Message-ID: <1488964751-22763-8-git-send-email-kraxel@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We need to enable this controller so that we can switch the SD card's
pinmux over to it by default, which will improve storage performance.

Read access (dd with 64k blocks on rpi2):
  CONFIG_MMC_SDHCI_IPROC: 11-12 MB/s
  CONFIG_MMC_BCM2835:     19-20 MB/s

Differences on write access are pretty much in the noise.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 arch/arm/configs/bcm2835_defconfig  | 1 +
 arch/arm/configs/multi_v7_defconfig | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/arm/configs/bcm2835_defconfig b/arch/arm/configs/bcm2835_defconfig
index 4b89f4e..3767c24 100644
--- a/arch/arm/configs/bcm2835_defconfig
+++ b/arch/arm/configs/bcm2835_defconfig
@@ -92,6 +92,7 @@ CONFIG_MMC=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_PLTFM=y
 CONFIG_MMC_SDHCI_IPROC=y
+CONFIG_MMC_BCM2835=y
 CONFIG_NEW_LEDS=y
 CONFIG_LEDS_CLASS=y
 CONFIG_LEDS_GPIO=y
diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index a94126f..63b94d0 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -730,6 +730,7 @@ CONFIG_MMC_DW_EXYNOS=y
 CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_MMC_SH_MMCIF=y
 CONFIG_MMC_SUNXI=y
+CONFIG_MMC_BCM2835=y
 CONFIG_NEW_LEDS=y
 CONFIG_LEDS_CLASS=y
 CONFIG_LEDS_CLASS_FLASH=m
-- 
1.8.3.1
