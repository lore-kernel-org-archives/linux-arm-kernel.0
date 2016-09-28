From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Wed, 28 Sep 2016 13:35:26 +0300
Subject: [PATCH 0/4] ARM: davinci: Remove DMA resources for MMC/SPI
Message-ID: <20160928103530.15291-1-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

The drivers for davinci MMC and SPI have been converted to the new DMAengine API
and no longer rely on the IORESOURCE_DMA.
This is the case for at least one release cycle so now we can remove the
IORESOURCE_DMA for these devices.

Regards,
Peter
---
Peter Ujfalusi (4):
  ARM: davinci: devices-da8xx: Remove DMA resources for MMC and SPI
  ARM: davinci: devices: Remove DMA resources for MMC
  ARM: davinci: dm355: Remove DMA resources for SPI
  ARM: davinci: dm365: Remove DMA resources for SPI

 arch/arm/mach-davinci/devices-da8xx.c | 29 -----------------------------
 arch/arm/mach-davinci/devices.c       |  3 ---
 arch/arm/mach-davinci/dm355.c         |  8 --------
 arch/arm/mach-davinci/dm365.c         |  8 --------
 4 files changed, 48 deletions(-)

--
2.10.0
