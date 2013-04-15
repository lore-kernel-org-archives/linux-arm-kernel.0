From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 15 Apr 2013 14:28:24 -0400
Subject: [GIT PULL 1/4] mvebu driver changes for v3.10
Message-ID: <20130415182824.GN28693@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


The following changes since commit 8bb9660418e05bb1845ac1a2428444d78e322cc7:

  Linux 3.9-rc4 (2013-03-23 16:52:44 -0700)

are available in the git repository at:

  git://git.infradead.org/users/jcooper/linux.git tags/drivers-3.10-2

for you to fetch changes up to 198d1ec0221f2e57f5d7f82294faeb81d822fd74:

  clk: mvebu: add more PCIe clocks for Armada XP (2013-04-15 17:52:12 +0000)

----------------------------------------------------------------
mvebu drivers for v3.10 round 2

 - mvebu
    - device bus driver (Acked by gregkh to go through arm-soc)
    - PCIe prep work Acked by appropriate maintainers (of,pci,clk) for arm-soc

----------------------------------------------------------------
Andrew Murray (3):
      of/pci: Unify pci_process_bridge_OF_ranges from Microblaze and PowerPC
      of/pci: Provide support for parsing PCI DT ranges property
      of/pci: mips: convert to common of_pci_range_parser

Ezequiel Garcia (1):
      drivers: memory: Introduce Marvell EBU Device Bus driver

Neil Greatorex (1):
      bus: mvebu-mbus: Restore checking for coherency fabric hardware

Thierry Reding (2):
      of/pci: Add of_pci_get_devfn() function
      of/pci: Add of_pci_parse_bus_range() function

Thomas Petazzoni (5):
      bus: introduce an Marvell EBU MBus driver
      bus: mvebu: fix mistake in PCIe window target attribute for Kirkwood
      pci: infrastructure to add drivers in drivers/pci/host
      clk: mvebu: create parent-child relation for PCIe clocks on Armada 370
      clk: mvebu: add more PCIe clocks for Armada XP

 .../bindings/memory-controllers/mvebu-devbus.txt   | 156 ++++
 arch/microblaze/include/asm/pci-bridge.h           |   5 +-
 arch/microblaze/pci/pci-common.c                   | 192 -----
 arch/mips/pci/pci.c                                |  50 +-
 arch/powerpc/include/asm/pci-bridge.h              |   5 +-
 arch/powerpc/kernel/pci-common.c                   | 192 -----
 drivers/bus/Kconfig                                |   7 +
 drivers/bus/Makefile                               |   1 +
 drivers/bus/mvebu-mbus.c                           | 870 +++++++++++++++++++++
 drivers/clk/mvebu/clk-gating-ctrl.c                |  18 +-
 drivers/memory/Kconfig                             |  10 +
 drivers/memory/Makefile                            |   1 +
 drivers/memory/mvebu-devbus.c                      | 340 ++++++++
 drivers/of/address.c                               |  66 ++
 drivers/of/of_pci.c                                | 228 +++++-
 drivers/pci/Kconfig                                |   2 +
 drivers/pci/Makefile                               |   3 +
 drivers/pci/host/Kconfig                           |   4 +
 drivers/pci/host/Makefile                          |   1 +
 include/linux/mbus.h                               |  24 +-
 include/linux/of_address.h                         |  46 ++
 include/linux/of_pci.h                             |   6 +
 22 files changed, 1789 insertions(+), 438 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/mvebu-devbus.txt
 create mode 100644 drivers/bus/mvebu-mbus.c
 create mode 100644 drivers/memory/mvebu-devbus.c
 create mode 100644 drivers/pci/host/Kconfig
 create mode 100644 drivers/pci/host/Makefile
