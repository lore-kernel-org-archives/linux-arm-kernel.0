From: rjui@broadcom.com (Ray Jui)
Date: Mon, 13 Jul 2015 18:39:11 -0700
Subject: [PATCH 0/4] Add Broadcom North Star 2 support
Message-ID: <1436837955-26279-1-git-send-email-rjui@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series adds Broadcom North Star 2 (NS2) SoC support. NS2 is an ARMv8
based SoC and under the Broadcom iProc family.

Sorry for tying this with the Broadcom iProc PCIe driver fixes for ARM64. I
have to tie them together because iProc PCIe support is enabled by default
when ARCH_BCM_IPROC is enabled. Without the fixes in the iProc PCIe driver,
enabling CONFIG_ARCH_BCM_IPROC would break the build for arm64 defconfig. Let
me know if there's a better way to handle this.

This patch series is generated based on v4.2-rc2 and tested on Broadcom NS2 SVK

Ray Jui (4):
  PCI: iproc: enable arm64 support for iProc PCIe
  PCI: iproc: Fix ARM64 dependency in Kconfig
  arm64: Add Broadcom's North Star 2 support
  arm64: dts: Add Broadcom North Star 2 support

 Documentation/devicetree/bindings/arm/bcm/ns2.txt |    9 ++
 arch/arm64/Kconfig                                |   12 +++
 arch/arm64/boot/dts/Makefile                      |    1 +
 arch/arm64/boot/dts/broadcom/Makefile             |    5 ++
 arch/arm64/boot/dts/broadcom/ns2-svk.dts          |   55 ++++++++++++
 arch/arm64/boot/dts/broadcom/ns2.dtsi             |   95 +++++++++++++++++++++
 arch/arm64/configs/defconfig                      |    2 +
 drivers/pci/host/Kconfig                          |    2 +-
 drivers/pci/host/pcie-iproc.c                     |   12 +++
 drivers/pci/host/pcie-iproc.h                     |    2 +
 10 files changed, 194 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/arm/bcm/ns2.txt
 create mode 100644 arch/arm64/boot/dts/broadcom/Makefile
 create mode 100644 arch/arm64/boot/dts/broadcom/ns2-svk.dts
 create mode 100644 arch/arm64/boot/dts/broadcom/ns2.dtsi

-- 
1.7.9.5
