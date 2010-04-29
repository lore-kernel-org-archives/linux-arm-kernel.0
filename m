From: svenkatr@ti.com (Venkatraman S)
Date: Thu, 29 Apr 2010 23:04:34 +0530
Subject: [PATCH v8 0/2] sDMA descriptor autoloading feature
Message-ID: <i2x618f0c911004291034g7f5b377ds5efaf74c901bc036@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

    This patch series is the introduction of new sDMA feature: descriptor
autoloading (v8) and it's adoption by the OMAP HSMMC driver.

   The previous version (v7) was blocked on achieving proper interrupt
syncronisation
between the MMC and DMA callback in the HSMMC driver.
  Thanks to Adrian Hunter's patch, https://patchwork.kernel.org/patch/94670/
this has been cleaned up.

Current version is based on for-next branch + Adrian Hunter's
interrupt syncronisation patch
(https://patchwork.kernel.org/patch/94670)

Changes since v7:
  * Removed the 'fix race condition between DMA and HSMMC callback'
part of the series
  * Added memory barries in start and resume sglist transfer for cpu
buffer syncronization
  * Cleanup and comments

This has been tested on OMAP3430, OMAP3630 and OMAP4430 SDP
for MMC file transfer and as boot file system.

Venkatraman S:
    sDMA: descriptor autoloading feature
    MMC: omap hsmmc adoption of descriptor autoloading feature

 arch/arm/plat-omap/dma.c              |  289 ++++++++++++++++++++++++++++++++-
 arch/arm/plat-omap/include/plat/dma.h |  170 +++++++++++++++++++
 drivers/mmc/host/omap_hsmmc.c         |  148 ++++++++++++++---
 3 files changed, 583 insertions(+), 24 deletions(-)
