From: tinamdar@apm.com (Tanmay Inamdar)
Date: Fri, 24 Jan 2014 13:32:44 -0800
Subject: [RFC PATCH V3 0/4] APM X-Gene PCIe controller
Message-ID: <1390599168-13150-1-git-send-email-tinamdar@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for AppliedMicro X-Gene PCIe host controller. The
driver is tested on X-Gene platform with different gen1/2/3 PCIe endpoint
cards.

X-Gene PCIe controller driver has depedency on the pcie arch support for
arm64. The arm64 pcie arch support is not yet part of mainline Linux kernel
and approach for arch support is under discussion with arm64 maintainers.
The reference patch can be found here --> https://lkml.org/lkml/2013/10/23/244

If someone wishes to test PCIe on X-Gene, arch support patch must be applied
before the patches in this patch set.

changes since V2:
1. redefined each PCI port in different PCI domain correctly.
2. removed setup_lane and setup_link functions from driver.
3. removed scan_bus wrapper and set_primary_bus hack.
4. added pci_ioremap_io for io resources.

changes since V1:
1. added PCI domain support
2. reading cpu and pci addresses from device tree to configure regions.
3. got rid of unnecessary wrappers for readl and writel.
4. got rid of endpoint configuration code.
5. added 'dma-ranges' property support to read inbound region configuration.
6. renamed host driver file to 'pci-xgene.c' from 'pcie-xgene.c'
7. dropped 'clock-names' property from bindings
8. added comments whereever requested.

Tanmay Inamdar (4):
  pci: APM X-Gene PCIe controller driver
  arm64: dts: APM X-Gene PCIe device tree nodes
  dt-bindings: pci: xgene pcie device tree bindings
  MAINTAINERS: entry for APM X-Gene PCIe host driver

 .../devicetree/bindings/pci/xgene-pci.txt          |   52 ++
 MAINTAINERS                                        |    7 +
 arch/arm64/boot/dts/apm-mustang.dts                |    8 +
 arch/arm64/boot/dts/apm-storm.dtsi                 |  155 ++++
 drivers/pci/host/Kconfig                           |   10 +
 drivers/pci/host/Makefile                          |    1 +
 drivers/pci/host/pci-xgene.c                       |  784 ++++++++++++++++++++
 7 files changed, 1017 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/xgene-pci.txt
 create mode 100644 drivers/pci/host/pci-xgene.c

-- 
1.7.9.5
