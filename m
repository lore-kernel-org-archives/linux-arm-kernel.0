From: javier@dowhile0.org (Javier Martinez Canillas)
Date: Sun, 15 Jul 2012 05:03:18 +0200
Subject: [PATCH 1/1] ARM: OMAP2+: omap2plus_defconfig: enable OMAP DMA engine
 support
Message-ID: <1342321398-11009-1-git-send-email-javier@dowhile0.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

commit 13f30fc893e4610f67dd7a8b0b67aec02eac1775
Author: Russell King <rmk+kernel@arm.linux.org.uk>
Date:   Sat Apr 21 22:41:10 2012 +0100

    mmc: omap: remove private DMA API implementation

removed the private DMA API implementation from the OMAP mmc host to
make it use exclusively the DMA engine API.

Unfortunately the omap2plus_defconfig doesn't enable this feature
leading to the following error on an IGEPv2 Rev.C (and probably on most
boards with MMC support):

[    2.199981] omap_hsmmc omap_hsmmc.1: unable to obtain RX DMA engine channel 48
[    2.215087] omap_hsmmc omap_hsmmc.0: unable to obtain RX DMA engine channel 62

Signed-off-by: Javier Martinez Canillas <javier@dowhile0.org>
---
 arch/arm/configs/omap2plus_defconfig |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index b152de7..e58edc3 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -193,6 +193,8 @@ CONFIG_MMC_OMAP_HS=y
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_TWL92330=y
 CONFIG_RTC_DRV_TWL4030=y
+CONFIG_DMADEVICES=y
+CONFIG_DMA_OMAP=y
 CONFIG_EXT2_FS=y
 CONFIG_EXT3_FS=y
 # CONFIG_EXT3_FS_XATTR is not set
-- 
1.7.7.6
