From: rjui@broadcom.com (Ray Jui)
Date: Thu, 11 Dec 2014 18:36:53 -0800
Subject: [PATCH v2 0/4] Add PCIe support to Broadcom iProc
In-Reply-To: <Ray Jui <rjui@broadcom.com>
References: <Ray Jui <rjui@broadcom.com>
Message-ID: <1418351817-14898-1-git-send-email-rjui@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset contains the initial PCIe support for Broadcom iProc family of
SoCs. This driver has been validated with Cygnus and NSP and is expected to
work on other iProc family of SoCs that deploy the same PCIe controller

Changes from v1:
 - Add standard PCI interrupt DT properties "#interrupt-cells",
   "interrupt-map-mask" and "interrupt-map" so legacy INTx interrupts can be
   supported by using standard PCI OF IRQ parsing function
 - Get rid of custom IRQ mapping function in the driver. Use
   of_irq_parse_and_map_pci instead

Ray Jui (4):
  pci: iProc: define Broadcom iProc PCIe binding
  PCI: iproc: Add Broadcom iProc PCIe driver
  ARM: mach-bcm: Enable PCIe support for iProc
  ARM: dts: enable PCIe for Broadcom Cygnus

 .../devicetree/bindings/pci/brcm,iproc-pcie.txt    |   74 ++
 arch/arm/boot/dts/bcm-cygnus.dtsi                  |   52 ++
 arch/arm/boot/dts/bcm958300k.dts                   |    8 +
 arch/arm/mach-bcm/Kconfig                          |    1 +
 drivers/pci/host/Kconfig                           |    9 +
 drivers/pci/host/Makefile                          |    1 +
 drivers/pci/host/pcie-iproc.c                      |  888 ++++++++++++++++++++
 7 files changed, 1033 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/brcm,iproc-pcie.txt
 create mode 100644 drivers/pci/host/pcie-iproc.c

-- 
1.7.9.5
