From: dhdang@apm.com (Duc Dang)
Date: Tue,  6 Jan 2015 08:15:40 -0800
Subject: [PATCH 0/4] PCI: X-Gene: Add APM X-Gene v1 MSI/MSIX termination driver
Message-ID: <cover.1420499393.git.dhdang@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch set adds MSI/MSIX termination driver support for APM X-Gene v1 SoC.
APM X-Gene v1 SoC supports its own implementation of MSI, which is not compliant
to GIC V2M specification for MSI Termination.

There is single MSI block in X-Gene v1 SOC which serves all 5 PCIe ports. This MSI
block supports 2688 MSI termination ports coalesced into 16 physical HW IRQ lines 
and shared across all 5 PCIe ports.

 .../devicetree/bindings/pci/xgene-pci-msi.txt      |  34 ++
 MAINTAINERS                                        |   8 +
 arch/arm64/boot/dts/apm/apm-storm.dtsi             |  21 ++
 drivers/pci/host/Kconfig                           |   4 +
 drivers/pci/host/Makefile                          |   1 +
 drivers/pci/host/pci-xgene-msi.c                   | 370 +++++++++++++++++++++
 6 files changed, 438 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/xgene-pci-msi.txt
 create mode 100644 drivers/pci/host/pci-xgene-msi.c

-- 
1.9.1
