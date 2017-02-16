From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Thu, 16 Feb 2017 18:59:08 +0530
Subject: [PATCH 0/4] PCI: dwc: cleanup designware driver
Message-ID: <1487251752-12478-1-git-send-email-kishon@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series does additional cleanup on top of [1] in preparation
for adding endpoint mode support to designware driver.

This series was previously sent as part of endpoint support series [2].

Once this series is merged, PCI endpoint series can be merged. I'll wait
for this series to be merged before sending the next revision of endpoint
series.

The entire endpoint support is pushed here:
git://git.kernel.org/pub/scm/linux/kernel/git/kishon/pci-endpoint.git next

[1] -> https://lkml.org/lkml/2017/2/15/273
[2] -> https://lkml.org/lkml/2017/1/13/562

Kishon Vijay Abraham I (4):
  PCI: dwc: designware: Add new *ops* for cpu addr fixup
  PCI: dwc: dra7xx: Populate cpu_addr_fixup ops
  PCI: dwc: all: Modify dbi accessors to take dbi_base as argument
  PCI: dwc: all: Modify dbi accessors to access data of 4/2/1     
    bytes

 drivers/pci/dwc/pci-dra7xx.c           |   21 ++++---
 drivers/pci/dwc/pci-exynos.c           |   14 +++--
 drivers/pci/dwc/pci-imx6.c             |   67 +++++++++++---------
 drivers/pci/dwc/pci-keystone-dw.c      |   16 +++--
 drivers/pci/dwc/pcie-armada8k.c        |   39 +++++++-----
 drivers/pci/dwc/pcie-artpec6.c         |    7 ++-
 drivers/pci/dwc/pcie-designware-host.c |   20 +++---
 drivers/pci/dwc/pcie-designware.c      |  108 ++++++++++++++++++++------------
 drivers/pci/dwc/pcie-designware.h      |   13 ++--
 drivers/pci/dwc/pcie-hisi.c            |   17 ++---
 10 files changed, 192 insertions(+), 130 deletions(-)

-- 
1.7.9.5
