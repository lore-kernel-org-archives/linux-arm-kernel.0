From: jg1.han@samsung.com (Jingoo Han)
Date: Wed, 12 Jun 2013 19:18:02 +0900
Subject: [PATCH V4 0/3] PCIe support for Samsung Exynos5440 SoC
Message-ID: <003001ce6756$1ef00d60$5cd02820$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This series of patches introduces PCIe support for Samsung Exynos5440,
and is based on the latest 'linux-next' tree (20130607).
These patches was tested with Intel e1000e LAN card on Exynos5440.

This PATCH v4 follows:
 * PATCH v3, sent on June, 6th 2013
 * PATCH v2, sent on March, 23rd 2013
 * PATCH v1, sent on March, 4th 2013
 
Changes between v3 and v4:
  * Added support for multi domains as reviewed by Jason Gunthorpe,
    and Arnd Bergmann.
  * Fixed both MEM space and I/O space in DT.
  * Removed redundant physical addresses from struct pcie_port,
    added devm_ioremap_resource() to make add_pcie_port() simpler.
  * Added clock names and clock enable/disable.
	
Changes between v2 and v3:
  * Rebased on the top of 3.10-rc4
  * Updated names of PCIe PHY registers
 
Changes between v1 and v2:
  * Moved Exynos PCIe driver from arch/arm to drivers/pci/host.
  * Added DT properties of PCI DT standard.

Thank you.

Best regards,
Jingoo Han


Jingoo Han (3):
  pci: Add PCIe driver for Samsung Exynos
  ARM: EXYNOS: Enable PCIe support for Exynos5440
  ARM: dts: Add pcie controller node for Samsung EXYNOS5440 SoC

 arch/arm/boot/dts/exynos5440-ssdk5440.dts |    8 ++++++
 arch/arm/boot/dts/exynos5440.dtsi         |   38 +++++++++++++++++++++++++++++
 arch/arm/Kconfig             |    1 +
 arch/arm/mach-exynos/Kconfig |    2 ++
 .../devicetree/bindings/pci/exynos-pcie.txt        |   71 ++
 drivers/pci/host/Kconfig                           |    5 +
 drivers/pci/host/Makefile                          |    1 +
 drivers/pci/host/pci-exynos.c                      | 1074 ++++++++++++++++++++
 8 files changed, 1200 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/exynos-pcie.txt
 create mode 100644 drivers/pci/host/pci-exynos.c

-- 
1.7.10.4
