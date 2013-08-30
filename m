From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 30 Aug 2013 16:25:26 -0400
Subject: [GIT PULL V2 2/2] ARM: mvebu: MSI mvebu changes for v3.12
In-Reply-To: <20130814192317.GE13964@titan.lakedaemon.net>
References: <20130814191011.GD13964@titan.lakedaemon.net>
 <20130814192317.GE13964@titan.lakedaemon.net>
Message-ID: <20130830202526.GW19598@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof,

As requested, rebased on top of mvebu/drivers to resolve conflicts
internally.

thx,

Jason.


The following changes since commit 654ca4e5273bda7feccb47470b0e75ee2ce2cb69:

  Merge branch 'mvebu/msi_pci' into mvebu/msi_mvebu (2013-08-30 19:55:09 +0000)

are available in the git repository at:


  git://git.infradead.org/linux-mvebu.git tags/msi-mvebu-3.12

for you to fetch changes up to 8a047d867f271d1d0d97313134432929530d46c4:

  ARM: mvebu: link PCIe controllers to the MSI controller (2013-08-30 19:59:24 +0000)

----------------------------------------------------------------
mvebu-specific msi changes for v3.12

 - enable MSI on PCI for mvebu

V2:
 - rebase on top of mvebu/drivers

Depends:

 - mvebu/drivers (tag drivers-3.12)
 - mvebu/msi_pci (tag msi-3.12)

----------------------------------------------------------------
Thomas Petazzoni (5):
      irqchip: armada-370-xp: properly request resources
      irqchip: armada-370-xp: implement MSI support
      ARM: mvebu: the MPIC now provides MSI controller features
      PCI: mvebu: add support for MSI
      ARM: mvebu: link PCIe controllers to the MSI controller

 .../devicetree/bindings/arm/armada-370-xp-mpic.txt |   3 +
 .../devicetree/bindings/pci/mvebu-pci.txt          |   3 +
 arch/arm/boot/dts/armada-370-xp.dtsi               |   1 +
 arch/arm/boot/dts/armada-370.dtsi                  |   1 +
 arch/arm/boot/dts/armada-xp-mv78230.dtsi           |   1 +
 arch/arm/boot/dts/armada-xp-mv78260.dtsi           |   1 +
 arch/arm/boot/dts/armada-xp-mv78460.dtsi           |   1 +
 drivers/irqchip/irq-armada-370-xp.c                | 202 ++++++++++++++++++++-
 drivers/pci/host/pci-mvebu.c                       |  26 +++
 9 files changed, 234 insertions(+), 5 deletions(-)
