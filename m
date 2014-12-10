From: rjui@broadcom.com (Ray Jui)
Date: Tue, 9 Dec 2014 16:04:27 -0800
Subject: [PATCH 0/4] Add PCIe support to Broadcom iProc
In-Reply-To: <Ray Jui <rjui@broadcom.com>
References: <Ray Jui <rjui@broadcom.com>
Message-ID: <1418169871-19232-1-git-send-email-rjui@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset contains the initial PCIe support for Broadcom iProc family of
SoCs. This driver has been validated with Cygnus and NSP and is expected to
work on other iProc family of SoCs that deploy the same PCIe controller

Ray Jui (4):
  pci: iProc: define Broadcom iProc PCIe binding
  PCI: iproc: Add Broadcom iProc PCIe driver
  ARM: mach-bcm: Enable PCIe support for iProc
  ARM: dts: enable PCIe for Broadcom Cygnus

 .../devicetree/bindings/pci/brcm,iproc-pcie.txt    |   62 ++
 arch/arm/boot/dts/bcm-cygnus.dtsi                  |   43 +
 arch/arm/boot/dts/bcm958300k.dts                   |    8 +
 arch/arm/mach-bcm/Kconfig                          |    1 +
 drivers/pci/host/Kconfig                           |    9 +
 drivers/pci/host/Makefile                          |    1 +
 drivers/pci/host/pcie-iproc.c                      |  896 ++++++++++++++++++++
 7 files changed, 1020 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/brcm,iproc-pcie.txt
 create mode 100644 drivers/pci/host/pcie-iproc.c

-- 
1.7.9.5
