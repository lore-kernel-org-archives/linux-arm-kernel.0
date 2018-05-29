From: ray.jui@broadcom.com (Ray Jui)
Date: Tue, 29 May 2018 14:58:44 -0700
Subject: [PATCH 0/6] PAXB INTx support with proper model
Message-ID: <1527631130-20045-1-git-send-email-ray.jui@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series adds PCIe legacy interrupt (INTx) support to the iProc
PCIe driver by modeling it with its own IRQ domain. All 4 interrupts INTA,
INTB, INTC, INTD share the same interrupt line connected to the GIC
in the system. This is now modeled by using its own IRQ domain.

Also update all relevant devicetree files to adapt to the new model

This patch series is available on GIHUB:
repo: https://github.com/Broadcom/arm64-linux.git
branch: pcie-intx-v1

Ray Jui (6):
  PCI: iproc: Update iProc PCI binding for INTx support
  PCI: iproc: Add INTx support with better modeling
  arm: dts: Change PCIe INTx mapping for Cygnus
  arm: dts: Change PCIe INTx mapping for NSP
  arm: dts: Change PCIe INTx mapping for HR2
  arm64: dts: Change PCIe INTx mapping for NS2

 .../devicetree/bindings/pci/brcm,iproc-pcie.txt    | 31 +++++--
 arch/arm/boot/dts/bcm-cygnus.dtsi                  | 18 +++-
 arch/arm/boot/dts/bcm-hr2.dtsi                     | 18 +++-
 arch/arm/boot/dts/bcm-nsp.dtsi                     | 27 ++++--
 arch/arm64/boot/dts/broadcom/northstar2/ns2.dtsi   | 19 +++--
 drivers/pci/host/pcie-iproc-platform.c             |  2 +
 drivers/pci/host/pcie-iproc.c                      | 95 +++++++++++++++++++++-
 drivers/pci/host/pcie-iproc.h                      |  6 ++
 8 files changed, 188 insertions(+), 28 deletions(-)

-- 
2.1.4
