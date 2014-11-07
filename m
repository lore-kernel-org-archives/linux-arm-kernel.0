From: tomasz.nowicki@linaro.org (Tomasz Nowicki)
Date: Fri,  7 Nov 2014 14:27:52 +0100
Subject: [RFC PATCH 0/4] MMCFG refactoring + PCI ACPI probing for ARM64
Message-ID: <1415366876-30811-1-git-send-email-tomasz.nowicki@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch set can be break down into two logic parts:
1. patch 1,2 - MMCONFIG code refacoring. MMCFG ACPI table has no arch
dependencies so it can be used across other architectures.
2. patch 3,4 aim for PCI ACPI probing on ARM64

Patches tested on Cavium ThunderX simulator with the latest ACPI ARM64 core set:
http://www.serverphorums.com/read.php?12,997228

Tomasz Nowicki (4):
  x86, acpi, pci: Move arch-agnostic MMCFG code out of arch/x86/
    directory.
  x86, acpi, pci: Isolate new PCI mmconfig entry insertion.
  arm64, acpi, pci: Add arch specific functions for mmconfig driver.
  arm64, acpi, pci: Provide arch-specific calls for PCI host bridge
    dirver (PNP0A03).

 arch/arm64/Kconfig             |   3 +
 arch/arm64/include/asm/pci.h   |   8 +
 arch/arm64/kernel/Makefile     |   1 +
 arch/arm64/kernel/mmconfig.c   |  69 +++++++
 arch/arm64/kernel/pci.c        | 401 +++++++++++++++++++++++++++++++++++++++--
 arch/x86/include/asm/pci_x86.h |  29 ---
 arch/x86/pci/acpi.c            |   1 +
 arch/x86/pci/init.c            |   1 +
 arch/x86/pci/mmconfig-shared.c | 176 +-----------------
 arch/x86/pci/mmconfig_32.c     |   1 +
 arch/x86/pci/mmconfig_64.c     |   1 +
 drivers/acpi/Makefile          |   1 +
 drivers/acpi/bus.c             |   1 +
 drivers/acpi/mmconfig.c        | 204 +++++++++++++++++++++
 include/linux/mmconfig.h       |  57 ++++++
 include/linux/pci.h            |   8 -
 16 files changed, 738 insertions(+), 224 deletions(-)
 create mode 100644 arch/arm64/kernel/mmconfig.c
 create mode 100644 drivers/acpi/mmconfig.c
 create mode 100644 include/linux/mmconfig.h

-- 
1.9.1
