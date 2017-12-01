From: vigneshr@ti.com (Vignesh R)
Date: Fri, 1 Dec 2017 11:43:07 +0530
Subject: [PATCH 0/4] pci-dra7xx: Fix legacy IRQ handling and errata handling
Message-ID: <20171201061311.16691-1-vigneshr@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series contains two fixes:
1. Make workaround for errata i870 applicable in Host mode as
well(previously it was enabled only for EP mode) as per errata
documentation: http://www.ti.com/lit/er/sprz429k/sprz429k.pdf
2. Fix problem with handling of legacy INTD interrupts.

Tested on 66AK2G EVM and ICE boards


Vignesh R (4):
  pci: dwc: pci-dra7xx: Enable errata i870 for both EP and RC mode
  dt-bindings: PCI: dra7xx: Add bindings for unaligned access in host
    mode
  ARM: dts: dra7: Add DT property to allow unaligned mem access to PCIe
    RC
  PCI: dwc: pci-dra7xx: Fix legacy IRQ handling

 Documentation/devicetree/bindings/pci/ti-pci.txt |  5 +++++
 arch/arm/boot/dts/dra7.dtsi                      |  2 ++
 drivers/pci/dwc/pci-dra7xx.c                     | 23 ++++++++++++++---------
 3 files changed, 21 insertions(+), 9 deletions(-)

-- 
2.15.0
