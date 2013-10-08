From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 8 Oct 2013 11:49:11 -0400
Subject: [GIT PULL V2] ARM: mvebu: driver changes for v3.13
In-Reply-To: <20131007170206.GE15413@quad.lixom.net>
References: <20130930153643.GF31178@titan.lakedaemon.net>
 <20131007170206.GE15413@quad.lixom.net>
Message-ID: <20131008154911.GH5402@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Olof,

Here's the updated pull request for mvebu/drivers.  I've pulled the two
patches from mvebu/soc into this branch to prevent the dependency.
There is a trivial conflict with Sebastian's init_timer cleanup branch,
but that would happen anyway.

thx,

Jason.


The following changes since commit 272b98c6455f00884f0350f775c5342358ebb73f:

  Linux 3.12-rc1 (2013-09-16 16:17:51 -0400)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/drivers-3.13

for you to fetch changes up to 96ae0b548672adc12431312718835e77472f5bf0:

  ARM: mvebu: fix gated clock documentation (2013-10-08 15:17:56 +0000)

----------------------------------------------------------------
mvebu drivers changes for v3.13

 - irqchip
    - add MSI support for armada-370/XP

 - pci
    - add MSI support
    - add support for Marvell Dove SoCs

 - mvebu (soc changes depending on the pci and irq changes)
    - probe mbus windows via DT
    - probe pcie and clock via DT

 - docs for mvebu
    - update gated clock documentation

----------------------------------------------------------------
Gregory CLEMENT (1):
      ARM: mvebu: fix gated clock documentation

Sebastian Hesselbarth (7):
      PCI: mvebu: move clock enable before register access
      PCI: mvebu: increment nports only for registered ports
      PCI: mvebu: remove subsys_initcall
      PCI: mvebu: add support for reset on GPIO
      PCI: mvebu: add support for Marvell Dove SoCs
      ARM: dove: switch to DT probed mbus address windows
      ARM: dove: remove legacy pcie and clock init

Thomas Petazzoni (3):
      irqchip: armada-370-xp: properly request resources
      irqchip: armada-370-xp: implement MSI support
      PCI: mvebu: add support for MSI

 .../devicetree/bindings/arm/armada-370-xp-mpic.txt |   3 +
 .../bindings/clock/mvebu-gated-clock.txt           |  14 +-
 .../devicetree/bindings/pci/mvebu-pci.txt          |  10 +
 arch/arm/mach-dove/board-dt.c                      |  39 +---
 drivers/irqchip/irq-armada-370-xp.c                | 202 ++++++++++++++++++++-
 drivers/pci/host/Kconfig                           |   2 +-
 drivers/pci/host/pci-mvebu.c                       | 121 ++++++++----
 7 files changed, 307 insertions(+), 84 deletions(-)
