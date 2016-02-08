From: gabriele.paoloni@huawei.com (Gabriele Paoloni)
Date: Mon, 8 Feb 2016 12:41:01 +0000
Subject: [RFC PATCH v2 0/3] Add ACPI support for HiSilicon PCIe Host
 Controllers
Message-ID: <1454935264-6076-1-git-send-email-gabriele.paoloni@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: gabriele paoloni <gabriele.paoloni@huawei.com>

This patchset adds ACPI support for the HiSilicon Hip05/Hip06 SoC PCIe controllers
The four patches respectively:
        - re-architect the current HiSilicon driver to make it scalable to the
          new ACPI quirks
        - rework the current HiSilicon driver to make it ECAM compliant
        - adds the HiSilicon ACPI specific quirks.

   This patchset  is based on
   https://github.com/semihalf-nowicki-tomasz/linux.git
   branch pci-acpi-v4

Changes v1 -> v2: removed the ACPI quirks dependency on Designware framework

gabriele paoloni (3):
  PCI: hisi: re-architect Hip05/Hip06 controllers driver to preapare for
    ACPI
  PCI: hisi: Make the HiSilicon PCIe host controller ECAM compliant
  PCI/ACPI: hisi: Add ACPI support for HiSilicon SoCs Host Controllers

 MAINTAINERS                         |   3 +
 drivers/pci/host/Kconfig            |   8 ++
 drivers/pci/host/Makefile           |   3 +-
 drivers/pci/host/pcie-designware.c  |   4 +-
 drivers/pci/host/pcie-designware.h  |   2 +
 drivers/pci/host/pcie-hisi-acpi.c   | 188 ++++++++++++++++++++++++++++++++++++
 drivers/pci/host/pcie-hisi-common.c |  73 ++++++++++++++
 drivers/pci/host/pcie-hisi.c        | 144 +++++++++++++--------------
 drivers/pci/host/pcie-hisi.h        |  25 +++++
 9 files changed, 367 insertions(+), 83 deletions(-)
 create mode 100644 drivers/pci/host/pcie-hisi-acpi.c
 create mode 100644 drivers/pci/host/pcie-hisi-common.c
 create mode 100644 drivers/pci/host/pcie-hisi.h

-- 
1.9.1
