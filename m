From: rric@kernel.org (Robert Richter)
Date: Wed, 24 Sep 2014 17:37:42 +0200
Subject: [PATCH 0/6] pci, thunder: Add Cavium Thunder PCIe host controller
Message-ID: <1411573068-12952-1-git-send-email-rric@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Robert Richter <rrichter@cavium.com>

This patches add support for the Cavium Thunder PCIe host controller.

Patches base on following branches:

 git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci pci/liviu-generic-v11
 git://linux-arm.org/linux-ld for-upstream/pci_arm64_v11

Additionally a fix is required for liviu-generic-v11 to allow the
generation of mem-mapped pci ranges:

 https://lkml.org/lkml/2014/9/22/150

It also requires Marc's gicv3-its support to work.

The first patch introduces the host controller driver. Patch 2 to 4
are DT changes including documentation. Patch 5 and 6 enable PCI
support for arm64 defconfig.

Robert Richter (2):
  arm64, defconfig: Enable PCI
  pci, thunder: Enable Cavium Thunder PCIe host controller

Sunil Goutham (3):
  pci, thunder: Add support for Thunder PCIe host controller
  pci, thunder: Add PCIe host controller devicetree bindings
  pci, thunder: Document PCIe host controller devicetree bindings

Tirumalesh Chalamarla (1):
  GICv3: Add ITS entry to THUNDER dts

 .../devicetree/bindings/pci/cavium,thunder-pci.txt |  32 +++
 arch/arm64/Kconfig                                 |  15 ++
 arch/arm64/boot/dts/thunder-88xx.dtsi              |  58 +++++
 drivers/pci/host/Kconfig                           |   8 +
 drivers/pci/host/Makefile                          |   1 +
 drivers/pci/host/pcie-thunder.c                    | 246 +++++++++++++++++++++
 include/linux/pci_ids.h                            |   2 +
 7 files changed, 362 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/cavium,thunder-pci.txt
 create mode 100644 drivers/pci/host/pcie-thunder.c

-- 
2.1.0
