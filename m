From: ryder.lee@mediatek.com (Ryder Lee)
Date: Fri, 28 Apr 2017 17:10:32 +0800
Subject: [PATCH v1 0/2] Add PCIe host driver support for Mediatek SoCs
Message-ID: <1493370634-7038-1-git-send-email-ryder.lee@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This patch series add Mediatek Gen2 PCIe host controller driver and
dt-binding document. It can be found on MT7623 series SoCs.

This driver was validated using Broadcom Tigon3 and Intel(R) 82575/82576
gigabit ethernet card.

Changes since v1:
- add .suppress_bind_attrs.
- remove unnecessary *_valid_device() pattern.
- remove PCI_PROBE_ONLY.
- use the regular readl() instead of readl_relaxed().
- add .map_bus() and change to use pci_generic_config_read/pci_generic_config_write.
- revise dt-binding document and move nonstandard properties to root node.
- change compatible string.
- use interrupt-map property and replace mtk_pcie_map_irq() with of_irq_parse_and_map_pci().
- use the new pci_register_host_bridge() method instead of pci_scan_root_bus().

Ryder Lee (2):
  PCI: mediatek: Add Mediatek PCIe host controller support
  dt-bindings: pcie: Add documentation for Mediatek PCIe

 .../bindings/pci/mediatek,gen2v1-pcie.txt          | 174 +++++++
 drivers/pci/host/Kconfig                           |  11 +
 drivers/pci/host/Makefile                          |   1 +
 drivers/pci/host/pcie-mediatek.c                   | 563 +++++++++++++++++++++
 4 files changed, 749 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/mediatek,gen2v1-pcie.txt
 create mode 100644 drivers/pci/host/pcie-mediatek.c

-- 
1.9.1
