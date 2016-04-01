From: eric@anholt.net (Eric Anholt)
Date: Thu, 31 Mar 2016 17:28:23 -0700
Subject: [PATCH 2/3] ARM: multi_v7_defconfig: Switch BCM2835 to sdhci-iproc.c
 for MMC
In-Reply-To: <1459470504-5007-1-git-send-email-eric@anholt.net>
References: <1459470504-5007-1-git-send-email-eric@anholt.net>
Message-ID: <1459470504-5007-2-git-send-email-eric@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This approximately triples write performance for the SD card.  My card
is too full of important data to collect very reliable numbers, but I
see 271.361% +/- 166.742% improvement (n=3 before, 6 after), for 'dd
if=/dev/zero of=/boot/asdf bs=1M count=3 oflag=dsync,direct'.  Read
performance appears to be unaffected.

Signed-off-by: Eric Anholt <eric@anholt.net>
---
 arch/arm/configs/multi_v7_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 43a8ce0..a913520 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -642,7 +642,6 @@ CONFIG_MMC_SDHCI_SPEAR=y
 CONFIG_MMC_SDHCI_S3C=y
 CONFIG_MMC_SDHCI_S3C_DMA=y
 CONFIG_MMC_SDHCI_BCM_KONA=y
-CONFIG_MMC_SDHCI_BCM2835=y
 CONFIG_MMC_SDHCI_ST=y
 CONFIG_MMC_OMAP=y
 CONFIG_MMC_OMAP_HS=y
-- 
2.7.0
