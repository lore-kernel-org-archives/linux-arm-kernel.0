From: mporter@ti.com (Matt Porter)
Date: Wed,  6 Mar 2013 23:16:37 -0500
Subject: [PATCH 0/2] AM33xx mmc support
Message-ID: <1362629799-22485-1-git-send-email-mporter@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series enable MMC support on AM33xx platforms. Support for
platforms incorporating the EDMA DMAC is added using the
dma_get_slave_sg_limits() api. AM33xx DTS supported is added for
Beaglebone, AM335x-EVM, and AM335x-EVMSK.

These patches were split out from the v5 version of the AM33xx
DMA series and split from the generic DT/dmanegine omap_hsmmc
changes.

The series has the following dependencies:
	- edma private api error check fix
	  http://www.spinics.net/lists/arm-kernel/msg227886.html
	- DMA Engine support for AM33XX
	  http://www.spinics.net/lists/linux-omap/msg87634.html
	- omap_hsmmc DT DMA Client support
	  http://www.spinics.net/lists/linux-omap/msg87623.html
	- dmaengine: add slave sg transfer limits api
	  https://lkml.org/lkml/2013/3/6/462

Matt Porter (2):
  mmc: omap_hsmmc: set max_segs based on dma engine limits
  ARM: dts: add AM33XX MMC support

 arch/arm/boot/dts/am335x-bone.dts  |    7 +++++++
 arch/arm/boot/dts/am335x-evm.dts   |    7 +++++++
 arch/arm/boot/dts/am335x-evmsk.dts |    7 +++++++
 arch/arm/boot/dts/am33xx.dtsi      |   28 ++++++++++++++++++++++++++++
 drivers/mmc/host/omap_hsmmc.c      |    8 ++++++++
 5 files changed, 57 insertions(+)

-- 
1.7.9.5
