From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Thu, 9 Mar 2017 12:08:58 +0530
Subject: [RESEND PATCH v3 0/7] PCI: dwc: Miscellaneous fixes and cleanups
Message-ID: <1489041545-15730-1-git-send-email-kishon@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Resending since it bounced from quite a few lists.

This should be the final set of cleanups/fixes before endpoint
support can be merged.

Keerthy's patch is a general fix in dra7xx driver and is not
directly related to endpoint mode.

This v1 of this series was previously sent with a different
cover letter $subject [1]

Changes from v2:
*) Kconfig changes that was spilled into a patch is removed.
*) In addition to renaming _unroll() to _ob_unroll(), all the
   _unroll configurations is also moved a separate function.

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
  PCI: dwc: designware: Move _unroll configurations to a separate
    function

 drivers/pci/dwc/pci-dra7xx.c           |   35 +++----
 drivers/pci/dwc/pci-exynos.c           |   14 +--
 drivers/pci/dwc/pci-imx6.c             |   62 +++++++------
 drivers/pci/dwc/pci-keystone-dw.c      |   16 ++--
 drivers/pci/dwc/pcie-armada8k.c        |   39 ++++----
 drivers/pci/dwc/pcie-artpec6.c         |   22 +++--
 drivers/pci/dwc/pcie-designware-host.c |   20 ++--
 drivers/pci/dwc/pcie-designware.c      |  156 +++++++++++++++++++++-----------
 drivers/pci/dwc/pcie-designware.h      |   13 ++-
 drivers/pci/dwc/pcie-hisi.c            |   17 ++--
 10 files changed, 241 insertions(+), 153 deletions(-)

-- 
1.7.9.5
