From: Zhiqiang.Hou@nxp.com (Zhiqiang Hou)
Date: Tue, 19 Sep 2017 17:26:53 +0800
Subject: [PATCH 0/5] arm64: add ls1012a and ls1046a pcie support
Message-ID: <20170919092658.22482-1-Zhiqiang.Hou@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

This patch set adds ls1012a MSI and PCIe support, including driver
and device tree nodes. The ls1046a's MSI support patch and PCIe
driver patch has been applied, so only adds the PCIe device tree
nodes.

Hou Zhiqiang (5):
  irqchip/ls-scfg-msi: add LS1012a MSI support
  arm64: dts: ls1012a: Add MSI controller DT node
  PCI: layerscape: Add support for ls1012a
  arm64: dts: ls1012a: Add PCIe controller DT node
  arm64: dts: ls1046a: add PCIe controller DT nodes

 .../interrupt-controller/fsl,ls-scfg-msi.txt       |  1 +
 .../devicetree/bindings/pci/layerscape-pci.txt     |  1 +
 arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi     | 31 +++++++++
 arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi     | 75 ++++++++++++++++++++++
 drivers/irqchip/irq-ls-scfg-msi.c                  |  1 +
 drivers/pci/dwc/pci-layerscape.c                   |  1 +
 6 files changed, 110 insertions(+)

-- 
2.14.1
