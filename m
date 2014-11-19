From: wangyijing@huawei.com (Yijing Wang)
Date: Wed, 19 Nov 2014 15:32:44 +0800
Subject: [PATCH 0/5] PCI scan interfaces clean up
Message-ID: <1416382369-13587-1-git-send-email-wangyijing@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Yijing Wang (5):
  PCI: Rip out pci_bus_add_devices() from pci_scan_bus()
  PCI: Introduce pci_scan_bus_simple()
  PCI: Use pci_scan_bus_simple() in simple scene.
  PCI: Remove pci_scan_bus() and pci_scan_bus_parented()
  PCI: Rip out pci_bus_add_devices() from pci_scan_root_bus()

 arch/alpha/kernel/pci.c           |    2 ++
 arch/alpha/kernel/sys_nautilus.c  |    3 ++-
 arch/frv/mb93090-mb00/pci-vdk.c   |    6 ++++--
 arch/ia64/sn/kernel/io_init.c     |    1 +
 arch/m68k/coldfire/pci.c          |    3 ++-
 arch/microblaze/pci/pci-common.c  |    1 +
 arch/mips/pci/pci.c               |    1 +
 arch/mn10300/unit-asb2305/pci.c   |    5 ++++-
 arch/s390/pci/pci.c               |    2 +-
 arch/sh/drivers/pci/pci.c         |    1 +
 arch/sparc/kernel/leon_pci.c      |    1 +
 arch/sparc/kernel/pcic.c          |    5 ++++-
 arch/tile/kernel/pci.c            |    2 ++
 arch/tile/kernel/pci_gx.c         |    2 ++
 arch/unicore32/kernel/pci.c       |   15 +++++----------
 arch/x86/pci/common.c             |    1 +
 arch/xtensa/kernel/pci.c          |    2 ++
 drivers/pci/host/pci-xgene.c      |    1 +
 drivers/pci/hotplug/ibmphp_core.c |    7 +++++--
 drivers/pci/probe.c               |   26 ++------------------------
 drivers/pci/xen-pcifront.c        |    2 +-
 include/linux/pci.h               |    3 +--
 22 files changed, 46 insertions(+), 46 deletions(-)
