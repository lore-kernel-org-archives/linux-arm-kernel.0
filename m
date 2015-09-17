From: ddaney.cavm@gmail.com (David Daney)
Date: Thu, 17 Sep 2015 15:41:31 -0700
Subject: [PATCH 0/3] PCI: Add support for Cavium ThunderX RC and on-SoC
 devices.
Message-ID: <1442529694-1792-1-git-send-email-ddaney.cavm@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: David Daney <david.daney@cavium.com>

The Cavium ThunderX arm64 based SoC needs a little bit of special
handling for both its PCIe Root Complexes as well as on-SoC devices
(which all appear as PCIe devices).

1/3 - Small change to allow SRIOV BARs to be given fixed addresses in
      the header fixup.

2/3 - Add quirks to support fixed BAR addresses for all on-SoC devices,
      including SRIOV BARs in the NIC.

3/3 - Add config spaces accessors to pci-host-generic driver for ThunderX RC.

This patch set depends on:

https://lkml.org/lkml/2015/9/17/799

David Daney (3):
  PCI: Allow quirks to override SRIOV BARs.
  PCI: Add quirks for devices found on Cavium ThunderX SoCs.
  PCI: generic: Add support for Cavium ThunderX PCIe root complexes.

 .../devicetree/bindings/pci/host-generic-pci.txt   |  8 +-
 drivers/pci/host/Kconfig                           |  6 ++
 drivers/pci/host/Makefile                          |  1 +
 drivers/pci/host/pci-host-generic.c                | 29 +++++++
 drivers/pci/host/quirks-thunder.c                  | 95 ++++++++++++++++++++++
 drivers/pci/iov.c                                  |  9 +-
 6 files changed, 143 insertions(+), 5 deletions(-)
 create mode 100644 drivers/pci/host/quirks-thunder.c

-- 
1.9.1
