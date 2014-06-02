From: chiau.ee.chew@intel.com (Chew Chiau Ee)
Date: Tue,  3 Jun 2014 03:46:17 +0800
Subject: [PATCH 0/2] Add common clk framework support for PCI mode SPI PXA2XX
Message-ID: <1401738379-4107-1-git-send-email-chiau.ee.chew@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Chew, Chiau Ee <chiau.ee.chew@intel.com>

SPI PXA2XX core layer depends on common clock framework to obtain
information on host supported clock rate. Thus, we setup and register
clock device for PCI mode host in SPI PXA2XX pci glue layer using
common clock APIs.

In addition, in order for PCI mode SPI PXA2XX with common clock framework
support to be built as module, we need to export clk_register_clkdev().

Chew, Chiau Ee (1):
  spi/pxa2xx-pci: Add common clock framework support in PCI glue layer

Darren Hart (1):
  clkdev: Export clk_register_clkdev

 drivers/clk/clkdev.c         |    1
 drivers/spi/spi-pxa2xx-pci.c |   20 ++++++++++++++++++++
 2 files changed, 21 insertions(+), 0 deletions(-)

-- 
1.7.4.4
