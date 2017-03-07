From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Tue, 7 Mar 2017 15:22:45 +0530
Subject: [PATCH v2 0/7] PCI: dwc: miscellaneous fixes and cleanups
Message-ID: <1488880372-7390-1-git-send-email-kishon@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This should be the final set of cleanups/fixes before endpoint
support can be merged.

Keerthy's patch is a general fix in dra7xx driver and is not
directly related to endpoint mode.

This series was previously sent with a different cover letter
$subject [1]

Changes from v1:
*) included a patch to rename _unroll() to _ob_unroll() as
   similar thing has to be done for inbound window in the case
   of EP mode.
*) used 'size_t' instead of 'int' for specifying the size
   in read_dbi/write_dbi function arguments.
*) Populate cpu_addr_fixup ops for artpec6 as suggested by
   Niklas

This series is based on 4.11-rc1

[1] -> https://lkml.org/lkml/2017/2/16/270

Keerthy (1):
  PCI: dwc: dra7xx: Push request_irq call to the bottom of probe

Kishon Vijay Abraham I (6):
  PCI: dwc: designware: Add new *ops* for cpu addr fixup
  PCI: dwc: dra7xx: Populate cpu_addr_fixup ops
  PCI: dwc: artpec6: Populate cpu_addr_fixup ops
  PCI: dwc: all: Modify dbi accessors to take dbi_base as argument
  PCI: dwc: all: Modify dbi accessors to access data of 4/2/1  bytes
  PCI: dwc: designware: Modify _unroll() to _ob_unroll()

 drivers/pci/dwc/Kconfig                |   18 ++---
 drivers/pci/dwc/pci-dra7xx.c           |   35 +++++----
 drivers/pci/dwc/pci-exynos.c           |   14 ++--
 drivers/pci/dwc/pci-imx6.c             |   62 +++++++++-------
 drivers/pci/dwc/pci-keystone-dw.c      |   16 ++--
 drivers/pci/dwc/pcie-armada8k.c        |   39 +++++-----
 drivers/pci/dwc/pcie-artpec6.c         |   22 ++++--
 drivers/pci/dwc/pcie-designware-host.c |   20 ++---
 drivers/pci/dwc/pcie-designware.c      |  127 ++++++++++++++++++++------------
 drivers/pci/dwc/pcie-designware.h      |   13 +++-
 drivers/pci/dwc/pcie-hisi.c            |   17 +++--
 11 files changed, 226 insertions(+), 157 deletions(-)

-- 
1.7.9.5
