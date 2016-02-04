From: gabriele.paoloni@huawei.com (Gabriele Paoloni)
Date: Thu, 4 Feb 2016 19:37:36 +0800
Subject: [RFC PATCH 0/4] Add ACPI support for HiSilicon PCIe Host Controllers
Message-ID: <1454585860-60709-1-git-send-email-gabriele.paoloni@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: gabriele paoloni <gabriele.paoloni@huawei.com>

This patchset adds ACPI support for the HiSilicon Hip05/Hip06 SoC PCIe controllers
The four patches respectively:
        - rework PCie Designware to be used for ACPI PCI Host controllers
        - re-architect the current HiSilicon driver to make it scalable to the
          new ACPI quirks
	- rework the current HiSilicon driver to make it ECAM compliant
        - adds the HiSilicon ACPI specific quirks.

   This patchset  is based on 
   https://github.com/semihalf-nowicki-tomasz/linux.git
   branch pci-acpi-v3 + Hip06 support applied on top:
   https://patchwork.ozlabs.org/patch/549198/

gabriele paoloni (4):
  PCI: Designware: Add support for ACPI based controllers
  PCI: hisi: re-architect Hip05/Hip06 controllers driver to preapare for
    ACPI
  PCI: hisi: Make the HiSilicon PCIe host controller ECAM compliant
  PCI/ACPI: hisi: Add ACPI support for HiSilicon SoCs Host Controllers

 .../devicetree/bindings/pci/hisilicon-pcie.txt     |   4 +-
 MAINTAINERS                                        |   3 +
 drivers/pci/host/Kconfig                           |   9 ++
 drivers/pci/host/Makefile                          |   3 +-
 drivers/pci/host/pcie-designware.c                 |  39 +++++-
 drivers/pci/host/pcie-designware.h                 |   1 +
 drivers/pci/host/pcie-hisi-acpi.c                  | 147 ++++++++++++++++++++
 drivers/pci/host/pcie-hisi-common.c                | 103 ++++++++++++++
 drivers/pci/host/pcie-hisi.c                       | 149 ++++++---------------
 drivers/pci/host/pcie-hisi.h                       |  50 +++++++
 10 files changed, 390 insertions(+), 118 deletions(-)
 create mode 100644 drivers/pci/host/pcie-hisi-acpi.c
 create mode 100644 drivers/pci/host/pcie-hisi-common.c
 create mode 100644 drivers/pci/host/pcie-hisi.h

-- 
1.9.1
