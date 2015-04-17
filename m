From: dhdang@apm.com (Duc Dang)
Date: Fri, 17 Apr 2015 02:50:06 -0700
Subject: [PATCH v4 0/4] PCI: X-Gene: Add APM X-Gene v1 MSI/MSIX termination
 driver
In-Reply-To: <20150415091655.02361cdc@arm.com>
References: <20150415091655.02361cdc@arm.com>
Message-ID: <cover.1429263201.git.dhdang@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch set adds MSI/MSIX termination driver support for APM X-Gene v1 SoC.
APM X-Gene v1 SoC supports its own implementation of MSI, which is not compliant
to GIC V2M specification for MSI Termination.

There is single MSI block in X-Gene v1 SOC which serves all 5 PCIe ports. This MSI
block supports 2048 MSI termination ports coalesced into 16 physical HW IRQ lines
and shared across all 5 PCIe ports.

v4 changes:
	1. Remove affinity setting for each MSI
	2. Add description about register layout, MSI termination address and data
	3. Correct total number of MSI vectors to 2048
	4. Clean up error messages
	5. Remove unused module code

v3 changes:
        1. Implement MSI support using PCI MSI IRQ domain
        2. Only use msi_controller to store IRQ domain
v2 changes:
        1. Use msi_controller structure
        2. Remove arch hooks arch_teardown_msi_irqs and arch_setup_msi_irqs
 


 .../devicetree/bindings/pci/xgene-pci-msi.txt      |  63 ++++
 MAINTAINERS                                        |   8 +
 arch/arm64/boot/dts/apm/apm-storm.dtsi             |  27 ++
 drivers/pci/host/Kconfig                           |   6 +
 drivers/pci/host/Makefile                          |   1 +
 drivers/pci/host/pci-xgene-msi.c                   | 410 +++++++++++++++++++++
 drivers/pci/host/pci-xgene.c                       |  21 ++
 7 files changed, 536 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/xgene-pci-msi.txt
 create mode 100644 drivers/pci/host/pci-xgene-msi.c

-- 
1.9.1
