From: sean.wang@mediatek.com (sean.wang at mediatek.com)
Date: Sun, 18 Feb 2018 03:54:35 +0800
Subject: [PATCH v3 00/15] add dts nodes to MT7622 SoC
Message-ID: <cover.1518895232.git.sean.wang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sean Wang <sean.wang@mediatek.com>

Changes since v2:
- rebase to 4.16-rc1 and solve all conflicts
- add proper list Cc in patch 1
- add fixup in patch 4 in v2 with the uniform pinmux definition
  that is always adding property function before property groups
- add Acked-by from Philippe in patch 5
- add clock related property into all CPU nodes in patch 6
- merge patch 14 in v2 into patch 8 as this is where the node is
  defined in the first place

Changes since v1:
- add usb, thermal, HSDMA, mmc related nodes
- fix Warning (unit_address_vs_reg): Node /oscillator at 0 has
  a unit name, but no reg property in patch 2
- fix Warning (pci_bridge): Node /pcie at 1a140000/pcie at 0,0 missing
  bus-range for PCI bridge
- fix Warning (pci_bridge): Node /pcie at 1a140000/pcie at 1,0 missing
  bus-range for PCI bridge
- fix Warning (unit_address_format): Failed prerequisite 'pci_bridge'
- fix Warning (pci_device_reg): Failed prerequisite 'pci_bridge'
- fix Warning (pci_device_bus_num): Failed prerequisite 'pci_bridge'
- enhance commit log in patch 4
- use - instead of _ in DT node name in patch 4 and 6
- use SPDX-License-Identifier for newly added files in patch 5
- use proper #size-cells for spi nor nodes in patch 9
- remove currently no needed #address-cells and #size-cells in
children nodes of spi nor in patch 9.

Chunfeng Yun (1):
  arm64: dts: mt7622: add usb device nodes

Ryder Lee (2):
  arm64: dts: mt7622: add PCIe device nodes
  arm64: dts: mt7622: add SATA device nodes

Sean Wang (12):
  dt-bindings: clock: mediatek: add missing required #reset-cells
  arm64: dts: mt7622: add clock controller device nodes
  arm64: dts: mt7622: add power domain controller device nodes
  arm64: dts: mt7622: add pinctrl related device nodes
  arm64: dts: mt7622: add PMIC MT6380 related nodes
  arm64: dts: mt7622: add cpufreq related device nodes
  arm64: dts: mt7622: turn uart0 clock to real ones
  arm64: dts: mt7622: add SoC and peripheral related device nodes
  arm64: dts: mt7622: add flash related device nodes
  arm64: dts: mt7622: add ethernet device nodes
  arm64: dts: mt7622: add High-Speed DMA device nodes
  arm64: dts: mt7622: add mmc related device nodes

 .../bindings/arm/mediatek/mediatek,ethsys.txt      |   1 +
 .../bindings/arm/mediatek/mediatek,pciesys.txt     |   2 +
 .../bindings/arm/mediatek/mediatek,ssusbsys.txt    |   2 +
 arch/arm64/boot/dts/mediatek/mt6380.dtsi           |  86 +++
 arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts       | 469 ++++++++++++++
 arch/arm64/boot/dts/mediatek/mt7622.dtsi           | 685 ++++++++++++++++++++-
 6 files changed, 1240 insertions(+), 5 deletions(-)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt6380.dtsi

-- 
2.7.4
