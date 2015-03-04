From: dhdang@apm.com (Duc Dang)
Date: Wed,  4 Mar 2015 11:39:56 -0800
Subject: [PATCH v2 0/4] PCI: X-Gene: Add APM X-Gene v1 MSI/MSIX termination
 driver
In-Reply-To: <1678162.2PJ2o1jRen@wuerfel>
References: <1678162.2PJ2o1jRen@wuerfel>
Message-ID: <cover.1425497218.git.dhdang@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch set adds MSI/MSIX termination driver support for APM X-Gene v1 SoC.
APM X-Gene v1 SoC supports its own implementation of MSI, which is not compliant
to GIC V2M specification for MSI Termination.

There is single MSI block in X-Gene v1 SOC which serves all 5 PCIe ports. This MSI
block supports 2688 MSI termination ports coalesced into 16 physical HW IRQ lines
and shared across all 5 PCIe ports.

v2 changes:
        1. Use msi_controller structure
        2. Remove arch hooks arch_teardown_msi_irqs and arch_setup_msi_irqs

 .../devicetree/bindings/pci/xgene-pci-msi.txt      |  61 ++++
 MAINTAINERS                                        |   8 +
 arch/arm64/boot/dts/apm/apm-storm.dtsi             |  27 ++
 drivers/pci/host/Kconfig                           |   4 +
 drivers/pci/host/Makefile                          |   1 +
 drivers/pci/host/pci-xgene-msi.c                   | 393 +++++++++++++++++++++
 drivers/pci/host/pci-xgene.c                       |  25 ++
 7 files changed, 519 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/xgene-pci-msi.txt
 create mode 100644 drivers/pci/host/pci-xgene-msi.c

-- 
1.9.1
