From: zhiqiang.hou@nxp.com (Z.q. Hou)
Date: Tue, 20 Nov 2018 09:25:35 +0000
Subject: [PATCHv2 00/25] PCI: refactor Mobiveil driver and add PCIe Gen4
 driver for NXP Layerscape SoCs
Message-ID: <20181120092615.11680-1-Zhiqiang.Hou@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

This patch set is aim to refactor the Mobiveil driver and add
PCIe support for NXP Layerscape series SoCs integrated Mobiveil's
PCIe Gen4 controller.

Hou Zhiqiang (25):
  PCI: mobiveil: uniform the register accessors
  PCI: mobiveil: format the code without function change
  PCI: mobiveil: correct the returned error number
  PCI: mobiveil: remove flag MSI_FLAG_MULTI_PCI_MSI
  PCI: mobiveil: correct PCI base address in MEM/IO outbound windows
  PCI: mobiveil: replace the resource list iteration function
  PCI: mobiveil: use WIN_NUM_0 explicitly for CFG outbound window
  PCI: mobiveil: use the 1st inbound window for MEM inbound transactions
  PCI: mobiveil: correct inbound/outbound window setup routines
  PCI: mobiveil: fix the INTx process error
  PCI: mobiveil: only fix up the Class Code field
  PCI: mobiveil: move out the link up waiting from mobiveil_host_init
  PCI: mobiveil: move irq chained handler setup out of DT parse
  PCI: mobiveil: initialize Primary/Secondary/Subordinate bus number
  dt-bindings: pci: mobiveil: change gpio_slave and apb_csr to optional
  PCI: mobiveil: refactor Mobiveil PCIe Host Bridge IP driver
  PCI: mobiveil: fix the checking of valid device
  PCI: mobiveil: continue to initialize the host upon no PCIe link
  PCI: mobiveil: disabled IB and OB windows set by bootloader
  PCI: mobiveil: add Byte and Half-Word width register accessors
  PCI: mobiveil: make mobiveil_host_init can be used to re-init host
  dt-bindings: pci: Add NXP Layerscape SoCs PCIe Gen4 controller
  PCI: mobiveil: add PCIe Gen4 RC driver for NXP Layerscape SoCs
  arm64: dts: freescale: lx2160a: add pcie DT nodes
  arm64: defconfig: Enable CONFIG_PCI_LAYERSCAPE_GEN4

 .../bindings/pci/layerscape-pci.txt           |  57 ++
 .../devicetree/bindings/pci/mobiveil-pcie.txt |   2 +
 MAINTAINERS                                   |  10 +-
 .../arm64/boot/dts/freescale/fsl-lx2160a.dtsi | 163 ++++
 arch/arm64/configs/defconfig                  |   1 +
 drivers/pci/controller/Kconfig                |  11 +-
 drivers/pci/controller/Makefile               |   2 +-
 drivers/pci/controller/mobiveil/Kconfig       |  34 +
 drivers/pci/controller/mobiveil/Makefile      |   5 +
 .../controller/mobiveil/pci-layerscape-gen4.c | 254 ++++++
 .../controller/mobiveil/pcie-mobiveil-host.c  | 628 +++++++++++++
 .../controller/mobiveil/pcie-mobiveil-plat.c  |  54 ++
 .../pci/controller/mobiveil/pcie-mobiveil.c   | 246 +++++
 .../pci/controller/mobiveil/pcie-mobiveil.h   | 222 +++++
 drivers/pci/controller/pcie-mobiveil.c        | 861 ------------------
 15 files changed, 1677 insertions(+), 873 deletions(-)
 create mode 100644 drivers/pci/controller/mobiveil/Kconfig
 create mode 100644 drivers/pci/controller/mobiveil/Makefile
 create mode 100644 drivers/pci/controller/mobiveil/pci-layerscape-gen4.c
 create mode 100644 drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
 create mode 100644 drivers/pci/controller/mobiveil/pcie-mobiveil-plat.c
 create mode 100644 drivers/pci/controller/mobiveil/pcie-mobiveil.c
 create mode 100644 drivers/pci/controller/mobiveil/pcie-mobiveil.h
 delete mode 100644 drivers/pci/controller/pcie-mobiveil.c

-- 
2.17.1
