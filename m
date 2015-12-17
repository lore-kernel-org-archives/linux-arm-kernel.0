From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Thu, 17 Dec 2015 15:27:46 +0200
Subject: [PATCH v02 0/6] ARM: DTS: da850: eDMA new bindings and MMC/SPI DMA
 support
Message-ID: <1450358872-2951-1-git-send-email-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Changes since v1:
- Added tested by from Sushaanth Srirangapathi
- Updated to use the non 16bit arrays [1]
- memcpy channels are not reserved as requested by Sekhar - DMA memcpy is
  disabled for now

Switch to use the new eDMA bindings and enable DMA for MMC0, SPI1.
Add node for MMC1.

[1]
As it has been discussed in the following thread:
https://www.mail-archive.com/linux-omap at vger.kernel.org/msg122117.html

the DT bindings has been changes compared to what we had in 4.4-rc1: the arrays
now don't have the 16bit type.
The changes are now merged to mainline and Vinod provided us a branch:

git://git.infradead.org/users/vkoul/slave-dma.git fix/edma

Which is based on 4.4-rc1 and only contains the two patch for changing the eDMA
bindings.

Regards,
Peter
---
Peter Ujfalusi (6):
  ARM: DTS: da850: fix edma0 reg space
  ARM: DTS: da850: Use the new DT bindings for the eDMA3
  ARM: DTS: da850: Enable eDMA1
  ARM: DTS: da850: Enable DMA use for MMC0
  ARM: DTS: da850: Add node for mmc1
  ARM: DTS: da850: Enable DMA for SPI1

 arch/arm/boot/dts/da850-enbw-cmc.dts |  8 +++++
 arch/arm/boot/dts/da850-evm.dts      |  8 +++++
 arch/arm/boot/dts/da850.dtsi         | 58 ++++++++++++++++++++++++++++++++----
 3 files changed, 68 insertions(+), 6 deletions(-)

-- 
2.6.4
