From: gabriele.paoloni@huawei.com (Gabriele Paoloni)
Date: Tue, 9 Feb 2016 17:34:17 +0000
Subject: [RFC PATCH v3 0/3] Add ACPI support for HiSilicon PCIe Host
 Controllers
Message-ID: <1455039260-6040-1-git-send-email-gabriele.paoloni@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: gabriele paoloni <gabriele.paoloni@huawei.com>

This patchset adds ACPI support for the HiSilicon Hip05/Hip06 SoC PCIe controllers
The four patches respectively:
        - re-architect the current HiSilicon driver to make it scalable to the
          new ACPI quirks
        - rework the current HiSilicon driver to add support for ECAM platforms
        - adds the HiSilicon ACPI specific quirks.

   This patchset  is based on
   https://github.com/semihalf-nowicki-tomasz/linux.git
   branch pci-acpi-v4

Changes v1 -> v2: removed the ACPI quirks dependency on Designware framework

Changes v2 -> v3: kept backward compatibility for non-ECAM platforms

gabriele paoloni (3):
  PCI: hisi: re-architect Hip05/Hip06 controllers driver to preapare for
    ACPI
  PCI: hisi: Add ECAM support to HiSilicon PCIe host controller
  PCI/ACPI: hisi: Add ACPI support for HiSilicon SoCs Host Controllers

 .../devicetree/bindings/pci/hisilicon-pcie.txt     |  15 +-
 MAINTAINERS                                        |   3 +
 drivers/pci/host/Kconfig                           |   8 +
 drivers/pci/host/Makefile                          |   3 +-
 drivers/pci/host/pcie-designware.c                 |   4 +-
 drivers/pci/host/pcie-designware.h                 |   2 +
 drivers/pci/host/pcie-hisi-acpi.c                  | 188 +++++++++++++++++++++
 drivers/pci/host/pcie-hisi-common.c                |  73 ++++++++
 drivers/pci/host/pcie-hisi.c                       | 149 ++++++++--------
 drivers/pci/host/pcie-hisi.h                       |  25 +++
 10 files changed, 382 insertions(+), 88 deletions(-)
 create mode 100644 drivers/pci/host/pcie-hisi-acpi.c
 create mode 100644 drivers/pci/host/pcie-hisi-common.c
 create mode 100644 drivers/pci/host/pcie-hisi.h

-- 
1.9.1
