From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu,  2 Jun 2016 11:09:42 +0200
Subject: [PATCH 0/3] PCIe controller driver for Marvell Armada 3700
Message-ID: <1464858585-10963-1-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This small patch series adds a new driver for the PCIe controller
found on Marvell Armada 3700 ARM64 SoCs. Like any other new driver
submission, this patch series includes: a Device Tree binding
documentation patch, a patch adding the driver itself, and a patch
adding the Device Tree description of the hardware.

Thanks in advance for your reviews!

Thomas

Thomas Petazzoni (3):
  dt-bindings: add DT binding for the Aardvark PCIe controller
  PCI: host: new PCI host controller driver for Marvell Armada 3700
  arm64: dts: marvell: PCIe support for Armada 3700

 .../devicetree/bindings/pci/aardvark-pci.txt       |   51 +
 MAINTAINERS                                        |    7 +
 arch/arm64/boot/dts/marvell/armada-3720-db.dts     |    5 +
 arch/arm64/boot/dts/marvell/armada-37xx.dtsi       |   23 +
 drivers/pci/host/Kconfig                           |    9 +
 drivers/pci/host/Makefile                          |    1 +
 drivers/pci/host/pci-aardvark.c                    | 1029 ++++++++++++++++++++
 7 files changed, 1125 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/aardvark-pci.txt
 create mode 100644 drivers/pci/host/pci-aardvark.c

-- 
2.7.4
