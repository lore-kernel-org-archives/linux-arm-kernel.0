From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 28 May 2013 16:24:33 -0400
Subject: [GIT PULL 2/5] ARM: mvebu: pcie driver for v3.11 (round 2 cumulative)
In-Reply-To: <20130528202140.GG31290@titan.lakedaemon.net>
References: <20130528202140.GG31290@titan.lakedaemon.net>
Message-ID: <20130528202433.GH31290@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


The following changes since commit 4e23d3f505e8acfeac7cc33d4113fbb5a25c3090:

  of/pci: Add of_pci_parse_bus_range() function (2013-05-19 20:30:10 +0000)

are available in the git repository at:

  git://git.infradead.org/users/jcooper/linux.git tags/pcie-3.11-2

for you to fetch changes up to 3d9939c92efdd4ced672b94994959ca71b141cb8:

  pci: mvebu: fix return value check in mvebu_pcie_probe() (2013-05-27 15:51:56 +0000)

----------------------------------------------------------------
mvebu pcie driver for v3.11 (round 2, bugfix)

 - mvebu pcie
    - fix return value check in mvebu_pcie_probe()

depends
 - mvebu/of_pci

----------------------------------------------------------------
Thomas Petazzoni (4):
      clk: mvebu: create parent-child relation for PCIe clocks on Armada 370
      clk: mvebu: add more PCIe clocks for Armada XP
      pci: PCIe driver for Marvell Armada 370/XP systems
      arm: mvebu: PCIe support is now available on mvebu

Wei Yongjun (1):
      pci: mvebu: fix return value check in mvebu_pcie_probe()

 .../devicetree/bindings/pci/mvebu-pci.txt          | 220 ++++++
 arch/arm/mach-mvebu/Kconfig                        |   2 +
 drivers/clk/mvebu/clk-gating-ctrl.c                |  18 +-
 drivers/pci/Kconfig                                |   2 +
 drivers/pci/Makefile                               |   3 +
 drivers/pci/host/Kconfig                           |   8 +
 drivers/pci/host/Makefile                          |   1 +
 drivers/pci/host/pci-mvebu.c                       | 880 +++++++++++++++++++++
 8 files changed, 1128 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/mvebu-pci.txt
 create mode 100644 drivers/pci/host/Kconfig
 create mode 100644 drivers/pci/host/Makefile
 create mode 100644 drivers/pci/host/pci-mvebu.c
