From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 30 Sep 2013 11:36:43 -0400
Subject: [GIT PULL] ARM: mvebu: driver changes for v3.13
Message-ID: <20130930153643.GF31178@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Guys,

Here are all of the driver changes that didn't make it during the last
merge window.  They've been in -next since v3.12-rc1, without
merge-conflicts or build issues.

thx,

Jason.

The following changes since commit 272b98c6455f00884f0350f775c5342358ebb73f:

  Linux 3.12-rc1 (2013-09-16 16:17:51 -0400)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/drivers-3.13

for you to fetch changes up to cc54ccd9a6966708c00ebd8a08acc3e627a432c5:

  PCI: mvebu: add support for Marvell Dove SoCs (2013-09-30 14:58:47 +0000)

----------------------------------------------------------------
mvebu drivers changes for v3.13

 - irqchip
    - add MSI support for armada-370/XP
 - pci
    - add MSI support
    - add support for Marvell Dove SoCs

----------------------------------------------------------------
Sebastian Hesselbarth (5):
      PCI: mvebu: move clock enable before register access
      PCI: mvebu: increment nports only for registered ports
      PCI: mvebu: remove subsys_initcall
      PCI: mvebu: add support for reset on GPIO
      PCI: mvebu: add support for Marvell Dove SoCs

Thomas Petazzoni (3):
      irqchip: armada-370-xp: properly request resources
      irqchip: armada-370-xp: implement MSI support
      PCI: mvebu: add support for MSI

 .../devicetree/bindings/arm/armada-370-xp-mpic.txt |   3 +
 .../devicetree/bindings/pci/mvebu-pci.txt          |  10 +
 drivers/irqchip/irq-armada-370-xp.c                | 202 ++++++++++++++++++++-
 drivers/pci/host/Kconfig                           |   2 +-
 drivers/pci/host/pci-mvebu.c                       | 121 ++++++++----
 5 files changed, 298 insertions(+), 40 deletions(-)
