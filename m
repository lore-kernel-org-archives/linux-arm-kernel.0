From: jchandra@broadcom.com (Jayachandran C)
Date: Thu, 3 Dec 2015 03:54:43 +0530
Subject: [RFC PATCH 0/3] ACPI PCI support for arm64
Message-ID: <1449095086-5138-1-git-send-email-jchandra@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a very simple and generic implementation of a PCI host controller
based on ACPI. This approach does not pull in the MMCONFIG and ECAM code
from x86.

It is important for us to have a working ACPI based PCI host controller
implementation for arm64, so I thought I would post this as a simple
and less disruptive alternative.

This is tested with arm64 QEMU and OVMF. Comments are very welcome.

Thanks,
JC.

Jayachandran C (3):
  arm64: pci: Add ACPI support
  pci: Handle NULL parent in pci_bus_assign_domain_nr
  pci/host : Add a generic ACPI based host controller

 arch/arm64/kernel/pci.c          |  47 ++++++++-
 drivers/pci/host/Kconfig         |   7 ++
 drivers/pci/host/Makefile        |   1 +
 drivers/pci/host/pci-host-acpi.c | 211 +++++++++++++++++++++++++++++++++++++++
 drivers/pci/pci.c                |   7 +-
 5 files changed, 270 insertions(+), 3 deletions(-)
 create mode 100644 drivers/pci/host/pci-host-acpi.c

-- 
1.9.1
