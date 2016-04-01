From: eric@anholt.net (Eric Anholt)
Date: Thu, 31 Mar 2016 17:30:40 -0700
Subject: [PATCH 1/4] ARM: bcm2835: Switch BCM2835 to sdhci-iproc.c for MMC
Message-ID: <1459470643-9070-1-git-send-email-eric@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This approximately triples write performance for the SD card.  My card
is too full of important data to collect very reliable numbers, but I
see 271.361% +/- 166.742% improvement (n=3 before, 6 after), for 'dd
if=/dev/zero of=/boot/asdf bs=1M count=3 oflag=dsync,direct'.  Read
performance appears to be unaffected.

Signed-off-by: Eric Anholt <eric@anholt.net>
---
 arch/arm/configs/bcm2835_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/configs/bcm2835_defconfig b/arch/arm/configs/bcm2835_defconfig
index 1ef69fc..1617fd2 100644
--- a/arch/arm/configs/bcm2835_defconfig
+++ b/arch/arm/configs/bcm2835_defconfig
@@ -87,7 +87,7 @@ CONFIG_USB_DWC2=y
 CONFIG_MMC=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_PLTFM=y
-CONFIG_MMC_SDHCI_BCM2835=y
+CONFIG_MMC_SDHCI_IPROC=y
 CONFIG_NEW_LEDS=y
 CONFIG_LEDS_CLASS=y
 CONFIG_LEDS_GPIO=y
-- 
2.7.0
