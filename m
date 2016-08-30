From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 30 Aug 2016 14:57:07 +0200
Subject: [PATCH 0/3] pcie-designware: support for external MSI controller
Message-ID: <1472561830-20932-1-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This short patch series extends the pcie-designware code to support
using an external MSI controller, rather than the built-in MSI
controller. It does so by making the pcie-designware driver handle the
"msi-parent" DT property.

The first patch updates the Device Tree binding documentation, the
second patch makes the change to the Designware PCIe controller driver
itself, and finally the third patch updates the Marvell Armada 7K/8K
Device Tree to use the msi-parent property.

Thanks,

Thomas

Thomas Petazzoni (3):
  dt-bindings: designware-pcie: document optional msi-parent property
  pci: pcie-designware: add support for external MSI controller
  arm64: dts: marvell: enable MSI for PCIe on Armada 7K/8K

 .../devicetree/bindings/pci/designware-pcie.txt    |  2 ++
 .../boot/dts/marvell/armada-cp110-master.dtsi      |  3 +++
 .../arm64/boot/dts/marvell/armada-cp110-slave.dtsi |  3 +++
 drivers/pci/host/pcie-designware.c                 | 24 ++++++++++++++++------
 4 files changed, 26 insertions(+), 6 deletions(-)

-- 
2.7.4
