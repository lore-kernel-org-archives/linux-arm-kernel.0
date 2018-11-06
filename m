From: zhiqiang.hou@nxp.com (Z.q. Hou)
Date: Tue, 6 Nov 2018 13:19:03 +0000
Subject: [PATCH 00/23] PCI: refactor the Mobiveil driver and add PCIe support
 for NXP LX SoCs
Message-ID: <20181106131807.29951-1-Zhiqiang.Hou@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

This patch set is aim to refactor the Mobiveil driver and add
PCIe support for NXP LX series SoCs.

Hou Zhiqiang (23):
  PCI: mobiveil: uniform the register accessors
  PCI: mobiveil: format the code without function change
  PCI: mobiveil: correct the returned error number
  PCI: mobiveil: remove flag MSI_FLAG_MULTI_PCI_MSI
  PCI: mobiveil: correct PCI base address in MEM/IO outbound windows
  PCI: mobiveil: replace the resource list iteration function
  PCI: mobiveil: use WIN_NUM_0 explicitly for CFG outbound window
  PCI: mobiveil: use the 1st inbound window for MEM inbound transactions
  PCI: mobiveil: correct the inbound/outbound window setup routine
  PCI: mobiveil: fix the INTx process error
  PCI: mobiveil: only fixup the Class Code field
  PCI: mobiveil: move out the link up waiting from mobiveil_host_init
  PCI: mobiveil: move irq chained handler setup out of DT parse
  PCI: mobiveil: initialize Primary/Secondary/Subordinate bus number
  dt-bindings: pci: mobiveil: change gpio_slave and apb_csr to optional
  PCI: mobiveil: refactor the Mobiveil driver
  PCI: mobiveil: continue to initialize the host upon no PCIe link
  PCI: mobiveil: disabled IB and OB windows set by bootloader
  PCI: mobiveil: add Byte and Half-Word width register accessors
  PCI: mobiveil: change prototype of function mobiveil_host_init
  dt-bindings: pci: Add NXP LX SoCs PCIe controller
  PCI: mobiveil: add PCIe RC driver for NXP LX series SoCs
  arm64: dts: freescale: lx2160a: add pcie DT nodes

 .../devicetree/bindings/pci/lx-pci.txt        |  52 ++
 .../devicetree/bindings/pci/mobiveil-pcie.txt |   2 +
 MAINTAINERS                                   |  10 +-
 .../arm64/boot/dts/freescale/fsl-lx2160a.dtsi | 157 ++++
 drivers/pci/controller/Kconfig                |  11 +-
 drivers/pci/controller/Makefile               |   2 +-
 drivers/pci/controller/mobiveil/Kconfig       |  34 +
 drivers/pci/controller/mobiveil/Makefile      |   5 +
 drivers/pci/controller/mobiveil/pci-lx.c      | 222 +++++
 .../controller/mobiveil/pcie-mobiveil-host.c  | 622 +++++++++++++
 .../controller/mobiveil/pcie-mobiveil-plat.c  |  54 ++
 .../pci/controller/mobiveil/pcie-mobiveil.c   | 245 +++++
 .../pci/controller/mobiveil/pcie-mobiveil.h   | 221 +++++
 drivers/pci/controller/pcie-mobiveil.c        | 861 ------------------
 14 files changed, 1625 insertions(+), 873 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/lx-pci.txt
 create mode 100644 drivers/pci/controller/mobiveil/Kconfig
 create mode 100644 drivers/pci/controller/mobiveil/Makefile
 create mode 100644 drivers/pci/controller/mobiveil/pci-lx.c
 create mode 100644 drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
 create mode 100644 drivers/pci/controller/mobiveil/pcie-mobiveil-plat.c
 create mode 100644 drivers/pci/controller/mobiveil/pcie-mobiveil.c
 create mode 100644 drivers/pci/controller/mobiveil/pcie-mobiveil.h
 delete mode 100644 drivers/pci/controller/pcie-mobiveil.c

-- 
2.17.1
