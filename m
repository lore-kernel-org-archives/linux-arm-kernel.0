From: gregory.clement@bootlin.com (Gregory CLEMENT)
Date: Wed, 28 Feb 2018 15:47:02 +0100
Subject: [PATCH 0/2] PCI: armada8k: Fix clock resource for Armada 7K/8K
Message-ID: <20180228144704.12947-1-gregory.clement@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This short series fixes the way the clocks are used for the PCIe host
controller embedded in the Marvell Armada 7K/8K SoCs. On these SoCs a
second one is needed in order to clock the registers. It was not
noticed until now because we relied on the bootloader and also because
the clock driver was wrong.

Thanks to this fix, it would be possible to fix the clock driver
without introducing a regression.

The first patch is just a small cleanup found when I wrote the main
patch.

Gregory CLEMENT (2):
  PCI: armada8k: Remove useless test before clk_disable_unprepare
  PCI: armada8k: Fix clock resource by adding a register clock

 Documentation/devicetree/bindings/pci/pci-armada8k.txt |  6 +++++-
 drivers/pci/dwc/pcie-armada8k.c                        | 14 ++++++++++++--
 2 files changed, 17 insertions(+), 3 deletions(-)

-- 
2.16.1
